package com.example.storyapps.paging

import androidx.recyclerview.widget.DiffUtil
import com.example.storyapps.ListStoryItem

class StoryItemDiffCallback : DiffUtil.ItemCallback<ListStoryItem>() {
    override fun areItemsTheSame(oldItem: ListStoryItem, newItem: ListStoryItem): Boolean {
        return oldItem.id == newItem.id
    }

    override fun areContentsTheSame(oldItem: ListStoryItem, newItem: ListStoryItem): Boolean {
        return oldItem == newItem
    }
}