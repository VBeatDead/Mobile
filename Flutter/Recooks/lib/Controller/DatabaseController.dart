import 'package:appwrite/appwrite.dart';
import 'package:prak/Model/todo_model.dart';

class DatabaseController {
  DatabaseController._privateConstructor();
  static final DatabaseController _instance =
      DatabaseController._privateConstructor();
  static DatabaseController get instance => _instance;

  static Databases? databases;

  init(Client client) {
    databases = Databases(client);
  }

  createTodo({required String title, required String description}) async {
    databases ??= Databases(Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("6566a4a234cbff8753b2")
        .setSelfSigned(status: true));
    try {
      String documentId = ID.unique();
      await databases!.createDocument(
        databaseId: "6566a53dbc21847ed260",
        collectionId: "656f47c10aebb16f734a",
        documentId: documentId,
        data: {
          "title": title,
          "description": description,
          "isDone": false,
        },
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TodoModel>> fetchTodos() async {
  databases ??= Databases(Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("6566a4a234cbff8753b2")
      .setSelfSigned(status: true));

  try {
    var response = await databases!.listDocuments(
      databaseId: "6566a53dbc21847ed260",
      collectionId: "656f47c10aebb16f734a",
    );

    List<TodoModel> todos = [];

    for (var document in response.documents) {
      String documentId = document.$id ?? '';

      todos.add(TodoModel(
        documentId: documentId,
        title: document.data['title'],
        description: document.data['description'],
        isDone: document.data['isDone'],
        createAt: DateTime.parse(document.data['createAt']),
      ));
    }

    return todos;
  } catch (e) {
    print("Error fetching todos: $e");
    return [];
  }
}


  Future<bool> updateTodo(TodoModel todo) async {
    try {
      if (todo.documentId.isEmpty) {
        print("Error updating todo: Document ID is empty");
        return false;
      }

      await databases!.updateDocument(
        databaseId: "6566a53dbc21847ed260",
        collectionId: "656f47c10aebb16f734a",
        documentId: todo.documentId,
        data: {
          "title": todo.title,
          "description": todo.description,
          "isDone": todo.isDone,
        },
      );

      print("Update operation completed");
      return true;
    } catch (e) {
      if (e is AppwriteException) {
        print("Appwrite Exception: ${e.response}");
      } else {
        print("Error updating todo: $e");
      }
      return false;
    }
  }

  Future<bool> deleteTodo(String documentId) async {
    databases ??= Databases(Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("6566a4a234cbff8753b2")
        .setSelfSigned(status: true));
    try {
      if (documentId.isEmpty) {
        print("Error deleting todo: Document ID is empty");
        return false;
      }

      print("Deleting document with ID: $documentId");
      await databases!.deleteDocument(
        databaseId: "6566a53dbc21847ed260",
        collectionId: "656f47c10aebb16f734a",
        documentId: documentId,
      );
      print("Delete operation completed");
      return true;
    } catch (e) {
      if (e is AppwriteException) {
        print("Appwrite Exception: ${e.response}");
      } else {
        print("Error deleting todo: $e");
      }
      return false;
    }
  }
}
