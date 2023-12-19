package com.example.storyapps.paging

import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import com.example.storyapps.ApiService
import com.example.storyapps.ListStoryItem
import kotlinx.coroutines.flow.Flow

class StoryRepository(private val token: String) {
    private val apiService = RetrofitClient.createService(ApiService::class.java)

    fun getStoryPagingData(): Flow<PagingData<ListStoryItem>> {
        return Pager(
            config = PagingConfig(pageSize = 20, prefetchDistance = 2),
            pagingSourceFactory = { StoryPagingSource(apiService, token) }
        ).flow
    }
}