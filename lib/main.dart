import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_flutter/screens/api_screen.dart';
import 'package:learn_flutter/screens/counter_screen.dart';
import 'package:learn_flutter/screens/detail_screen.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Chào mừng bạn đến với khóa học Flutter cơ bản!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Thông báo"),
                            content: const Text("Bạn đã chọn Bài 2"),
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
                Card(
                  child: ListTile(
                    title: Text('Bài 3: State'),
                    subtitle: Text('setState và StatefulWidget'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CounterScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Bài 4: Navigation'),
                    subtitle: Text('Điều hướng giữa các màn hình'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomeDetailScreen(name: "Phương");
                          },
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Bài 5: API và HTTP'),
                    subtitle: Text(
                      'Gọi API và xử lý dữ liệu',
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ApiScreen();
                          },
                        ),
                      );
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
