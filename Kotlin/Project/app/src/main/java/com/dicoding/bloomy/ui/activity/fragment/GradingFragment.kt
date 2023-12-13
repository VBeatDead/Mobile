package com.dicoding.bloomy.ui.activity.fragment

import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.fragment.app.Fragment
import com.dicoding.bloomy.R
import com.google.android.material.button.MaterialButton
import android.Manifest
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.material.snackbar.Snackbar
import androidx.fragment.app.FragmentTransaction

class GradingFragment : Fragment() {

    private val REQUEST_GALLERY_IMAGE = 1
    private val REQUEST_CAMERA_IMAGE = 2

    private lateinit var uploadedImage: ImageView

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.activity_fish_grading, container, false)

        uploadedImage = view.findViewById(R.id.uploadedImage)

        val buttonGaleri: MaterialButton = view.findViewById(R.id.buttongaleri)
        val buttonKamera: MaterialButton = view.findViewById(R.id.buttonkamera)
        val buttonGrading: MaterialButton = view.findViewById(R.id.buttongrading)

        buttonGaleri.setOnClickListener {
            openGallery()
        }

        buttonKamera.setOnClickListener {
            openCamera()
        }

        buttonGrading.setOnClickListener {
            redirectToResultFishGrading()
        }

        return view
    }

    private fun openGallery() {
        val intent = Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
        startActivityForResult(intent, REQUEST_GALLERY_IMAGE)
    }

    private fun openCamera() {
        if (ContextCompat.checkSelfPermission(
                requireContext(),
                Manifest.permission.CAMERA
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
            startActivityForResult(intent, REQUEST_CAMERA_IMAGE)
        } else {
            ActivityCompat.requestPermissions(
                requireActivity(),
                arrayOf(Manifest.permission.CAMERA),
                REQUEST_CAMERA_IMAGE
            )
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                REQUEST_GALLERY_IMAGE -> {
                    val selectedImageUri: Uri? = data?.data
                    uploadedImage.setImageURI(selectedImageUri)
                }

                REQUEST_CAMERA_IMAGE -> {
                    val photo = data?.extras?.get("data") as Bitmap
                    uploadedImage.setImageBitmap(photo)
                }
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        if (requestCode == REQUEST_CAMERA_IMAGE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                openCamera()
            } else {
                Snackbar.make(
                    requireView(),
                    "Izin kamera ditolak. Anda dapat memberikan izin melalui pengaturan aplikasi.",
                    Snackbar.LENGTH_LONG
                ).show()
            }
        }
    }

    private fun redirectToResultFishGrading() {
        val resultFishGradingFragment = ResultFishGradingFragment()
        val fragmentManager = requireActivity().supportFragmentManager
        val transaction: FragmentTransaction = fragmentManager.beginTransaction()

        transaction.replace(R.id.container, resultFishGradingFragment)
        transaction.addToBackStack(null)
        transaction.commit()
    }
}
