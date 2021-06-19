package com.miskevich.phonebook.adapters;

import android.annotation.SuppressLint;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.miskevich.phonebook.R;
import com.miskevich.phonebook.activities.TabBarActivity;
import com.miskevich.phonebook.models.Contact;
import com.miskevich.phonebook.fragments.ContactDetailsFragment;
import com.miskevich.phonebook.fragments.SettingsFragment;

import org.jetbrains.annotations.NotNull;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Objects;

import static com.miskevich.phonebook.fragments.SettingsFragment.fontSize;

public class ContactRecyclerViewAdapter extends RecyclerView.Adapter<ContactRecyclerViewAdapter.ViewHolder> {

    private final List<Contact> mValues;

    public ContactRecyclerViewAdapter(List<Contact> items) {
        mValues = items;
    }

    @NotNull
    @Override
    public ViewHolder onCreateViewHolder(@NotNull ViewGroup parent, int viewType) {
        View view;
        if (SettingsFragment.style == 0) {
            view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.fragment_contact_table, parent, false);
        } else {
            view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.fragment_contact_list, parent, false);
        }

        return new ViewHolder(view);
    }

    @SuppressLint("SetTextI18n")
    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        holder.mItem = mValues.get(position);
        holder.mImageView.setImageBitmap(getImageBitmap(mValues.get(position).images.get(0)));
        holder.mNameText.setText(mValues.get(position).firstName + " " + mValues.get(position).secondName);
        holder.mPhoneText.setText(mValues.get(position).phone);
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public static Bitmap getImageBitmap(String url) {
        Bitmap bm = null;
        try {
            URL aURL = new URL(url);
            URLConnection conn = aURL.openConnection();
            conn.connect();
            InputStream is = conn.getInputStream();
            BufferedInputStream bis = new BufferedInputStream(is);
            bm = BitmapFactory.decodeStream(bis);
            bis.close();
            is.close();
        } catch (IOException e) {
        }
        return bm;
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public final ImageView mImageView;
        public final TextView mNameText;
        public final TextView mPhoneText;
        public Contact mItem;

        public ViewHolder(View view) {
            super(view);
            mView = view;
            mImageView = view.findViewById(R.id.contact_avatar);
            mNameText = view.findViewById(R.id.contact_name);
            mPhoneText = view.findViewById(R.id.contact_phone);

            mPhoneText.setTextSize(fontSize);
            mNameText.setTextSize(fontSize);

            mView.setOnClickListener(v -> {
                TabBarActivity tabBarActivity = (TabBarActivity) view.getContext();
                ContactDetailsFragment contactDetailsFragment = new ContactDetailsFragment(mItem);
                tabBarActivity.setFragment(contactDetailsFragment, mItem.secondName);
                Objects.requireNonNull(tabBarActivity.getSupportActionBar()).setDisplayHomeAsUpEnabled(true);
            });
        }

        @NotNull
        @Override
        public String toString() {
            return super.toString() + " '" + mNameText.getText() + "'";
        }
    }
}