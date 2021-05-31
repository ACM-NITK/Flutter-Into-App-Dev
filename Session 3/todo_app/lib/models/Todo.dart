import "package:hive/hive.dart";

part "Todo.g.dart";

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String title;

  Todo(this.title);
}
