import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateTodoPage extends StatefulWidget {
  const updateTodoPage({super.key});

  @override
  State<updateTodoPage> createState() => _updateTodoPageState();
}

class _updateTodoPageState extends State<updateTodoPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateTodo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(hintText: 'id'),
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'name'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(hintText: 'price'),
          ),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(hintText: 'quantity'),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: submitDataJesus, child: Text('Update'))
        ],
      ),
    );
  }

  Future<void> submitDataJesus() async {
    // Get the data from form
    final id = idController.text;
    final name = nameController.text;
    final price = priceController.text;
    final quantity = quantityController.text;
    final body = {
      "_id": id,
      "name": name,
      "price": price,
      "quantity": quantity,
    };

    // Submit data to the server
    final url = 'https://abet24.fly.dev/api-yisus/update-product/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // Show success or fail message based on status
    if (response.statusCode == 200) {
      idController.text = '';
      nameController.text = '';
      priceController.text = '';
      quantityController.text = '';
      showSuccessMessage('Update Success');
    } else {
      showErroMessage('Update Failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErroMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
