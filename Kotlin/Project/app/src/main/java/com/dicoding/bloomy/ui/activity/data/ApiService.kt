package com.dicoding.bloomy.ui.activity.data

import com.dicoding.bloomy.ui.activity.data.grading.MarineGradingApi
import com.dicoding.bloomy.ui.activity.data.product.ProductService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RetrofitInstance {
    private const val BASE_URL = "https://api-service-vixypb3qiq-uc.a.run.app"
    private const val MODEL_API_URL = "https://api-model-vixypb3qiq-uc.a.run.app"

    val productService: ProductService by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ProductService::class.java)
    }

    val marineGradingService: MarineGradingApi by lazy {
        Retrofit.Builder()
            .baseUrl(MODEL_API_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(MarineGradingApi::class.java)
    }
}
