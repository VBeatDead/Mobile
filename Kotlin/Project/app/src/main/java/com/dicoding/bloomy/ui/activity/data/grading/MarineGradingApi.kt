package com.dicoding.bloomy.ui.activity.data.grading

import okhttp3.MultipartBody
import retrofit2.Response
import retrofit2.http.Header
import retrofit2.http.Multipart
import retrofit2.http.POST
import retrofit2.http.Part

interface MarineGradingApi {

    @POST("/marine/predict")
    @Multipart
    suspend fun predictFishGrade(
        @Header("Authorization") authorization: String,
        @Part image: MultipartBody.Part
    ): MarineGradingResponse
}


