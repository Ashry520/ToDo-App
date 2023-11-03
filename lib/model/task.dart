class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String?,
            title: data['title'],
            description: data['description'],
            dateTime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
            isDone: data['isDone']);

  Map<String, dynamic> toFireStorte() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.microsecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
