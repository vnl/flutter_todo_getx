import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/main.dart';
import 'package:todo_getx/controllers/todo_controller.dart';
import 'package:todo_getx/ui/edit_todo.dart';
import 'package:todo_getx/ui/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/Home_screen';
  final TodoController todoController = Get.put(TodoController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Get.toNamed(TodoScreen.id);
        },
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.deepOrange,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (_) {
              todoController.todos.removeAt(index);
              Get.snackbar('Remove!', "Task was succesfully Delete",
                  snackPosition: SnackPosition.BOTTOM);
            },
            child: ListTile(
              title: Text(
                todoController.todos[index].text!,
                style: todoController.todos[index].done
                    ? const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      )
                    : const TextStyle(
                        color: Colors.black,
                      ),
              ),
              trailing: IconButton(
                onPressed: () => Get.to(() => TodoEdit(index: index)),
                icon: const Icon(Icons.edit),
              ),
              leading: Checkbox(
                value: todoController.todos[index].done,
                onChanged: (neWvalue) {
                  var todo = todoController.todos[index];
                  todo.done = neWvalue!;
                  todoController.todos[index] = todo;
                },
              ),
            ),
          ),
          itemCount: todoController.todos.length,
        ),
      ),
    );
  }
}
