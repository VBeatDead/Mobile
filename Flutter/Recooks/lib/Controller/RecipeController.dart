import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecipeController extends GetxController {
  var recipes = <Map<String, String?>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=b'));

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
          json.decode(response.body)['meals']);

      recipes.value = data.map((e) => e.map((k, v) => MapEntry(k, v.toString()))).toList();
    }
  }
}