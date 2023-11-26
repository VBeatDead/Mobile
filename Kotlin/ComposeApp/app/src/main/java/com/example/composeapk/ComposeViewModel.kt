package com.example.composeapk

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class ComposeViewModel(private val repository: infgameRepository) : ViewModel() {
    private val _query = mutableStateOf("")
    val query: State<String> get() = _query

    private val _infgame = MutableStateFlow<List<infgame>>(emptyList())
    val infgame: StateFlow<List<infgame>> get() = _infgame

    val filteredInfgames: List<infgame>
        get() = if (_query.value.isEmpty()) {
            infgame.value
        } else {
            infgame.value.filter { it.judul.contains(_query.value, ignoreCase = true) }
        }

    init {
        loadInfgames()
    }

    private fun loadInfgames() {
        _infgame.value = repository.getInfgames()
            .sortedBy { it.judul }
    }

    fun search(newQuery: String) {
        _query.value = newQuery
    }
}


class ViewModelFactory(private val repository: infgameRepository) :
    ViewModelProvider.NewInstanceFactory() {

    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(ComposeViewModel::class.java)) {
            return ComposeViewModel(repository) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class: " + modelClass.name)
    }
}