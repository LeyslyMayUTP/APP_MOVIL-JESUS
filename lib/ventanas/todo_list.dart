import 'dart:convert';

import 'package:rest_jesus/ventanas/add_page.dart';
import 'package:rest_jesus/ventanas/delete.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_jesus/models/producto.dart';
import 'package:rest_jesus/ventanas/update.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final url = Uri.parse("https://abet24.fly.dev/api-yisus/get-products");
  late Future<List<Producto>> productos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API REST'),
      ),
      //MENÚ
      drawer: Container(
          child: Container(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/InicioSesion.png")),
                  color: Colors.white,
                ),
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.add_outlined),
                title: Text('POST'),
                iconColor: Colors.green,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTodoPage()));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 199, 198, 198),
              ),
              ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('DELETE'),
                iconColor: Colors.green,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => deleteTodoPage()));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 199, 198, 198),
              ),
              ListTile(
                leading: Icon(Icons.update_outlined),
                title: Text('UPDATE'),
                iconColor: Colors.green,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => updateTodoPage()));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 199, 198, 198),
              ),
            ],
          ),
        ),
      )), //AQUI FINALIZA MENÚ
      body: FutureBuilder<List<Producto>>(
          future: productos,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(snap.data![i].name,
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              snap.data![i].price.toString() + " pesos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          trailing: Text(snap.data![i].quantity,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const Divider()
                      ],
                    );
                  });
            }
            if (snap.hasError) {
              return const Center(
                child: Text("Ha habido un problema"),
              );
            }

            return const CircularProgressIndicator();
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    productos = getProductos();
  }

  Future<List<Producto>> getProductos() async {
    final res = await http.get(url); //respuesta en texto
    final lista = List.from(jsonDecode(res.body));

    List<Producto> productos = [];
    lista.forEach((element) {
      final Producto product = Producto.fromJson(element);
      productos.add(product);
    });
    return productos;
  }

  /*void deleteProductos({required Map<String, dynamic> Producto}) async {
    var url = Uri.parse('https://mi-api-rest.fly.dev/api/eliminar/{id}');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('{id}'),
      ));
    }
  }*/
}
