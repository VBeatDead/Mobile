package com.example.storyapps

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.view.animation.AnimationUtils
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity

class SplashActivity : AppCompatActivity() {
    private val SPLASH_DELAY: Long = 3000
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        val splashLogo = findViewById<ImageView>(R.id.splashLogo)
        val bounceAnimation = AnimationUtils.loadAnimation(this, R.anim.bounce)
        splashLogo.startAnimation(bounceAnimation)

        Handler().postDelayed({
            val intent = Intent(this, LoginActivity::class.java)
            startActivity(intent)
            finish()
        }, SPLASH_DELAY)
    }
}