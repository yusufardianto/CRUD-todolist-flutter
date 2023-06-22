import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list_resto/constants/colors.dart';
import 'package:todo_list_resto/models/todo.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final ToDo model;
  // ignore: use_key_in_widget_constructors
  const EditPage(this.model);
  @override
  // ignore: library_private_types_in_public_api
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _descriptionController = TextEditingController();
  // TextEditingController _idController = TextEditingController();
  // TextEditingController desc;
  final _key = GlobalKey<FormState>();
  String? description, id;

  setup() {
    _descriptionController = TextEditingController(text: widget.model.todoText);
    // _idController = TextEditingController();
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {}

  @override
  void initState() {
    super.initState();
    setup();
  }

  Future<void> updateData(String? id) async {
    final description = _descriptionController.text;
    final body = {
      "title": "string",
      "description": description,
      "is_completed": false
    };
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    print(body);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Success');
      showSuccessMessage('Succes');
    } else {
      print('Failed');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: restoBlue,
        title: const Text('Edit Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Edit Text',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () {
                  updateData(widget.model.id);
                  // setState(() {
                  // });
                },
                style:
                    // ignore: deprecated_member_use
                    ElevatedButton.styleFrom(primary: restoBlue, elevation: 10),
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
