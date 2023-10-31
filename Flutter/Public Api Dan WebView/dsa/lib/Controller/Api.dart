import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prak/Controller/RecipeController.dart';
import 'package:prak/View/RecipeDetail.dart';
import 'package:prak/Model/recipe.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 241, 241),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 241, 241),
        title: Text(
          'API',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Obx(() {
          if (recipeController.recipes.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: recipeController.recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipeController.recipes[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => RecipeDetail(recipe: Recipe.fromJson(recipe)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(recipe['strMealThumb'] ?? ''),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(recipe['strMeal'] ?? '', style: TextStyle(fontSize: 17)),
                                  SizedBox(height: 10),
                                  Text(recipe['strCategory'] ?? ''),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}