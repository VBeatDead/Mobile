package com.example.storyapps

import android.animation.ValueAnimator
import android.app.ActivityOptions
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.os.Bundle
import android.view.animation.AccelerateInterpolator
import android.view.animation.TranslateAnimation
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.preferencesDataStore
import com.example.storyapps.databinding.ActivityRegisterBinding
import androidx.datastore.core.DataStore
import android.util.Pair
import android.view.animation.LinearInterpolator

class RegisterActivity : AppCompatActivity() {
    private lateinit var binding: ActivityRegisterBinding
    private lateinit var userRepo: UserRepo
    private lateinit var apiService: ApiService
    private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "user_prefs")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityRegisterBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val ivLogo = findViewById<ImageView>(R.id.ivLogo)
        val screenWidth = resources.displayMetrics.widthPixels.toFloat()
        val animator = ValueAnimator.ofFloat(
            -screenWidth / 3,
            screenWidth / -20
        )

        animator.duration = 8000
        animator.interpolator = LinearInterpolator()
        animator.repeatCount = 0
        animator.addUpdateListener { valueAnimator ->
            val value = valueAnimator.animatedValue as Float
            ivLogo.translationX = value
        }
        animator.start()

        val btnLoginNow = findViewById<TextView>(R.id.btnLoginNow)
        binding.btnLoginNow.setOnClickListener { view ->
            val ivLogo = findViewById<ImageView>(R.id.ivLogo)
            val screenWidth = resources.displayMetrics.widthPixels.toFloat()
            ivLogo.translationX = -screenWidth / 2
            val moveRightAnimation = TranslateAnimation(-screenWidth / 2, 0f, 0f, 0f)
            moveRightAnimation.duration = 500
            moveRightAnimation.interpolator = AccelerateInterpolator()
            val options = ActivityOptions.makeSceneTransitionAnimation(this, Pair(ivLogo, "logoTransition"))
            ivLogo.startAnimation(moveRightAnimation)
            val intent = Intent(this@RegisterActivity, LoginActivity::class.java)
            startActivity(intent, options.toBundle())
        }

        apiService = ApiConfig().getApiService()
        userRepo = UserRepo.getInstance(dataStore, apiService)
        binding.btnRegister.setOnClickListener {
            val name = binding.etName.text.toString()
            val email = binding.etEmail.text.toString()
            val password = binding.etPassword.text.toString()

            if (name.isEmpty()) {
                binding.etName.error = "Nama harus diisi"
                return@setOnClickListener
            }

            if (email.isEmpty()) {
                binding.etEmail.error = "Email harus diisi"
                return@setOnClickListener
            }

            if (!android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
                binding.etEmail.error = "Email tidak valid"
                return@setOnClickListener
            }

            if (password.isEmpty()) {
                binding.etPassword.error = "Password harus diisi"
                return@setOnClickListener
            }

            userRepo.register(name, email, password).observe(this) { result ->
                when (result) {
                    is Result.Loading -> {}
                    is Result.Success -> {
                        val registrationResponse = result.data
                        if (registrationResponse.error) {
                            val errorMessage = registrationResponse.message
                            runOnUiThread {
                                Toast.makeText(this@RegisterActivity, errorMessage, Toast.LENGTH_SHORT).show()
                            }
                        } else {
                            runOnUiThread {
                                Toast.makeText(this@RegisterActivity, "Registrasi berhasil!", Toast.LENGTH_SHORT).show()
                            }
                            val intent = Intent(this@RegisterActivity, LoginActivity::class.java)
                            startActivity(intent)
                            finish()
                        }
                    }
                    is Result.Error -> {
                        val errorMessage = result.error
                        runOnUiThread {
                            when {
                                errorMessage.contains("http 400 bad request", true) -> {
                                    Toast.makeText(this@RegisterActivity, "http 400 bad request", Toast.LENGTH_SHORT).show()
                                }
                                errorMessage.contains("email already exists", true) -> {
                                    Toast.makeText(this@RegisterActivity, "Email sudah terdaftar", Toast.LENGTH_SHORT).show()
                                }
                                else -> {
                                    Toast.makeText(this@RegisterActivity, errorMessage, Toast.LENGTH_SHORT).show()
                                }
                            }
                        }
                    }
                }
            }
        }
        if (!isNetworkAvailable()) {
            Toast.makeText(this, "Tidak terhubung ke internet", Toast.LENGTH_SHORT).show()
            return
        }
    }
    private fun isNetworkAvailable(): Boolean {
        val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetworkInfo = connectivityManager.activeNetworkInfo
        return activeNetworkInfo != null && activeNetworkInfo.isConnected
    }
}