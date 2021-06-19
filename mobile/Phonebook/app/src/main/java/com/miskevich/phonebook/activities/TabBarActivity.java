package com.miskevich.phonebook.activities;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.os.Bundle;
import android.os.StrictMode;
import android.preference.PreferenceManager;
import android.view.MenuItem;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.app.AppCompatDelegate;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.fragments.ContactsFragment;
import com.miskevich.phonebook.fragments.MapFragment;
import com.miskevich.phonebook.fragments.SettingsFragment;

import java.util.Locale;

public class TabBarActivity extends AppCompatActivity {
    private ContactsFragment contactsFragment;
    private MapFragment mapFragment;
    private SettingsFragment settingsFragment;
    private FragmentTransaction ft = getSupportFragmentManager().beginTransaction();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_tab_bar);

        BottomNavigationView mTabBarNav = findViewById(R.id.nav_view);

        contactsFragment = new ContactsFragment();
        mapFragment = new MapFragment();
        settingsFragment = new SettingsFragment();
        if (SettingsFragment.optionWasChange) {
            setTitle(R.string.title_settings);
            setFragment(settingsFragment, getString(R.string.title_settings));
            SettingsFragment.optionWasChange = false;
        } else {
            setTitle(R.string.title_phonebook);
            setFragment(contactsFragment, getString(R.string.title_phonebook));
        }

        mTabBarNav.setOnNavigationItemSelectedListener(item -> {
            switch (item.getItemId()){
                case R.id.navigation_phonebook: {
                    setTitle(R.string.title_phonebook);
                    setFragment(contactsFragment, getString(R.string.title_phonebook));
                    return true;
                }
                case R.id.navigation_map : {
                    setTitle(R.string.title_map);
                    setFragment(mapFragment, getString(R.string.title_map));
                    return true;
                }
                case R.id.navigation_settings : {
                    setTitle(R.string.title_settings);
                    setFragment(settingsFragment, getString(R.string.title_settings));
                    return true;
                }
                default: {
                    return false;
                }

            }
        });
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);
    }

    public void setFragment(Fragment fragment, String str){
        ft = getSupportFragmentManager().beginTransaction();
        ft.addToBackStack(str);
        if (str.equals(getString(R.string.title_settings)) || str.equals(getString(R.string.title_map))) {
            getSupportActionBar().setDisplayHomeAsUpEnabled(false);
        }
        ft.replace(R.id.host_fragment, fragment);
        ft.commit();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item){
        ft = getSupportFragmentManager().beginTransaction();
        int index = getSupportFragmentManager().getBackStackEntryCount() - 2;
        FragmentManager.BackStackEntry backEntry = getSupportFragmentManager().getBackStackEntryAt(index);
        String tag = backEntry.getName();
        getSupportActionBar().setDisplayHomeAsUpEnabled(!tag.equals(getString(R.string.title_phonebook)) && !tag.equals(getString(R.string.title_map)) && !tag.equals(getString(R.string.title_settings)));
        backEntry = getSupportFragmentManager().getBackStackEntryAt(index + 1);
        tag = backEntry.getName();
        getSupportFragmentManager().popBackStack();
        ft.commit();
        return true;
    }

    @Override
    protected void attachBaseContext(Context newBase) {
        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(newBase);
        String savedLocale = preferences.getString("language", null);
        Configuration configuration = newBase.getResources().getConfiguration();
        if (savedLocale != null){
            switch (savedLocale) {
                case "en": {
                    SettingsFragment.lang = 0;
                    break;
                }
                case "ru": {
                    SettingsFragment.lang = 1;
                    break;
                }
            }
            Locale locale = new Locale(savedLocale);
            Locale.setDefault(locale);
            configuration.setLocale(locale);
        }

        String savedStyle = preferences.getString("style", null);
        if (savedStyle != null){
            switch (savedStyle) {
                case "table": {
                    SettingsFragment.style = 0;
                    break;
                }
                case "list": {
                    SettingsFragment.style = 1;
                    break;
                }
            }
        }

        String savedTheme = preferences.getString("theme", null);
        if (savedTheme != null) {
            switch (savedTheme) {
                case "light": {
                    SettingsFragment.darkMode = AppCompatDelegate.MODE_NIGHT_NO;
                    AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_NO);
                    break;
                }
                case "dark": {
                    SettingsFragment.darkMode = AppCompatDelegate.MODE_NIGHT_YES;
                    AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_YES);
                    break;
                }
            }
        }

        super.attachBaseContext(newBase);
    }
}