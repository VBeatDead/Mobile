package com.example.composeapk

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.navigation.compose.rememberNavController
import com.example.composeapk.ui.theme.testthm
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            testthm {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    val navController = rememberNavController()

                    NavHost(
                        navController = navController,
                        startDestination = "infgameList"
                    ) {
                        composable("infgameList") {
                            ComposeApp(navController = navController)
                        }

                        composable("infgameDetail/{infgameId}") { backStackEntry ->
                            val infgameId = backStackEntry.arguments?.getString("infgameId")
                            val infgame = infgames.infgames.find { it.id == infgameId }
                            if (infgame != null) {
                                InfgameDetailPage(infgame = infgame)
                            }
                        }
                        composable("about") {
                            AboutPage()
                        }
                    }
                }
            }
        }
    }
}

