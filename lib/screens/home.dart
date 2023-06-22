// ignore_for_file: sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list_resto/models/todo.dart';
// import 'package:todo_list_resto/widgets/todo_item.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list_resto/screens/Editpage.dart';

import '../constants/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final todosList = ToDo.todoList();
  // List<ToDo> _search = [];
  TextEditingController descriptionController = TextEditingController();
  late Map? todo;
  final List<ToDo> _findToDO = [];

  // ignore: prefer_final_fields
  List<ToDo> _toDoList = [];
  final _todoController = new TextEditingController();

  bool isLoading = true;
  List<ToDo> items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    // final item = items as Map;
    // final id = item['_id'] as String;
    return Scaffold(
      backgroundColor: restoBGColor,
      appBar: _Appbar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                  child: Visibility(
                    visible: isLoading,
                    // ignore: sort_child_properties_last
                    child: const Center(child: CircularProgressIndicator()),
                    replacement: RefreshIndicator(
                        onRefresh: fetchTodo,
                        child: _findToDO.length != 0 ||
                                _todoController.text.isEmpty
                            ? ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  print('abskajdaio');
                                  // final id = item['_id'] as String;
                                  // final i = list[item];
                                  return Card(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: ListTile(
                                        title: Text(item.todoText!),
                                        // leading: Icon(
                                        //     item.isDone
                                        //         ? Icons.check_box
                                        //         : Icons.check_box_outline_blank,
                                        //     color: restoBlue),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  child: Text('Edit'),
                                                  value: 'edit'),
                                              PopupMenuItem(
                                                child: Text('Delete'),
                                                value: 'delete',
                                              )
                                            ];
                                          },
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              navigateToEditPage(item);
                                            } else if (value == 'delete') {
                                              deleteById(item.id);
                                            }
                                          },
                                        )),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  // final id = item['_id'] as String;
                                  return Card(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: ListTile(
                                          title:
                                              Text(_findToDO[index].todoText!),
                                          // leading: Icon(
                                          //     item.isDone
                                          //         ? Icons.check_box
                                          //         : Icons
                                          //             .check_box_outline_blank,
                                          //     color: restoBlue),
                                          trailing: PopupMenuButton(
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                    child: Text('Edit'),
                                                    value: 'edit'),
                                                PopupMenuItem(
                                                  child: Text('Delete'),
                                                  value: 'delete',
                                                )
                                              ];
                                            },
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                navigateToEditPage(item);
                                              } else if (value == 'delete') {
                                                deleteById(item.id);
                                              }
                                            },
                                          )
                                          // Container(
                                          //   height: 35,
                                          //   width: 35,
                                          //   decoration: BoxDecoration(
                                          //       color: restoRed,
                                          //       borderRadius:
                                          //           BorderRadius.circular(5)),
                                          //   child: IconButton(
                                          //     color: Colors.white,
                                          //     iconSize: 18,
                                          //     icon: const Icon(Icons.delete),
                                          //     onPressed: () {
                                          //       deleteById(id);
                                          //     },
                                          //   ),
                                          // ),
                                          ));
                                },
                              )),
                  ),
                )
                // Container(
                //   margin: const EdgeInsets.only(
                //     top: 50,
                //     bottom: 20,
                //   ),
                //   child: const Text(
                //     'All ToDos',
                //     style: TextStyle(
                //       fontSize: 30,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                // Container(
                //   child: ListTile(
                //     title: Text(item['description']),
                //   ),
                // ),
                // for (ToDo todoo in _findToDO.reversed)
                //   TodoItem(
                //     todo: todoo,
                //     onTodoChanged: _handleToDoChange,
                //     onDeleteItem: deleteById(id),
                //   ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  // ignore: sort_child_properties_last
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: submitData,
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: restoBlue,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // void _handleToDoChange(ToDo todo) {
  //   setState(() {
  //     todo.isDone = !todo.isDone;
  //   });
  // }

  // void _deleteToDoItem(String id) {
  //   setState(() {
  //     todosList.removeWhere((item) => item.id == id);
  //   });
  // }

  void navigateToEditPage(ToDo item) {
    final route = MaterialPageRoute(builder: (context) => EditPage(item));
    Navigator.push(context, route);
  }

  Future<void> deleteById(String? id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    print("udhwiudhiu");
    final response =
        await http.delete(uri, headers: {'accept': 'application/json'});
    print(response);
    if (response.statusCode == 200) {
      print('objectjhgyfuy');
      final filtered = items.where((element) => element.id != id).toList();
      print(filtered);
    } else {
      showErrorMessage('Delete Failed');
    }
  }
  // final filtered = items.where((element) => element.id == id).toList();
  // return ToDo.fromJson(jsonDecode(response.body));
  // throw Exception('Failed to delete album.');

  // void _addToDoItem(String toDo) {
  //   todosList.add(ToDo(
  //       id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
  //   _todoController.clear();
  // }

  Future<void> submitData() async {
    final description = _todoController.text;
    final body = {
      "title": "string",
      "description": description,
      "is_completed": false
    };
    final url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    });
    // http.post(url);
    if (response.statusCode == 201) {
      print('Success');
      showSuccessMessage('Succes');
    } else {
      print('Failed');
      showErrorMessage("Failed Creating");
      print(response.body);
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    // print(response);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(response.body);
      final data = json['items'];
      List<ToDo> todos = [];
      for (todo in data) {
        todos.add(ToDo.fromJsonDynamic(todo!));
      }
      ;
      print(todos);
      // final result = json.map((e) => ToDo.fromJson(e)).toList();
      // final result = json['items'] as List;
      // print(result);
      setState(() {
        items = todos;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }

  void _runFilter(String enteredKeyword) async {
    _findToDO.clear();
    if (enteredKeyword.isEmpty) {
      setState(() {
        return;
      });
    }
    _toDoList.forEach((ToDo) {
      if (ToDo.todoText!.contains(enteredKeyword) ||
          ToDo.todoText!.contains(enteredKeyword.toLowerCase()))
        _findToDO.add(ToDo);
    });

    setState(() {});
  }

  // ignore: non_constant_identifier_names
  Widget SearchBox() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: const Icon(Icons.search),
          title: TextField(
            controller: _todoController,
            decoration: const InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: (value) {
              _runFilter(value);
            },
          ),
          trailing: IconButton(
              onPressed: () {
                _todoController.clear();
                _runFilter('');
              },
              icon: const Icon(Icons.cancel)),
        ));
  }

  // ignore: non_constant_identifier_names
  AppBar _Appbar() {
    return AppBar(
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: restoBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpg'),
          ),
        ),
      ]),
      backgroundColor: restoBGColor,
    );
  }
}
