import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() {
    return _ApiScreenState();
  }
}

class _ApiScreenState extends State<ApiScreen> {
  List posts = [];
  bool isLoading = false;

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
      "https://jsonplaceholder.typicode.com/posts",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        posts = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API và HTTP"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  child: ListTile(
                    title: Text(post["title"]),
                    subtitle: Text(post["body"]),
                  ),
                );
              },
            ),
    );
  }
}