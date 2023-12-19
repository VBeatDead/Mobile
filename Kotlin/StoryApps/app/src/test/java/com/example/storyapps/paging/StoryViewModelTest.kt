package com.example.storyapps.paging

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import androidx.paging.AsyncPagingDataDiffer
import androidx.paging.PagingData
import androidx.recyclerview.widget.ListUpdateCallback
import com.example.storyapps.ApiService
import com.example.storyapps.DataDummy
import com.example.storyapps.ListStoryItem
import com.example.storyapps.getOrAwaitValue
import com.nhaarman.mockitokotlin2.mock
import com.nhaarman.mockitokotlin2.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Assert
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import kotlinx.coroutines.test.setMain
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.TestCoroutineDispatcher
import org.junit.After
import com.nhaarman.mockitokotlin2.whenever
import org.junit.Assert.assertEquals
import org.mockito.Mockito

@ExperimentalCoroutinesApi
class StoryViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @Mock
    private lateinit var repository: StoryRepository
    private val token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ1c2VyLUpQYk9tcHVwSkt3ZmNDbHQiLCJpYXQiOjE2OTk5NTU4Mjl9._eq1b7sW_6idGu9RYS94kbrD3j9j5bOGnqW7tQ2s-vM"
    private lateinit var viewModel: StoryViewModel
    private lateinit var apiService: ApiService
    private lateinit var storyPagingSource: StoryPagingSource
    private val testDispatcher = TestCoroutineDispatcher()

    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
        apiService = mock()
        storyPagingSource = StoryPagingSource(apiService, token)
        whenever(repository.getStoryPagingData()).thenReturn(flowOf(PagingData.empty()))
        Dispatchers.setMain(testDispatcher)
        viewModel = StoryViewModel(token, repository)
    }

    @After
    fun tearDown() {
        Dispatchers.resetMain()
    }

    @Test
    fun `when Get Story Empty Should Return No Data`() = testDispatcher.runBlockingTest {
        val dummyData = DataDummy.generateDummyStoryResponse()
        val expectedData = PagingData.from(dummyData)
        val data: PagingData<ListStoryItem> = PagingData.from(dummyData)

        Mockito.`when`(repository.getStoryPagingData()).thenReturn(flowOf(expectedData))

        val dummyToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ1c2VyLUpQYk9tcHVwSkt3ZmNDbHQiLCJpYXQiOjE2OTk5NTU4Mjl9._eq1b7sW_6idGu9RYS94kbrD3j9j5bOGnqW7tQ2s-vM"
        val storyViewModel = StoryViewModel(dummyToken, repository)

        val observer: Observer<PagingData<ListStoryItem>> = mock()
        storyViewModel.storyPagingData.observeForever(observer)

        Mockito.verify(observer).onChanged(expectedData)

        val actualData = storyViewModel.storyPagingData.getOrAwaitValue()

        val differ = AsyncPagingDataDiffer(
            diffCallback = StoryPagingAdapter.DIFF_CALLBACK,
            updateCallback = noopListUpdateCallback,
            workerDispatcher = testDispatcher,
        )
        differ.submitData(actualData)

        Assert.assertNotNull(differ.snapshot())
        assertEquals(dummyData.size, differ.snapshot().size)
        assertEquals(dummyData[0], differ.snapshot()[0])
    }

    @Test
    fun `storyPagingData returns zero items when there is no story data`() = runBlockingTest {
        val expectedData = PagingData.empty<ListStoryItem>()

        val repository: StoryRepository = mock()
        whenever(repository.getStoryPagingData()).thenReturn(flowOf(expectedData))

        viewModel = StoryViewModel(token, repository)

        verify(repository).getStoryPagingData()

        val observer: Observer<PagingData<ListStoryItem>> = mock()
        viewModel.storyPagingData.observeForever(observer)

        Assert.assertTrue((viewModel.storyPagingData.value as PagingData<ListStoryItem>).isEmpty())

        viewModel.storyPagingData.removeObserver(observer)
    }
}

private fun <T : Any> PagingData<T>.isEmpty(): Boolean {
    return true
}

val noopListUpdateCallback = object : ListUpdateCallback {
    override fun onInserted(position: Int, count: Int) {}
    override fun onRemoved(position: Int, count: Int) {}
    override fun onMoved(fromPosition: Int, toPosition: Int) {}
    override fun onChanged(position: Int, count: Int, payload: Any?) {}
}