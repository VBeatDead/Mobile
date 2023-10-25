import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/api_service.dart';

class TodosPage extends StatelessWidget {
  final ApiService apiService = Get.put(ApiService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test API'),
      ),
      body: Center(
        child: Obx(() {
          if (apiService.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (apiService.title.isNotEmpty) {
              return Text(apiService.title.value);
            } else if (apiService.error.isNotEmpty) {
              return Center(child: Text(apiService.error.value));
            } else {
              return const Text('');
            }
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => apiService.fetchTodos(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}