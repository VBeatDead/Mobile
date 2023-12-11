package com.example.storyapps

import android.content.Context
import android.content.SharedPreferences

class SessionManager(context: Context) {
    private val sharedPreferences: SharedPreferences = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
    private val editor: SharedPreferences.Editor = sharedPreferences.edit()

    companion object {
        private const val PREF_NAME = "MyAppPrefs"
        private const val KEY_IS_LOGGED_IN = "isLoggedIn"
        private const val KEY_TOKEN = "token"
    }

    var isLoggedIn: Boolean
        get() = sharedPreferences.getBoolean(KEY_IS_LOGGED_IN, false)
        set(isLoggedIn) {
            editor.putBoolean(KEY_IS_LOGGED_IN, isLoggedIn)
            editor.apply()
        }

    var token: String?
        get() = sharedPreferences.getString(KEY_TOKEN, null)
        set(token) {
            editor.putString(KEY_TOKEN, token)
            editor.apply()
        }

    fun logout() {
        editor.remove(KEY_IS_LOGGED_IN)
        editor.remove(KEY_TOKEN)
        editor.apply()
    }

    fun getAuthToken(): String? {
        return sharedPreferences.getString(KEY_TOKEN, null)
    }
}