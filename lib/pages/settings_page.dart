import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/models/user.dart';
import 'package:learn_flutter/screens/edit_profile_screen.dart';
import 'package:learn_flutter/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UserProfile? user;
  bool isLoading = true;

  Future<void> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final url = Uri.parse('https://10.0.2.2:7234/api/profile');

    try {
      final response = await http.get(
        url,
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          user = UserProfile.fromJson(data);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đăng xuất thành công')));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    user?.fullName.substring(0, 1).toUpperCase() ?? '?',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Center(
                  child: Text(
                    user?.fullName ?? 'Không có tên',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    user?.email ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

                Center(
                  child: Text(
                    'Vai trò: ${user?.role ?? ''}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 24),
                const Divider(),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Đổi thông tin người dùng'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: user == null
                      ? null
                      : () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfileScreen(user: user!),
                            ),
                          );

                          if (result == true) {
                            getProfile();
                          }
                        },
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Đăng xuất',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: logout,
                ),
              ],
            ),
    );
  }
}
