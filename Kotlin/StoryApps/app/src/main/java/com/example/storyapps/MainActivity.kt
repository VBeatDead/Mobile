package com.example.storyapps

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.storyapps.databinding.ActivityMainBinding
import com.example.storyapps.paging.StoryPagingAdapter
import com.example.storyapps.paging.StoryRepository
import com.example.storyapps.paging.StoryViewModel
import com.example.storyapps.paging.StoryViewModelFactory

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var sessionManager: SessionManager
    private lateinit var storyAdapter: StoryPagingAdapter
    private lateinit var storyViewModel: StoryViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        sessionManager = SessionManager(this)
        storyAdapter = StoryPagingAdapter()

        binding.rvStories.layoutManager = LinearLayoutManager(this)
        binding.rvStories.adapter = storyAdapter

        val sessionManager = SessionManager(this)
        val token: String? = sessionManager.token

        if (token != null) {
            val repository = StoryRepository(token)
            val viewModelFactory = StoryViewModelFactory(token, repository)
            storyViewModel = ViewModelProvider(this, viewModelFactory).get(StoryViewModel::class.java)

            storyViewModel.storyPagingData.observe(this) { pagingData ->
                storyAdapter.submitData(lifecycle, pagingData)
            }
        } else {
            showToast("Token is missing. Please log in.")
        }

        storyAdapter.onItemClickListener = { story ->
            val intent = Intent(this, DetailActivity::class.java)
            intent.putExtra(DetailActivity.EXTRA_STORY, story)
            startActivity(intent)
        }

        val btnLogout = findViewById<ImageView>(R.id.btnLogout)
        btnLogout.setOnClickListener {
            sessionManager.logout()
            val intent = Intent(this@MainActivity, LoginActivity::class.java)
            startActivity(intent)
            finish()
        }

        val btnAddStory = findViewById<ImageView>(R.id.btnAddStory)
        btnAddStory.setOnClickListener {
            val intent = Intent(this@MainActivity, AddStoryActivity::class.java)
            startActivity(intent)
        }
    }

    private fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    fun openMapsActivity(view: View) {
        val intent = Intent(this, MapsActivity::class.java)
        startActivity(intent)
    }
}
