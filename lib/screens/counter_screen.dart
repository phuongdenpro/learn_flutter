import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() {
    return _CounterScreenState();
  }
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;
  Color color = Colors.red;
  bool isLogin = false;
  void increase() {
    setState(() {
      color = color == Colors.red ? Colors.blue : Colors.red;
      count++;
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter")),
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text("$count", style: const TextStyle(fontSize: 40, color: Color.fromARGB(255, 8, 236, 8))),
            Text(
              isLogin ? "Đã đăng nhập" : "Chưa đăng nhập",

              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),

            
          ],
        ),
        // child: Text(
        //   "$count",
        //   style: const TextStyle(fontSize: 40),
        // ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: increase,
        child: const Icon(Icons.add_alarm_rounded),
      ),
    );
  }
}