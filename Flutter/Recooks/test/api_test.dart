import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:prak/Controller/RecipeController.dart';

import 'MockClient.dart';

void main() {
  group('RecipeController Tests', () {
    test('fetchRecipes - success case', () async {
      final client = MockClient((request) async {
        return http.Response(
          json.encode({'meals': [{'strMeal': 'Meal 1', 'strCategory': 'Category 1', 'strMealThumb': 'Thumb 1'}]}),
          200,
        );
      });

      final recipeController = RecipeController();
      await recipeController.fetchRecipes(client);

      expect(recipeController.recipes.isNotEmpty, true);
      expect(recipeController.recipes[0]['strMeal'], 'Meal 1');
      expect(recipeController.recipes[0]['strCategory'], 'Category 1');
      expect(recipeController.recipes[0]['strMealThumb'], 'Thumb 1');
    });

    test('fetchRecipes - error case', () async {
      final client = MockClient((request) async {
        return http.Response('Error occurred', 404);
      });

      final recipeController = RecipeController();
      await recipeController.fetchRecipes(client);

      expect(recipeController.recipes.isEmpty, true);
    });
  });
}
