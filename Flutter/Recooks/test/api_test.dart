import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:prak/Controller/RecipeController.dart';

import 'MockClient.dart';

void main() {
  group('RecipeController Tests', () {
    test('fetchRecipes - success case', () async {
      // Mock successful response
      final client = MockClient((request) async {
        return http.Response(
          json.encode({'meals': [{'strMeal': 'Meal 1', 'strCategory': 'Category 1', 'strMealThumb': 'Thumb 1'}]}),
          200,
        );
      });

      final recipeController = RecipeController();

      // Call the method to be tested with the mock client
      await recipeController.fetchRecipes(client);

      // Verify that the recipes list is not empty
      expect(recipeController.recipes.isNotEmpty, true);

      // Verify the content of the first recipe
      expect(recipeController.recipes[0]['strMeal'], 'Meal 1');
      expect(recipeController.recipes[0]['strCategory'], 'Category 1');
      expect(recipeController.recipes[0]['strMealThumb'], 'Thumb 1');
    });

    test('fetchRecipes - error case', () async {
      // Mock error response
      final client = MockClient((request) async {
        return http.Response('Error occurred', 404);
      });

      final recipeController = RecipeController();

      // Call the method to be tested with the mock client
      await recipeController.fetchRecipes(client);

      // Verify that the recipes list is empty in case of an error
      expect(recipeController.recipes.isEmpty, true);
    });
  });
}
