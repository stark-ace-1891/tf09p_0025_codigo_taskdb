class TaskModel {
  int? id;
  String title;
  String description;
  String status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory TaskModel.deMapAModel(Map<String, dynamic> mapa) => TaskModel(
        id: mapa["ID"],
        title: mapa["title"],
        description: mapa["description"],
        status: mapa["status"],
      );
}
