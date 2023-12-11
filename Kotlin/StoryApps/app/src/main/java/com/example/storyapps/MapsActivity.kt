package com.example.storyapps

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.LatLngBounds
import com.google.android.gms.maps.model.MarkerOptions
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import retrofit2.Response
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Spinner
import android.widget.Toast

class MapsActivity : AppCompatActivity(), OnMapReadyCallback {
    private lateinit var mMap: GoogleMap
    private val boundsBuilder = LatLngBounds.Builder()
    private lateinit var sessionManager: SessionManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_maps)

        sessionManager = SessionManager(this)

        val mapFragment = supportFragmentManager.findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)

        val mapThemeSpinner = findViewById<Spinner>(R.id.mapThemeSpinner)
        val themes = listOf("Normal", "Hybrid", "Terrain")

        val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, themes)
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        mapThemeSpinner.adapter = adapter

        mapThemeSpinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                val selectedTheme = themes[position]
                setMapTheme(selectedTheme)
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }
    }

    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap
        mMap.uiSettings.isZoomControlsEnabled = true
        mMap.uiSettings.isIndoorLevelPickerEnabled = true
        mMap.uiSettings.isCompassEnabled = true
        mMap.uiSettings.isMapToolbarEnabled = true

        GlobalScope.launch(Dispatchers.Main) {
            val response = getMaps()
            if (response != null && response.isSuccessful) {
                val body = response.body()
                val listStory = body?.listStory ?: emptyList()

                listStory.forEach { story ->
                    val latLng = LatLng(story!!.lat ?: 0.0, story.lon ?: 0.0)
                    mMap.addMarker(MarkerOptions().position(latLng).title(story.name))
                    boundsBuilder.include(latLng)
                }

                val bounds: LatLngBounds = boundsBuilder.build()
                mMap.animateCamera(
                    CameraUpdateFactory.newLatLngBounds(
                        bounds,
                        resources.displayMetrics.widthPixels,
                        resources.displayMetrics.heightPixels,
                        300
                    )
                )
            } else {
                showErrorMessage("Failed to fetch stories with location.")
            }
        }
    }

    private suspend fun getMaps(): Response<ResponseStories>? {
        val apiService = ApiConfig().getApiService()
        val token = sessionManager.token ?: ""
        return apiService.getMaps("Bearer $token")
    }

    private fun showErrorMessage(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    private fun setMapTheme(theme: String) {
        when (theme) {
            "Normal" -> mMap.mapType = GoogleMap.MAP_TYPE_NORMAL
            "Hybrid" -> mMap.mapType = GoogleMap.MAP_TYPE_HYBRID
            "Terrain" -> mMap.mapType = GoogleMap.MAP_TYPE_TERRAIN
        }
    }
}
