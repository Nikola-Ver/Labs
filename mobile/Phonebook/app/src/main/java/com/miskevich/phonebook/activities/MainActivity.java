package com.miskevich.phonebook.activities;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.os.Bundle;
import android.preference.PreferenceManager;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.app.AppCompatDelegate;
import androidx.appcompat.widget.Toolbar;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.fragment.NavHostFragment;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;
import com.miskevich.phonebook.R;
import com.miskevich.phonebook.fragments.SettingsFragment;

import java.util.Locale;

public class MainActivity extends AppCompatActivity {
    AppBarConfiguration appBarConfiguration;
    public static FirebaseAuth mAuth;
    public static FirebaseFirestore db = FirebaseFirestore.getInstance();
    public static StorageReference mStorageRef = FirebaseStorage.getInstance().getReference();
    public static StorageReference imagesRef = mStorageRef.child("images");
    public static StorageReference videosRef = mStorageRef.child("videos");

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar myToolbar = findViewById(R.id.toolbar);
        setSupportActionBar(myToolbar);

        NavHostFragment navHostFragment = (NavHostFragment) getSupportFragmentManager().findFragmentById(R.id.nav_tab_host_fragment);
        NavController navController = navHostFragment.getNavController();

        appBarConfiguration = new AppBarConfiguration.Builder(navController.getGraph()).build();
        NavigationUI.setupActionBarWithNavController(this, navController, appBarConfiguration);

        mAuth = FirebaseAuth.getInstance();
    }

    @Override
    public boolean onSupportNavigateUp() {
        NavController navController = Navigation.findNavController(this, R.id.nav_tab_host_fragment);
        return NavigationUI.navigateUp(navController, appBarConfiguration)
                || super.onSupportNavigateUp();
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

        String savedTheme = preferences.getString("theme", null);
        if (savedTheme != null){
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