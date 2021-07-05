package com.miskevich.phonebook.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Toast;

import androidx.fragment.app.Fragment;
import androidx.navigation.NavDirections;
import androidx.navigation.Navigation;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.textfield.TextInputEditText;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.activities.TabBarActivity;

import static com.miskevich.phonebook.activities.MainActivity.mAuth;

/**
 * A simple {@link androidx.fragment.app.Fragment} subclass.
 * Use the {@link SignInFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class SignInFragment extends Fragment {
    View v;

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters

    public SignInFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment SignInFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static SignInFragment newInstance(String param1, String param2) {
        SignInFragment fragment = new SignInFragment();
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
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_sign_in, container, false);
        v = view;

        FloatingActionButton createBtn = (FloatingActionButton) view.findViewById(R.id.btn_create_contact);
        createBtn.setOnClickListener(v -> btnCreateContactClick());

        Button loginBtn = (Button) view.findViewById(R.id.btn_sign_in);
        loginBtn.setOnClickListener(v -> btnSignInClick());

        return view;
    }

    public void btnSignInClick() {
        String email = ((TextInputEditText) v.findViewById(R.id.edit_text_email)).getText().toString();
        String password = ((TextInputEditText) v.findViewById(R.id.edit_text_password)).getText().toString();

        if (email.isEmpty() || password.isEmpty()) {
            Toast.makeText(getActivity(), R.string.all_fields,
                    Toast.LENGTH_SHORT).show();
        } else {
            mAuth.signInWithEmailAndPassword(email, password)
                    .addOnCompleteListener(task -> {
                        if (task.isSuccessful()) {
                            Intent intent = new Intent(getActivity(), TabBarActivity.class);
                            startActivity(intent);
                        } else {
                            Toast.makeText(getActivity(), R.string.something_went_wrong,
                                    Toast.LENGTH_SHORT).show();
                        }
                    });
        }
    }

    public void btnCreateContactClick() {
        NavDirections action = SignInFragmentDirections.actionSignInFragmentToRegistrationFragment();
        Navigation.findNavController(v).navigate(action);
    }
}
