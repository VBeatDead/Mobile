package com.example.storyapps

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide
import com.example.storyapps.databinding.ActivityDetailBinding

class DetailActivity : AppCompatActivity() {
    private lateinit var binding: ActivityDetailBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDetailBinding.inflate(layoutInflater)
        setContentView(binding.root)
        val story = intent.getSerializableExtra(EXTRA_STORY) as? ListStoryItem

        story?.let {
            Glide.with(this)
                .load(story.photoUrl)
                .placeholder(R.drawable.stories)
                .into(binding.ivDetailPhoto)

            binding.tvDetailName.text = story.name
            binding.tvDetailDescription.text = story.description
        }
    }

    companion object {
        const val EXTRA_STORY = "extra_story"
    }
}