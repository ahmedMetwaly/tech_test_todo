class TaskModel {
  String? taskTitle;
  String? state;
  int? id;

  TaskModel({required this.taskTitle, required this.state});
  TaskModel.fromJson(Map<String, dynamic> json) {
    taskTitle = json["title"];
    state = json["state"];
    id = json["id"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["title"] = taskTitle;
    data["state"] = state;
    data["id"] = id;

    return data;
  } // checked, notChecked
}
