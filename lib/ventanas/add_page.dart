import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
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
          ElevatedButton(onPressed: submitDataJesus, child: Text('Add'))
        ],
      ),
    );
  }

  Future<void> submitDataJesus() async {
    // Get the data from form
    final name = nameController.text;
    final price = priceController.text;
    final quantity = quantityController.text;
    final body = {
      "name": name,
      "price": price,
      "quantity": quantity,
    };
    // Submit data to the server
    final url = 'https://abet24.fly.dev/api-yisus/add-product';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // Show success or fail message based on status
    if (response.statusCode == 200) {
      nameController.text = '';
      priceController.text = '';
      quantityController.text = '';
      showSuccessMessage('Creation Success');
    } else {
      showErroMessage('Creation Failed');
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
