package com.example.storyapps

import com.google.gson.annotations.SerializedName

data class LoginResponse(

	@field:SerializedName("loginResult")
	val loginResult: LoginResult? = null,

	@field:SerializedName("error")
	val error: Boolean,

	@field:SerializedName("message")
	val message: String
)

data class LoginResult(
	@field:SerializedName("token")
	val token: String
)

sealed class Result<out T> private constructor() {
	data class Success<out V>(val data: V) : Result<V>()
	data class Error(val error: String) : Result<Nothing>()
	object Loading : Result<Nothing>()
}