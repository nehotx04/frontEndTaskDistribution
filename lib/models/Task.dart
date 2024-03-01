import 'package:meta/meta.dart';

class Task{
  int id;
  String name;
  String? description;
  int user_id;
  bool completed;
  String week_day;
  String user;

  Task(@required this.id,@required this.name,this.description,@required this.user_id,this.completed,@required this.week_day,@required this.user);
  
}