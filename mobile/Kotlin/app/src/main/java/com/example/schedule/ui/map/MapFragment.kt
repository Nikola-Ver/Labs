package com.example.schedule.ui.map

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.example.schedule.R
import com.google.android.gms.maps.*
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions

class MapFragment : Fragment(), OnMapReadyCallback {
    private lateinit var mView: View
    private lateinit var mMapView: MapView
    private lateinit var mMap: GoogleMap

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        mView = inflater.inflate(R.layout.fragment_map, container, false)
        return mView
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
//        mMapView = mView.findViewById(R.id.map)
//        if (mMapView != null) {
//            mMapView.onCreate(null)
//            mMapView.onResume()
//            mMapView.getMapAsync(this)
//        }
    }

    override fun onMapReady(googleMap: GoogleMap) {
//        mMap = googleMap
//        val sydney = LatLng(-34.0, 151.0)
//        mMap.addMarker(MarkerOptions().position(sydney).title("Marker in Sydney"))
//        mMap.moveCamera(CameraUpdateFactory.newLatLng(sydney))
    }
}