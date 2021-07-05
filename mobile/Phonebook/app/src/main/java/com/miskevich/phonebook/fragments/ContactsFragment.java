package com.miskevich.phonebook.fragments;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.miskevich.phonebook.adapters.ContactRecyclerViewAdapter;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.models.Contact;

import java.util.ArrayList;

import static com.miskevich.phonebook.activities.MainActivity.db;

public class ContactsFragment extends Fragment {
    static public ContactRecyclerViewAdapter recyclerViewAdapter;
    static View view;

    private static final String ARG_COLUMN_COUNT = "column-count";
    private static int mColumnCount = 2;
    private static final ArrayList<Contact> contactArrayList = new ArrayList<>();

    public static void loadData() {
        contactArrayList.clear();
        db.collection("phonebook")
                .get()
                .addOnCompleteListener(task -> {
                    if (task.isSuccessful()) {
                        for (QueryDocumentSnapshot document : task.getResult()) {
                            Contact contact = (Contact) document.toObject(Contact.class);
                            contact.id = document.getId();
                            contactArrayList.add(contact);
                        }
                    }
                    if (view != null) {
                        setData();
                    }
                });
    }

    public ContactsFragment() {

    }

    public static void setData() {
        View rv = view.findViewById(R.id.list);

        if (rv instanceof RecyclerView) {
            Context context = rv.getContext();
            RecyclerView recyclerView = (RecyclerView) rv;
            if (mColumnCount <= 1) {
                recyclerView.setLayoutManager(new LinearLayoutManager(context));
            } else {
                recyclerView.setLayoutManager(new GridLayoutManager(context, mColumnCount));
            }

            recyclerViewAdapter = new ContactRecyclerViewAdapter(contactArrayList);
            recyclerView.setAdapter(recyclerViewAdapter);
        }
    }

    public static ContactsFragment newInstance(int columnCount) {
        ContactsFragment fragment = new ContactsFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_COLUMN_COUNT, columnCount);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getArguments() != null) {
            mColumnCount = getArguments().getInt(ARG_COLUMN_COUNT);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_contacts, container, false);
        mColumnCount = SettingsFragment.style == 0 ? 2 : 1;
        loadData();
        setData();
        return view;
    }
}