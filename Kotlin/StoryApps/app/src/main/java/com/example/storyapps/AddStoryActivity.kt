package com.example.storyapps

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.lifecycleScope
import com.bumptech.glide.Glide
import com.example.storyapps.databinding.ActivityAddStoryBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody
import retrofit2.HttpException
import java.io.File
import java.io.IOException
import com.google.gson.Gson

class AddStoryActivity : AppCompatActivity() {

    private lateinit var binding: ActivityAddStoryBinding
    private lateinit var selectedImageUri: Uri
    private lateinit var apiService: ApiService
    private lateinit var sessionManager: SessionManager
    private var currentPhotoPath: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAddStoryBinding.inflate(layoutInflater)
        setContentView(binding.root)
        apiService = ApiConfig().getApiService()
        sessionManager = SessionManager(this)

        binding.btnAddPhoto.setOnClickListener {
            openImageChooser()
        }

        binding.btnAdd.setOnClickListener {
            if (sessionManager.isLoggedIn) {
                if (isNetworkAvailable()) {
                    if (::selectedImageUri.isInitialized) {
                        uploadStory()
                    } else {
                        showToast("Anda harus memilih gambar terlebih dahulu sebelum mengunggah cerita.")
                    }
                } else {
                    showToast("Tidak terhubung ke internet. Silakan periksa koneksi Anda.")
                }
            } else {
                showToast("Anda harus login terlebih dahulu.")
            }
        }

        binding.btnCamera.setOnClickListener {
            dispatchTakePictureIntent()
        }

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
            != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA),
                CAMERA_PERMISSION_REQUEST)
        }
    }

    private fun openImageChooser() {
        val permission = Manifest.permission.READ_MEDIA_IMAGES
        if (ContextCompat.checkSelfPermission(this, permission) == PackageManager.PERMISSION_GRANTED) {
            val intent = Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
            startActivityForResult(intent, REQUEST_IMAGE_PICK)
        } else {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(permission),
                READ_MEDIA_IMAGES_PERMISSION_REQUEST
            )
        }
    }

    private fun isNetworkAvailable(): Boolean {
        val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetworkInfo = connectivityManager.activeNetworkInfo
        return activeNetworkInfo != null && activeNetworkInfo.isConnected
    }

    private fun dispatchTakePictureIntent() {
        val intent = Intent(this, CameraActivity::class.java)
        startActivityForResult(intent, REQUEST_IMAGE_CAPTURE)
    }

    private fun uploadStory() {
        val description = binding.edAddDescription.text.toString()

        if (description.isEmpty()) {
            showToast("Description cannot be empty.")
            return
        }

        binding.progressBar.visibility = View.VISIBLE
        val imageFile = File(selectedImageUri.path ?: "")
        val compressedImageFile = imageFile.reduceFileImage()

        if (compressedImageFile.length() > MAX_FILE_SIZE) {
            showToast("Compressed image is still too large.")
            return
        }

        if (!imageFile.exists()) {
            showToast("Selected image file does not exist.")
            return
        }

        val imageRequestBody = RequestBody.create("image/*".toMediaTypeOrNull(), compressedImageFile)
        val descriptionRequestBody = RequestBody.create("text/plain".toMediaTypeOrNull(), description)
        val token = sessionManager.getAuthToken()

        if (token.isNullOrEmpty()) {
            showToast("Token is not available or not valid. Please log in again.")
            return
        }

        val imagePart = MultipartBody.Part.createFormData("photo", compressedImageFile.name, imageRequestBody)

        lifecycleScope.launch {
            try {
                val response = withContext(Dispatchers.IO) {
                    apiService.uploadStory("Bearer $token", imagePart, descriptionRequestBody)
                }
                if (response.error) {
                    showToast("Failed to upload the story: ${response.message}")
                } else {
                    showToast("Story uploaded successfully.")
                    finish()
                }
            } catch (e: HttpException) {
                val errorBody = e.response()?.errorBody()?.string()
                val errorResponse = Gson().fromJson(errorBody, UploadResponse::class.java)
                showToast("Upload failed: ${errorResponse.message}")
            } catch (e: IOException) {
                showToast("Network error.")
            } finally {
                binding.progressBar.visibility = View.GONE
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int, permissions: Array<out String>, grantResults: IntArray
    ) {
        when (requestCode) {
            READ_MEDIA_IMAGES_PERMISSION_REQUEST -> {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    openImageChooser()
                } else {
                    showToast("Izin akses galeri ditolak.")
                }
            }
            else -> {
                super.onRequestPermissionsResult(requestCode, permissions, grantResults)
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK) {
            when (requestCode) {
                REQUEST_IMAGE_PICK -> {
                    if (data != null) {
                        selectedImageUri = data.data!!
                        val filePath = getImageFilePath(selectedImageUri)
                        if (filePath != null) {
                            val destinationFile = File(filesDir, "selected_image.jpg")
                            copyFile(File(filePath), destinationFile)
                            selectedImageUri = Uri.fromFile(destinationFile)
                            Glide.with(this).load(selectedImageUri).into(binding.ivAddPhoto)
                        } else {
                            showToast("Error: Image file not found.")
                        }
                    }
                }

                REQUEST_IMAGE_CAPTURE -> {
                    if (data != null && data.hasExtra("picture")) {
                        val photoFile = data.getSerializableExtra("picture") as File
                        selectedImageUri = Uri.fromFile(photoFile)
                        Glide.with(this).load(selectedImageUri).into(binding.ivAddPhoto)
                    } else {
                        showToast("Error: Image file not found.")
                    }
                }
            }
        }
    }

    private fun copyFile(sourceFile: File, destinationFile: File) {
        try {
            sourceFile.inputStream().use { input ->
                destinationFile.outputStream().use { output ->
                    input.copyTo(output)
                }
            }
        } catch (e: Exception) {
            showToast("Error image: ${e.message}")
        }
    }

    private fun getImageFilePath(uri: Uri?): String? {
        val projection = arrayOf(MediaStore.Images.Media.DATA)
        val cursor = uri?.let { contentResolver.query(it, projection, null, null, null) }
        if (cursor != null) {
            val columnIndex = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
            cursor.moveToFirst()
            val filePath = cursor.getString(columnIndex)
            cursor.close()
            return filePath
        }
        return uri?.path
    }

    private fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    companion object {
        private const val REQUEST_IMAGE_PICK = 1
        private const val REQUEST_IMAGE_CAPTURE = 2
        private const val CAMERA_PERMISSION_REQUEST = 101
        private const val READ_MEDIA_IMAGES_PERMISSION_REQUEST = 102
        private const val READ_EXTERNAL_STORAGE_PERMISSION_REQUEST = 103
        private const val MAX_FILE_SIZE = 1 * 1024 * 1024
    }
}