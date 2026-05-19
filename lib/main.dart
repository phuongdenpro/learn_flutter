import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Learning 1')),
      body: Column(
        children: [
          Text(
            "Chào mừng bạn đến với khóa học Flutter cơ bản!",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    title: Text('Bài 1: Dart cơ bản'),
                    subtitle: Text('Biến, hàm, class, list, map'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Bài 2: Widget cơ bản'),
                    subtitle: Text('Text, Container, Row, Column'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Bài 3: State'),
                    subtitle: Text('setState và StatefulWidget'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Bài 4: Navigation'),
                    subtitle: Text('Điều hướng giữa các màn hình'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Bài 5: API và HTTP'),
                    subtitle: Text('Gọi API và xử lý dữ liệu'),
                    trailing: Icon(Icons.arrow_forward_ios),

                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Thông báo"),
                            content: const Text("Bạn đã chọn Bài 5"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text("Bạn đã chọn Bài 5")),
                      //   );
                      // print("Bạn đã chọn Bài 5");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
