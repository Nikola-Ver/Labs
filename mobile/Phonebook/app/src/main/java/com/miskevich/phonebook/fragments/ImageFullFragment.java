package com.miskevich.phonebook.fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.fragment.app.Fragment;

import com.miskevich.phonebook.R;

import static com.miskevich.phonebook.adapters.ContactRecyclerViewAdapter.getImageBitmap;

public class ImageFullFragment extends Fragment {
    String image;

    public ImageFullFragment(String url) {
        image = url;
    }

    public ImageFullFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_image_full, container, false);
        ((ImageView)view.findViewById(R.id.image_full_size)).setImageBitmap(getImageBitmap(image));
        return view;
    }
}