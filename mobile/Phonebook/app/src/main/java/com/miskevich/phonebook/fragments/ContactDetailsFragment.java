package com.miskevich.phonebook.fragments;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Toast;
import android.widget.VideoView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.google.android.material.textfield.TextInputEditText;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;
import com.miskevich.phonebook.activities.MainActivity;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.activities.TabBarActivity;
import com.miskevich.phonebook.models.Contact;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

import static android.app.Activity.RESULT_OK;
import static com.miskevich.phonebook.fragments.ContactsFragment.loadData;
import static com.miskevich.phonebook.activities.MainActivity.db;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ContactDetailsFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ContactDetailsFragment extends Fragment {
    private static final String ARG_PARAM1 = "contactData";

    final Calendar myCalendar = Calendar.getInstance();
    Uri contactImageUri = null;
    Uri contactVideoUri = null;
    View v;

    private Contact contactData;

    public ContactDetailsFragment() {
    }

    public ContactDetailsFragment(Contact student) {
        contactData = student;
    }

    public static ContactDetailsFragment newInstance(Contact studentData) {
        ContactDetailsFragment fragment = new ContactDetailsFragment(studentData);
        Bundle args = new Bundle();
        args.putSerializable(ARG_PARAM1, studentData);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            contactData = (Contact) getArguments().getSerializable(ARG_PARAM1);
        }
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        Contact contact = contactData;
        myCalendar.setTime(contact.birthday);
        EditText birthdayEdit = view.findViewById(R.id.birthday_edit);
        String myFormat = "MM/dd/yy";
        SimpleDateFormat sdf = new SimpleDateFormat(myFormat, Locale.US);
        birthdayEdit.setText(sdf.format(myCalendar.getTime()));
        ((TextInputEditText) view.findViewById(R.id.first_name_edit)).setText(contact.firstName);
        ((TextInputEditText) view.findViewById(R.id.second_name_edit)).setText(contact.secondName);
        ((TextInputEditText) view.findViewById(R.id.patronymic_edit)).setText(contact.patronymic);
        ((TextInputEditText) view.findViewById(R.id.phone_edit)).setText(contact.phone);
        ((TextInputEditText) view.findViewById(R.id.latitude_edit)).setText(contact.latitude);
        ((TextInputEditText) view.findViewById(R.id.longitude_edit)).setText(contact.longitude);
        VideoView videoView = view.findViewById(R.id.videoView);

        if (!contact.videoUrl.isEmpty()) {
            videoView.setVideoURI(Uri.parse(contact.videoUrl));
            videoView.start();
        }

        contactImageUri = Uri.parse(contact.images.get(0));
    }

    public void btnSaveClick(View view) {
        String firstName = ((TextInputEditText) getView().findViewById(R.id.first_name_edit)).getText().toString();
        String secondName = ((TextInputEditText) getView().findViewById(R.id.second_name_edit)).getText().toString();
        String patronymic = ((TextInputEditText) getView().findViewById(R.id.patronymic_edit)).getText().toString();
        String phone = ((TextInputEditText) getView().findViewById(R.id.phone_edit)).getText().toString();
        String birthday = ((TextInputEditText) getView().findViewById(R.id.birthday_edit)).getText().toString();
        String latitude = ((TextInputEditText) getView().findViewById(R.id.latitude_edit)).getText().toString();
        String longitude = ((TextInputEditText) getView().findViewById(R.id.longitude_edit)).getText().toString();

        if (firstName.isEmpty() || secondName.isEmpty() || patronymic.isEmpty() || phone.isEmpty() || birthday.isEmpty()) {
            Toast.makeText(getActivity(), R.string.all_fields,
                    Toast.LENGTH_LONG).show();
            return;
        }

        Map<String, Object> user = new HashMap<>();
        user.put("firstName", firstName);
        user.put("secondName", secondName);
        user.put("patronymic", patronymic);
        user.put("phone", phone);
        user.put("birthday", myCalendar.getTime());
        user.put("latitude", latitude);
        user.put("longitude", longitude);

        db.collection("phonebook")
            .document(contactData.id)
            .update(user)
            .addOnSuccessListener(documentReference -> {
                Toast.makeText(getActivity(), R.string.updated,
                        Toast.LENGTH_LONG).show();

                loadData();
            })
            .addOnFailureListener(e -> Toast.makeText(getActivity(),R.string.something_went_wrong,
                    Toast.LENGTH_SHORT).show());
    }

    private void loadVideo(View view) {
        try {
            Intent videoPicker = new Intent(Intent.ACTION_PICK);
            videoPicker.setType("video/*");
            startActivityForResult(videoPicker, 2);
        } catch (Exception exception) {
            Toast.makeText(getActivity(),exception.getLocalizedMessage(),
                    Toast.LENGTH_LONG).show();
        }
    }

    private void showGallery(View view) {
        TabBarActivity tabBarActivity = (TabBarActivity) view.getContext();
        GalleryFragment galleryFragment = new GalleryFragment(contactData.images, contactData);
        tabBarActivity.setFragment(galleryFragment, "");
        Objects.requireNonNull(tabBarActivity.getSupportActionBar()).setDisplayHomeAsUpEnabled(true);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == 2) {
            if (resultCode == RESULT_OK) {
                final Uri videoUri = data.getData();

                String videoName = UUID.randomUUID().toString();
                StorageReference videoRef = MainActivity.videosRef.child(videoName);

                UploadTask uploadTask = videoRef.putFile(videoUri);
                uploadTask.continueWithTask(task -> {
                    if (!task.isSuccessful()) {
                        throw task.getException();
                    }

                    return videoRef.getDownloadUrl();
                }).addOnCompleteListener(task -> {

                    if (task.isSuccessful()) {
                        contactVideoUri = task.getResult();
                        Map<String, Object> user = new HashMap<>();
                        user.put("videoUrl", String.valueOf(task.getResult()));

                        db.collection("phonebook")
                                .document(contactData.id)
                                .update(user)
                                .addOnSuccessListener(documentReference -> {
                                    Toast.makeText(getActivity(), R.string.updated,
                                            Toast.LENGTH_LONG).show();

                                    VideoView videoView = v.findViewById(R.id.videoView);

                                    videoView.setVideoURI(contactVideoUri);
                                    videoView.start();

                                    loadData();
                                })
                                .addOnFailureListener(e -> Toast.makeText(getActivity(), R.string.something_went_wrong,
                                        Toast.LENGTH_SHORT).show());
                    }
                });
            }
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_contact_details, container, false);
        v = view;

        TextInputEditText edittext= view.findViewById(R.id.birthday_edit);
        DatePickerDialog.OnDateSetListener date = (view1, year, monthOfYear, dayOfMonth) -> {
            myCalendar.set(Calendar.YEAR, year);
            myCalendar.set(Calendar.MONTH, monthOfYear);
            myCalendar.set(Calendar.DAY_OF_MONTH, dayOfMonth);
            String myFormat = "MM/dd/yy";
            SimpleDateFormat sdf = new SimpleDateFormat(myFormat, Locale.US);
            edittext.setText(sdf.format(myCalendar.getTime()));
        };

        edittext.setOnClickListener(v -> new DatePickerDialog(getContext(), date, myCalendar
                .get(Calendar.YEAR), myCalendar.get(Calendar.MONTH),
                myCalendar.get(Calendar.DAY_OF_MONTH)).show());

        view.findViewById(R.id.btn_save).setOnClickListener(this::btnSaveClick);
        view.findViewById(R.id.btn_load_video).setOnClickListener(this::loadVideo);
        view.findViewById(R.id.btn_gallery).setOnClickListener(this::showGallery);

        return view;
    }
}