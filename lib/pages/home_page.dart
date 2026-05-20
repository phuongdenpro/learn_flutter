import 'package:flutter/material.dart';
import 'package:learn_flutter/screens/api_screen.dart';
import 'package:learn_flutter/screens/counter_screen.dart';
import 'package:learn_flutter/screens/detail_screen.dart';
import 'package:learn_flutter/screens/map_screens.dart';
import 'package:learn_flutter/screens/open_street_map_screen.dart';
import 'package:learn_flutter/widgets/course_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Learning 1')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Chào mừng bạn đến với khóa học Flutter cơ bản!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),

          CourseItem(
            title: 'Bài 1: Dart cơ bản',
            subtitle: 'Biến, hàm, class, list, map',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CounterScreen()),
              );
            },
          ),
          CourseItem(
            title: 'Bài 2: Widget cơ bản',
            subtitle: 'Text, Container, Row, Column',
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
                //
              );
            },
          ),
          CourseItem(
            title: 'Bài 3: State',
            subtitle: 'setState và StatefulWidget',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CounterScreen()),
              );
            },
          ),
          CourseItem(
            title: 'Bài 4: Navigation',
            subtitle: 'Điều hướng giữa các màn hình',
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
          CourseItem(
            title: 'Bài 5: API và HTTP',
            subtitle: 'Gọi API và xử lý dữ liệu',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApiScreen()),
              );
            },
          ),
          CourseItem(
            title: 'Google Map',
            subtitle: 'Hiển thị bản đồ Google',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OpenStreetMapScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
