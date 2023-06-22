// import 'package:flutter/material.dart';
// import 'package:todo_list_resto/constants/colors.dart';

// import '../models/todo.dart';

// class TodoItem extends StatelessWidget {
//   final ToDo todo;
//   // ignore: prefer_typing_uninitialized_variables
//   final onTodoChanged;
//   // ignore: prefer_typing_uninitialized_variables
//   final onDeleteItem;

//   const TodoItem(
//       {Key? key,
//       required this.todo,
//       required this.onTodoChanged,
//       required this.onDeleteItem})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       child: ListTile(
//         onTap: () {
//           onTodoChanged(todo);
//         },
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         tileColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         leading: Icon(
//           todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
//           color: restoBlue,
//         ),
//         title: Text(
//           todo.todoText!,
//           style: TextStyle(
//               fontSize: 16,
//               color: restoBlack,
//               decoration: todo.isDone ? TextDecoration.lineThrough : null),
//         ),
        // trailing: Container(
        //   height: 35,
        //   width: 35,
        //   decoration: BoxDecoration(
        //       color: restoRed, borderRadius: BorderRadius.circular(5)),
        //   child: IconButton(
        //     color: Colors.white,
        //     iconSize: 18,
        //     icon: const Icon(Icons.delete),
        //     onPressed: () {
        //       onDeleteItem(todo.id);
        //     },
//           ),
//         ),
//       ),
//     );
//   }
// }
