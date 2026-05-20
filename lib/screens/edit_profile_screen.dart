import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoadingProfile = true;
  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.user.fullName;
    emailController.text = widget.user.email;

    gender = widget.user.gender;
    isLoadingProfile = false;
  }

  int gender = 1;
  bool isLoading = false;

  Future<void> updateProfile() async {
    final emailError = validateEmail(emailController.text);

    if (emailError != null) {
      showMessage(emailError);
      return;
    }
    if (!passwordController.text.trim().isEmpty ||
        !confirmPasswordController.text.trim().isEmpty) {
      final passwordError = validatePassword(passwordController.text);

      if (passwordError != null) {
        showMessage(passwordError);
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        showMessage('Mật khẩu nhập lại không khớp');
        return;
      }
    }

    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final url = Uri.parse('https://10.0.2.2:7234/api/profile');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'email': emailController.text.trim(),
          'fullName': fullNameController.text.trim(),
          'gender': gender,
          'password': passwordController.text.trim(),
          'comfirmPassword': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        showMessage('Cập nhật thông tin thành công');

        if (!mounted) return;
        Navigator.pop(context, true);
      } else {
        showMessage('Cập nhật thất bại: ${response.statusCode}');
      }
    } catch (e) {
      showMessage('Lỗi API: $e');
    }

    setState(() => isLoading = false);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Vui lòng nhập email';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return 'Email không hợp lệ';
    }

    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }

    if (password.length < 8) {
      return 'Mật khẩu tối thiểu 8 ký tự';
    }

    // if (!RegExp(r'[A-Z]').hasMatch(password)) {
    //   return 'Phải có ít nhất 1 chữ hoa';
    // }

    // if (!RegExp(r'[a-z]').hasMatch(password)) {
    //   return 'Phải có ít nhất 1 chữ thường';
    // }

    // if (!RegExp(r'[0-9]').hasMatch(password)) {
    //   return 'Phải có ít nhất 1 số';
    // }

    // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    //   return 'Phải có ký tự đặc biệt';
    // }

    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    // roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cập nhật thông tin')),
      body: isLoadingProfile
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Họ tên',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<int>(
                    value: gender,
                    decoration: const InputDecoration(
                      labelText: 'Giới tính',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Nam')),
                      DropdownMenuItem(value: 2, child: Text('Nữ')),
                      DropdownMenuItem(value: 3, child: Text('Khác')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu mới (nếu muốn thay đổi)',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Nhập lại mật khẩu mới (nếu muốn thay đổi)',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  // TextField(
                  //   controller: roleController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Role',
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : updateProfile,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Lưu thay đổi'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
