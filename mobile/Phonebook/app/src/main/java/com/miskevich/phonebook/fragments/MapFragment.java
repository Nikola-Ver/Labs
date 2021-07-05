package com.miskevich.phonebook.fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatDelegate;
import androidx.fragment.app.Fragment;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MapStyleOptions;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.activities.TabBarActivity;
import com.miskevich.phonebook.models.Contact;

import java.util.ArrayList;
import java.util.Objects;

public class MapFragment extends Fragment {

    private ArrayList<Contact> contactsArrayList;

    private final OnMapReadyCallback callback = googleMap -> {
        ArrayList<String> markers = new ArrayList<>(contactsArrayList.size());
        if (SettingsFragment.darkMode == AppCompatDelegate.MODE_NIGHT_YES)
        {
            googleMap.setMapStyle(MapStyleOptions.loadRawResourceStyle(this.getContext(), R.raw.dark));
        }

        for (int i = 0; i < contactsArrayList.size(); i++) {

            if (contactsArrayList.get(i).latitude.isEmpty()) {
                contactsArrayList.get(i).latitude = "0";
            }

            if (contactsArrayList.get(i).longitude.isEmpty()) {
                contactsArrayList.get(i).longitude = "0";
            }

            LatLng latLng = new LatLng(Double.parseDouble(contactsArrayList.get(i).latitude), Double.parseDouble(contactsArrayList.get(i).longitude));
            Marker marker = googleMap.addMarker(new MarkerOptions()
                    .position(latLng)
                    .title(contactsArrayList.get(i).firstName + " " + contactsArrayList.get(i).secondName));
            markers.add(marker.getId());
        }

        googleMap.moveCamera(CameraUpdateFactory.newLatLng(new LatLng(53.54, 27.34)));
        googleMap.setMinZoomPreference(8);

        googleMap.setOnInfoWindowClickListener(marker -> {
            if (markers.contains(marker.getId())) {
                ContactDetailsFragment elementFragment = new ContactDetailsFragment(contactsArrayList.get(markers.indexOf(marker.getId())));
                TabBarActivity appCompatActivity = (TabBarActivity) getActivity();
                Objects.requireNonNull(appCompatActivity.getSupportActionBar()).setDisplayHomeAsUpEnabled(true);
                appCompatActivity.setFragment(elementFragment, "");
            }
            marker.hideInfoWindow();
        });
    };

    public MapFragment(){
        contactsArrayList = new ArrayList<>();
        FirebaseFirestore db = FirebaseFirestore.getInstance();
        db.collection("phonebook")
                .get()
                .addOnCompleteListener(task -> {
                    if (task.isSuccessful()) {
                        for (QueryDocumentSnapshot document : task.getResult()) {
                            Contact contact = document.toObject(Contact.class);
                            contact.id = document.getId();
                            contactsArrayList.add(contact);
                        }
                    }
                });
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_map, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        SupportMapFragment mapFragment =
                (SupportMapFragment) getChildFragmentManager().findFragmentById(R.id.map);
        if (mapFragment != null) {
            mapFragment.getMapAsync(callback);
        }
    }
}