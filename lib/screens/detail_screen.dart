import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeDetailScreen extends StatefulWidget {
  final String name;

  const HomeDetailScreen({super.key, required this.name});

  @override
  State<HomeDetailScreen> createState() {
    return _HomeDetailScreenState();
  }
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  final TextEditingController nameController = TextEditingController();
  List posts = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('Xin chào  ${widget.name}!'),
            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),

                hintText: "Nhập tên",
              ),
            ),
            

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                String name = nameController.text;

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) {
                      return DetailScreen(name: name);
                    },
                  ),
                );
              },

              child: const Text("Gửi"),
            ),
            
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String name;

  const DetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),

      body: Center(
        child: Text("Xin chào $name", style: const TextStyle(fontSize: 30)),
      ),
    );
  }
}
