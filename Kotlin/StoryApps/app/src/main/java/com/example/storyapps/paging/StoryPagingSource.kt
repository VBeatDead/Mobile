package com.example.storyapps.paging

import androidx.paging.PagingData
import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.example.storyapps.ApiService
import com.example.storyapps.ListStoryItem
import com.example.storyapps.ResponseStories

class StoryPagingSource(private val apiService: ApiService, private val token: String) : PagingSource<Int, ListStoryItem>() {

    companion object {
        fun snapshot(items: List<ListStoryItem>): PagingData<ListStoryItem> {
            return PagingData.from(items)
        }
    }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, ListStoryItem> {
        try {
            val page = params.key ?: 1
            val response: ResponseStories = apiService.getStories("Bearer $token", page, params.loadSize)

            val stories: List<ListStoryItem> = response.listStory?.filterNotNull() ?: emptyList()
            val prevKey = if (page == 1) null else page - 1
            val nextKey = if (stories.isEmpty()) null else page + 1

            return LoadResult.Page(stories, prevKey, nextKey)
        } catch (e: Exception) {
            return LoadResult.Error(e)
        }
    }

    override fun getRefreshKey(state: PagingState<Int, ListStoryItem>): Int? {
        return 1
    }
}
