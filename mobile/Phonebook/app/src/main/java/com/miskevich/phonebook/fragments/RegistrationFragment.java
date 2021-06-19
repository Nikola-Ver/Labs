package com.miskevich.phonebook.fragments;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Toast;

import androidx.fragment.app.Fragment;
import androidx.navigation.NavDirections;
import androidx.navigation.Navigation;

import com.github.dhaval2404.imagepicker.ImagePicker;
import com.google.android.material.textfield.TextInputEditText;
import com.google.firebase.storage.StorageReference;
import com.miskevich.phonebook.R;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import de.hdodenhof.circleimageview.CircleImageView;

import static com.miskevich.phonebook.activities.MainActivity.db;
import static com.miskevich.phonebook.activities.MainActivity.imagesRef;
import static com.miskevich.phonebook.activities.MainActivity.mAuth;

/**
 * A simple {@link androidx.fragment.app.Fragment} subclass.
 * Use the {@link SignInFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class RegistrationFragment extends Fragment {
    private View v;

    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    public RegistrationFragment() {
        // Required empty public constructor
    }

    final Calendar myCalendar = Calendar.getInstance();
    Uri studentImageUri = null;

    public static RegistrationFragment newInstance(String param1, String param2) {
        RegistrationFragment fragment = new RegistrationFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_registration, container, false);
        v = view;
        Button button = view.findViewById(R.id.btn_create_contact);
        button.setOnClickListener(this::btnCreateClick);

        TextInputEditText TextInputEditText = view.findViewById(R.id.edit_text_birthday_create);
        DatePickerDialog.OnDateSetListener date = (view1, year, monthOfYear, dayOfMonth) -> {
            myCalendar.set(Calendar.YEAR, year);
            myCalendar.set(Calendar.MONTH, monthOfYear);
            myCalendar.set(Calendar.DAY_OF_MONTH, dayOfMonth);
            String myFormat = "MM/dd/yy";
            SimpleDateFormat sdf = new SimpleDateFormat(myFormat, Locale.US);
            TextInputEditText.setText(sdf.format(myCalendar.getTime()));
        };

        TextInputEditText.setOnClickListener(v -> new DatePickerDialog(getContext(), date, myCalendar
                .get(Calendar.YEAR), myCalendar.get(Calendar.MONTH),
                myCalendar.get(Calendar.DAY_OF_MONTH)).show());

        CircleImageView imageView = view.findViewById(R.id.avatar_picker_contact);
        imageView.setOnClickListener(v -> ImagePicker.Companion.with(this)
                .cropSquare()
                .start((resultCode, data) -> {
                    if (resultCode == Activity.RESULT_OK) {
                        Uri fileUri = data.getData();
                        imageView.setImageURI(fileUri);
                        studentImageUri = fileUri;
                    } else if (resultCode == ImagePicker.RESULT_ERROR) {
                        Toast.makeText(getContext(), "Image picker error", Toast.LENGTH_SHORT).show();
                    }
                    return null;
                }));

        SharedPreferences app_preferences = PreferenceManager.getDefaultSharedPreferences(getContext());
        int appColor = app_preferences.getInt("color", 0);

        if (appColor != 0) {
            button.setBackgroundColor(appColor);
        }

        return view;
    }

    public void btnCreateClick(View view) {
        TextInputEditText emailTextInputEditText = (TextInputEditText) getView().findViewById(R.id.edit_text_email_create);
        String email = emailTextInputEditText.getText().toString();
        String password = ((TextInputEditText) getView().findViewById(R.id.edit_text_password_create)).getText().toString();
        String firstName = ((TextInputEditText) getView().findViewById(R.id.edit_text_first_name_create)).getText().toString();
        String secondName = ((TextInputEditText) getView().findViewById(R.id.edit_text_second_name_create)).getText().toString();
        String patronymic = ((TextInputEditText) getView().findViewById(R.id.edit_text_patronymic_create)).getText().toString();
        String phone = ((TextInputEditText) getView().findViewById(R.id.edit_text_phone_create)).getText().toString();
        String birthday = ((TextInputEditText) getView().findViewById(R.id.edit_text_birthday_create)).getText().toString();

        if (email.isEmpty() || password.isEmpty() || firstName.isEmpty() || secondName.isEmpty() || patronymic.isEmpty() || phone.isEmpty() || birthday.isEmpty() || studentImageUri == null) {
            Toast.makeText(getActivity(), R.string.all_fields,
                    Toast.LENGTH_LONG).show();
            return;
        }

        StorageReference avatarRef = imagesRef.child(UUID.randomUUID() + ".jpg");
        avatarRef.putFile(studentImageUri)
                .addOnSuccessListener(taskSnapshot -> {
                    Map<String, Object> user = new HashMap<>();
                    user.put("firstName", firstName);
                    user.put("secondName", secondName);
                    user.put("patronymic", patronymic);
                    user.put("email", email);
                    user.put("phone", phone);
                    user.put("birthday", myCalendar.getTime());
                    user.put("videoUrl", "");
                    user.put("latitude", "");
                    user.put("longitude", "");

                    avatarRef.getDownloadUrl().addOnSuccessListener(uri -> {
                        ArrayList<String> images = new ArrayList<>();
                        images.add(uri.toString());
                        user.put("images", images);

                        db.collection("phonebook")
                                .add(user)
                                .addOnSuccessListener(documentReference -> mAuth.createUserWithEmailAndPassword(email, password)
                                        .addOnCompleteListener(getActivity(), task -> {
                                            if (task.isSuccessful()) {
                                                Toast.makeText(getActivity(), R.string.created,
                                                        Toast.LENGTH_LONG).show();
                                                NavDirections action = RegistrationFragmentDirections.actionRegistrationFragmentToSignInFragment();
                                                Navigation.findNavController(v).navigate(action);
                                            } else {
                                                System.out.println("createUserWithEmail:failure" + task.getException());
                                                Toast.makeText(getActivity(), R.string.something_went_wrong,
                                                        Toast.LENGTH_LONG).show();
                                            }
                                        }))
                                .addOnFailureListener(e -> Toast.makeText(getActivity(), R.string.something_went_wrong,
                                        Toast.LENGTH_SHORT).show());
                    });
                })
                .addOnFailureListener(exception -> Toast.makeText(getActivity(), exception.getLocalizedMessage(),
                        Toast.LENGTH_LONG).show());
    }
}
