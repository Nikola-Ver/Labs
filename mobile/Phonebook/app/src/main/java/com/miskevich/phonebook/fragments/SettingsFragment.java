package com.miskevich.phonebook.fragments;

import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.SeekBar;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatDelegate;
import androidx.fragment.app.Fragment;

import com.google.android.material.switchmaterial.SwitchMaterial;
import com.miskevich.phonebook.activities.MainActivity;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.activities.TabBarActivity;

import java.util.Locale;

public class SettingsFragment extends Fragment {

    private View view;
    public static boolean optionWasChange = false;
    public static int darkMode = AppCompatDelegate.MODE_NIGHT_NO;
    public static int fontSize = 14;
    public static int lang = 0;
    public static int style = 0;

    public SettingsFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_settings, container, false);

        updateFontSize();
        SwitchMaterial modeSwitch = view.findViewById(R.id.theme_switch);

        modeSwitch.setChecked(darkMode == AppCompatDelegate.MODE_NIGHT_YES);

        modeSwitch.setOnCheckedChangeListener((buttonView, isChecked) -> {
            TabBarActivity tabBar = (TabBarActivity) getActivity();
            SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(tabBar);
            if (isChecked){
                preferences.edit().putString("theme", "dark").apply();
                AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_YES);
                darkMode = AppCompatDelegate.MODE_NIGHT_YES;
            } else {
                preferences.edit().putString("theme", "light").apply();
                AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_NO);
                darkMode = AppCompatDelegate.MODE_NIGHT_NO;
            }

            optionWasChange = true;
        });

        SeekBar seekBar = view.findViewById(R.id.seek_bar_font_size);
        seekBar.setProgress(fontSize);
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                fontSize = progress;
                updateFontSize();
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        RadioButton russianButton = view.findViewById(R.id.radio_ru);
        RadioButton englishButton = view.findViewById(R.id.radio_eng);
        switch (lang){
            case 0: {
                englishButton.setChecked(true);
                break;
            }
            case 1: {
                russianButton.setChecked(true);
                break;
            }
        }

        russianButton.setOnCheckedChangeListener((buttonView, isChecked) -> {
            if (isChecked){
                englishButton.setChecked(false);
                TabBarActivity tabBar = (TabBarActivity) getActivity();
                SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(tabBar);
                preferences.edit().putString("language", "ru").apply();
                optionWasChange = true;
                lang = 1;
                setLocale("ru");
            }
        });

        englishButton.setOnCheckedChangeListener((buttonView, isChecked) -> {
            if (isChecked){
                russianButton.setChecked(false);
                TabBarActivity tabBar = (TabBarActivity) getActivity();
                SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(tabBar);
                preferences.edit().putString("language", "en").apply();
                optionWasChange = true;
                lang = 0;
                setLocale("en");
            }
        });

        RadioButton tableButton = view.findViewById(R.id.radio_table);
        RadioButton listButton = view.findViewById(R.id.radio_list);
        switch (style){
            case 0: {
                tableButton.setChecked(true);
                break;
            }
            case 1: {
                listButton.setChecked(true);
                break;
            }
        }

        listButton.setOnCheckedChangeListener((buttonView, isChecked) -> {
            if (isChecked){
                tableButton.setChecked(false);
                TabBarActivity tabBar = (TabBarActivity) getActivity();
                SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(tabBar);
                preferences.edit().putString("style", "list").apply();
                optionWasChange = true;
                style = 1;
            }
        });

        tableButton.setOnCheckedChangeListener((buttonView, isChecked) -> {
            if (isChecked){
                listButton.setChecked(false);
                TabBarActivity tabBar = (TabBarActivity) getActivity();
                SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(tabBar);
                preferences.edit().putString("style", "table").apply();
                optionWasChange = true;
                style = 0;
            }
        });

        Button logoutButton = view.findViewById(R.id.logout_btn);
        logoutButton.setOnClickListener(v -> {
            TabBarActivity tabBar = (TabBarActivity) getActivity();
            Intent myIntent = new Intent(tabBar, MainActivity.class);
            startActivity(myIntent);
        });

        return view;
    }

    public void setLocale(String lang) {
        Locale myLocale = new Locale(lang);
        Resources res = getResources();
        DisplayMetrics dm = res.getDisplayMetrics();
        Configuration conf = res.getConfiguration();
        conf.locale = myLocale;
        res.updateConfiguration(conf, dm);
        getActivity().recreate();
    }

    public void updateFontSize(){
        TextView fontLabel = view.findViewById(R.id.font_size);
        fontLabel.setText(String.valueOf(fontSize));
        fontLabel.setTextSize(fontSize);
        TextView modeLabel = view.findViewById(R.id.text_theme);
        modeLabel.setTextSize(fontSize);
        modeLabel = view.findViewById(R.id.text_font_size);
        modeLabel.setTextSize(fontSize);
        modeLabel = view.findViewById(R.id.text_lang);
        modeLabel.setTextSize(fontSize);
        modeLabel = view.findViewById(R.id.text_style);
        modeLabel.setTextSize(fontSize);

        RadioButton russianButton = view.findViewById(R.id.radio_ru);
        russianButton.setTextSize(fontSize);
        RadioButton englishButton = view.findViewById(R.id.radio_eng);
        englishButton.setTextSize(fontSize);

        RadioButton tableButton = view.findViewById(R.id.radio_table);
        tableButton.setTextSize(fontSize);
        RadioButton listButton = view.findViewById(R.id.radio_list);
        listButton.setTextSize(fontSize);
    }
}