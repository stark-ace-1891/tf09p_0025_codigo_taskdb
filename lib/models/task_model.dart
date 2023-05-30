class TaskModel {
  int? id;
  String? title;
  String? description;
  String? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
  });

  factory TaskModel.deMapAModel(Map<String, dynamic> mapa) => TaskModel(
        id: mapa["ID"],
        title: mapa["title"],
        description: mapa["description"],
        status: mapa["status"],
      );
}
