class TodoModel{
  String title;
  String description;
  bool isDone;
  DateTime createAt;
  String documentId;
  TodoModel({
    required this.title,
    required this.description,
    required this.isDone,
    required this.createAt,
    required this.documentId
  });
}