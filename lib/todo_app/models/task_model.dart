// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  String taskTitle;
  String describtion;
  String id;
  String date;
  bool isDone;
  bool isDeleted;
  bool isFavourite;
  Task(
      {required this.taskTitle,
      required this.describtion,
      required this.id,
      required this.date,
      this.isDone = false,
      this.isDeleted = false,
      this.isFavourite = false});

  Task copyWith({
    String? taskTitle,
    bool? isDone,
    bool? isDeleted,
    bool? isFavourite,
    String? describtion,
    String? date,
  }) {
    return Task(
      taskTitle: taskTitle ?? this.taskTitle,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      describtion: describtion ?? this.describtion,
      isFavourite: isFavourite ?? this.isFavourite,
      id: id,
      date: date??this.date
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskTitle': taskTitle,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'describtion': describtion,
      'id': id,
      'isFavourite': isFavourite,
      'date':date,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      describtion: map['describtion'] ?? '',
      taskTitle: map['taskTitle'] ?? '',
      id: map['id'],
      isDone: map['isDone'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
      isFavourite: map['isFavourite'] ?? false,
      date: map['date']??'',
    );
  }

  @override
  List<Object?> get props => [
        taskTitle,
        describtion,
        id,
        isDeleted,
        isDone,
        isFavourite,
        date,
      ];
}
