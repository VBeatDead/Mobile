package com.example.storyapps

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.ProgressBar
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide

class StoryAdapter(
    private val stories: MutableList<ListStoryItem?>,
    private var isLoading: Boolean
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private val VIEW_TYPE_ITEM = 0
    private val VIEW_TYPE_LOADING = 1

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            VIEW_TYPE_ITEM -> {
                val view = LayoutInflater.from(parent.context).inflate(R.layout.list_story, parent, false)
                ViewHolder(view)
            }
            VIEW_TYPE_LOADING -> {
                val view = LayoutInflater.from(parent.context).inflate(R.layout.item_loading, parent, false)
                LoadingViewHolder(view)
            }
            else -> throw IllegalArgumentException("Invalid view type")
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is ViewHolder) {
            val story = stories[position]
            holder.bind(story)
        } else if (holder is LoadingViewHolder) {
            holder.showLoading()
        }
    }

    override fun getItemCount(): Int {
        return stories.size + if (isLoading) 1 else 0
    }

    override fun getItemViewType(position: Int): Int {
        return if (position < stories.size) VIEW_TYPE_ITEM else VIEW_TYPE_LOADING
    }

    fun addStories(newStories: List<ListStoryItem?>) {
        stories.addAll(newStories)
        notifyDataSetChanged()
    }

    fun clearStories() {
        stories.clear()
        notifyDataSetChanged()
    }

    fun setLoading(isLoading: Boolean) {
        this.isLoading = isLoading
        notifyDataSetChanged()
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val photoImageView: ImageView = itemView.findViewById(R.id.iv_item_photo)
        private val nameTextView: TextView = itemView.findViewById(R.id.tv_item_name)

        fun bind(story: ListStoryItem?) {
            story?.let {
                story.photoUrl?.let { url ->
                    Glide.with(itemView.context)
                        .load(url)
                        .placeholder(R.drawable.stories)
                        .into(photoImageView)
                }
                nameTextView.text = story.name
            }
        }
    }
}

class LoadingViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    private val progressBar: ProgressBar = itemView.findViewById(R.id.progressBar)

    fun showLoading() {
        progressBar.visibility = View.VISIBLE
    }

    fun hideLoading() {
        progressBar.visibility = View.GONE
    }
}