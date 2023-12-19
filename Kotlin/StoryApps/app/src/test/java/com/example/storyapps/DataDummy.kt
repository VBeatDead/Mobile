package com.example.storyapps

import com.example.storyapps.ListStoryItem

object DataDummy {

    fun generateDummyStoryResponse(): List<ListStoryItem> {
        val items: MutableList<ListStoryItem> = arrayListOf()
        for (i in 0..100) {
            val quote = ListStoryItem(
                "https://avatars.githubusercontent.com/u/71594935?s=400&u=2d803648ba08fc16959262dc8b2c1802ca501284&v=4",
                "2023-06-04",
                "Test",
                "Testing",
                107.6305251,
                -6.978778,
                "story-2WDh_axScG5U6zDl"
            )
            items.add(quote)
        }
        return items
    }
}