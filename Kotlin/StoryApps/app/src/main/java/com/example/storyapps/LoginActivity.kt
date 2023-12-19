package com.example.storyapps

import android.animation.ValueAnimator
import android.app.ActivityOptions
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.animation.AccelerateInterpolator
import android.view.animation.LinearInterpolator
import android.view.animation.TranslateAnimation
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.preferencesDataStore
import com.example.storyapps.databinding.ActivityLoginBinding
import androidx.datastore.core.DataStore
import android.util.Pair

class LoginActivity : AppCompatActivity() {
    private lateinit var binding: ActivityLoginBinding
    private lateinit var userRepo: UserRepo
    private lateinit var apiService: ApiService
    private lateinit var progressBar: ProgressBar
    private lateinit var sessionManager: SessionManager
    private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "user_prefs")

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityLoginBinding.inflate(layoutInflater)
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
        apiService = ApiConfig().getApiService()
        userRepo = UserRepo.getInstance(dataStore, apiService)
        progressBar = binding.progressBar
        sessionManager = SessionManager(this)

        if (sessionManager.isLoggedIn) {
            val intent = Intent(this@LoginActivity, MainActivity::class.java)
            startActivity(intent)
            finish()
        }

        binding.btnLogin.setOnClickListener {
            val email = binding.etEmail.text.toString()
            val password = binding.etPassword.text.toString()

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

            progressBar.visibility = View.VISIBLE
            binding.etEmail.error = null
            binding.etPassword.error = null

            userRepo.login(email, password).observe(this) { result ->
                when (result) {
                    is Result.Loading -> {
                    }
                    is Result.Success -> {
                        val loginResponse = result.data
                        val token = loginResponse.loginResult?.token
                        if (token != null) {
                            Log.d("LoginActivity", "Token: $token")
                            sessionManager.token = token
                            sessionManager.isLoggedIn = true

                            val intent = Intent(this@LoginActivity, MainActivity::class.java)
                            startActivity(intent)
                            finish()
                        }
                        progressBar.visibility = View.GONE
                    }

                    is Result.Error -> {
                        val errorMessage = result.error
                        runOnUiThread {
                            when {
                                errorMessage.contains("http 400 bad request", true) -> {
                                    Toast.makeText(this@LoginActivity, "http 400 bad request", Toast.LENGTH_SHORT).show()
                                }
                                errorMessage.contains("email not registered", true) -> {
                                    Toast.makeText(this@LoginActivity, "Email belum terdaftar", Toast.LENGTH_SHORT).show()
                                }
                                errorMessage.contains("email mismatch", true) -> {
                                    Toast.makeText(this@LoginActivity, "Email salah", Toast.LENGTH_SHORT).show()
                                }
                                errorMessage.contains("password mismatch", true) -> {
                                    Toast.makeText(this@LoginActivity, "Password salah", Toast.LENGTH_SHORT).show()
                                }
                                errorMessage.contains("http 401 unauthorized", true) -> {
                                    Toast.makeText(this@LoginActivity, "User tidak ditemukan", Toast.LENGTH_SHORT).show()
                                }
                                else -> {
                                    Toast.makeText(this@LoginActivity, errorMessage, Toast.LENGTH_SHORT).show()
                                }
                            }
                            progressBar.visibility = View.GONE
                        }
                    }
                }
            }
        }

        binding.btnRegister.setOnClickListener { view ->
            val ivLogo = findViewById<ImageView>(R.id.ivLogo)
            val moveRightAnimation = TranslateAnimation(0f, screenWidth, 0f, 0f)
            moveRightAnimation.duration = 500
            moveRightAnimation.interpolator = AccelerateInterpolator()
            val options = ActivityOptions.makeSceneTransitionAnimation(this, Pair(ivLogo, "logoTransition"))
            val intent = Intent(this@LoginActivity, RegisterActivity::class.java)
            startActivity(intent, options.toBundle())
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