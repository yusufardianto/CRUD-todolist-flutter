class ToDo {
  String? id;
  String? title;
  String? todoText;
  late bool isDone;

  ToDo({
    this.id,
    this.title,
    this.todoText,
    this.isDone = false,
  });

  ToDo.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    todoText = json['description'];
    isDone = json['is_completed'];
  }
  ToDo.fromJsonDynamic(Map<dynamic, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    todoText = json['description'];
    isDone = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    // ignore: unnecessary_this
    data['description'] = this.todoText;
    return data;
  }
}
