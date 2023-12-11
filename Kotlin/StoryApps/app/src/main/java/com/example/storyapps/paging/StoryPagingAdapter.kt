package com.example.storyapps.paging

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.paging.PagingDataAdapter
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.storyapps.ListStoryItem
import com.example.storyapps.LoadingViewHolder
import com.example.storyapps.R

class StoryPagingAdapter : PagingDataAdapter<ListStoryItem, RecyclerView.ViewHolder>(StoryItemDiffCallback()) {

    var onItemClickListener: ((ListStoryItem) -> Unit)? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (viewType) {
            R.layout.list_story -> {
                val view = LayoutInflater.from(parent.context).inflate(R.layout.list_story, parent, false)
                ViewHolder(view)
            }
            R.layout.item_loading -> {
                val view = LayoutInflater.from(parent.context).inflate(R.layout.item_loading, parent, false)
                LoadingViewHolder(view)
            }
            else -> throw IllegalArgumentException("Invalid view type")
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        if (holder is ViewHolder) {
            val story = getItem(position)
            holder.bind(story)
        } else if (holder is LoadingViewHolder) {
            holder.showLoading()
        }
    }

    override fun getItemViewType(position: Int): Int {
        return if (getItem(position) != null) {
            R.layout.list_story
        } else {
            R.layout.item_loading
        }
    }

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val photoImageView: ImageView = itemView.findViewById(R.id.iv_item_photo)
        private val nameTextView: TextView = itemView.findViewById(R.id.tv_item_name)

        fun bind(story: ListStoryItem?) {
            story?.let {
                Glide.with(itemView.context)
                    .load(story.photoUrl)
                    .placeholder(R.drawable.stories)
                    .into(photoImageView)
                nameTextView.text = story.name

                // Handle item click
                itemView.setOnClickListener {
                    onItemClickListener?.invoke(story)
                }
            }
        }
    }

    companion object {
        val DIFF_CALLBACK = object : DiffUtil.ItemCallback<ListStoryItem>() {
            override fun areItemsTheSame(oldItem: ListStoryItem, newItem: ListStoryItem): Boolean {
                return oldItem == newItem
            }

            override fun areContentsTheSame(oldItem: ListStoryItem, newItem: ListStoryItem): Boolean {
                return oldItem.id == newItem.id
            }
        }
    }
}
