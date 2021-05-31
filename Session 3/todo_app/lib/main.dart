import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'models/Todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TodoAdapter());
  runApp(MyHomePage());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Hive.openBox('todo'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return TodoView();
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: displayTodos(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addTodoDialog(false);
          _textEditingController.clear();
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget displayTodos() {
    return ValueListenableBuilder(
        valueListenable: Hive.box('todo').listenable(),
        builder: (context, Box todos, _) {
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos.getAt(index);
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.title),
                  trailing:
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTodo(index);
                      },
                    ),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _textEditingController.value =
                              TextEditingValue(text: todo.title);
                          addTodoDialog(true, index: index);
                        })
                  ]),
                );
              });
        });
  }

  addTodoDialog(bool edit, {int? index}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Title'),
                    controller: _textEditingController,
                  ),
                  ElevatedButton(
                      child: Text('${!edit ? 'Add' : 'Edit'} Todo'),
                      onPressed: () {
                        if (edit) {
                          Todo todo = Todo(_textEditingController.text);
                          editTodo(todo, index);
                        } else {
                          addTodo(Todo(_textEditingController.text));
                        }
                        _textEditingController.clear();
                        Navigator.of(context).pop();
                      })
                ]),
          );
        });
  }

  addTodo(Todo todo) {
    final box = Hive.box('todo');
    box.add(todo);
  }

  editTodo(Todo? todo, index) {
    final box = Hive.box('todo');
    box.putAt(index, todo);
  }

  deleteTodo(index) {
    final box = Hive.box('todo');
    box.deleteAt(index);
  }
}
