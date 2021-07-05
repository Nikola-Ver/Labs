package com.miskevich.phonebook.adapters;

import android.app.Activity;
import android.content.Context;
import android.net.Uri;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.appcompat.content.res.AppCompatResources;
import androidx.recyclerview.widget.RecyclerView;

import com.github.dhaval2404.imagepicker.ImagePicker;
import com.google.firebase.storage.StorageReference;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.activities.TabBarActivity;
import com.miskevich.phonebook.fragments.GalleryFragment;
import com.miskevich.phonebook.fragments.ImageFullFragment;
import com.miskevich.phonebook.models.Contact;

import org.jetbrains.annotations.NotNull;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import static com.miskevich.phonebook.adapters.ContactRecyclerViewAdapter.getImageBitmap;
import static com.miskevich.phonebook.fragments.ContactsFragment.loadData;
import static com.miskevich.phonebook.activities.MainActivity.db;
import static com.miskevich.phonebook.activities.MainActivity.imagesRef;

public class PhotoRecyclerViewAdapter extends RecyclerView.Adapter<PhotoRecyclerViewAdapter.ViewHolder> {

    private final List<String> images;
    Context context;
    GalleryFragment galleryFragment;
    Contact contact;

    public PhotoRecyclerViewAdapter(List<String> items, Context context, GalleryFragment galleryFragment, Contact contact) {
        images = items;
        this.context = context;
        this.galleryFragment = galleryFragment;
        this.contact = contact;
    }

    @NotNull
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.fragment_image, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NotNull final ViewHolder holder, int position) {
        if (position >= images.size()) {
            holder.mImageView.setImageDrawable(AppCompatResources.getDrawable(context, R.drawable.ic_photo_camera));
            DisplayMetrics displayMetrics = new DisplayMetrics();
            ((Activity) context).getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
            int width = displayMetrics.widthPixels;
            holder.mImageView.setMinimumWidth(width / 3);
            holder.mImageView.setMinimumHeight(width / 3);
        } else {
            holder.url = images.get(position);
            holder.mImageView.setImageBitmap(getImageBitmap(images.get(position)));
        }
    }

    @Override
    public int getItemCount() {
        return images.size() + 1;
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public final ImageView mImageView;
        public String url;

        public ViewHolder(View view) {
            super(view);
            mView = view;
            mImageView = view.findViewById(R.id.contact_image);

            mImageView.setOnClickListener(v -> {
                if (url == null ) {
                    ImagePicker.Companion.with((Activity) context)
                        .cropSquare()
                        .start((resultCode, data) -> {
                            if (resultCode == Activity.RESULT_OK) {
                                Uri fileUri = data.getData();

                                StorageReference avatarRef = imagesRef.child(UUID.randomUUID() + ".jpg");
                                avatarRef.putFile(fileUri)
                                    .addOnSuccessListener(taskSnapshot -> avatarRef.getDownloadUrl().addOnSuccessListener(uri -> {
                                        galleryFragment.images.add(uri.toString());

                                        Map<String, Object> user = new HashMap<>();
                                        user.put("images", galleryFragment.images);

                                        db.collection("phonebook")
                                                .document(contact.id)
                                                .update(user)
                                                .addOnSuccessListener(documentReference -> {
                                                    Toast.makeText((Activity) context, "Contact was updated.",
                                                            Toast.LENGTH_LONG).show();

                                                    galleryFragment.setData();
                                                    loadData();
                                                })
                                                .addOnFailureListener(e -> Toast.makeText(context,"Error adding document: " + e,
                                                        Toast.LENGTH_SHORT).show());
                                    }))
                                    .addOnFailureListener(exception -> Toast.makeText(context,exception.getLocalizedMessage(),
                                            Toast.LENGTH_LONG).show());

                            } else if (resultCode == ImagePicker.RESULT_ERROR) {
                                Toast.makeText(context, "Image picker error", Toast.LENGTH_SHORT).show();
                            } else {
                                Toast.makeText(context, "Task Cancelled", Toast.LENGTH_SHORT).show();
                            }
                            return null;
                        });
                } else  {
                    TabBarActivity tabBarActivity = (TabBarActivity) view.getContext();
                    ImageFullFragment imageFullFragment = new ImageFullFragment(url);
                    tabBarActivity.setFragment(imageFullFragment, "");
                    tabBarActivity.getSupportActionBar().setDisplayHomeAsUpEnabled(true);
                }
            });

        }

        @NotNull
        @Override
        public String toString() {
            return super.toString() + " '" + url;
        }
    }
}