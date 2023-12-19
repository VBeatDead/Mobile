package com.example.storyapps.paging

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.paging.PagingData
import androidx.lifecycle.asLiveData
import com.example.storyapps.ListStoryItem

class StoryViewModel(token: String, repository: StoryRepository) : ViewModel() {
    val storyPagingData: LiveData<PagingData<ListStoryItem>> = repository.getStoryPagingData().asLiveData()
}
