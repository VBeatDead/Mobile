package com.dicoding.bloomy.ui.activity.data.grading

data class MarineGradingResponse(
    val status: MarineStatus
)

data class MarineStatus(
    val code: Int,
    val message: String,
    val data: MarineData?
)

data class MarineData(
    val marineClass: String,
    val grade: String
)
