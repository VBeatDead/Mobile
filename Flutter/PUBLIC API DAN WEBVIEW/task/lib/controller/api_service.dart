import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxController {
  RxBool isLoading = true.obs;
  RxString error = ''.obs;
  RxString title = ''.obs;

  Future<void> fetchTodos() async {
    isLoading(true);
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/5'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        title(data["title"]);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}