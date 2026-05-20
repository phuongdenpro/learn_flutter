import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  int gender = 1;
  bool isLoading = false;

  Future<void> register() async {
    if (emailController.text.trim().isEmpty ||
        fullNameController.text.trim().isEmpty) {
      showMessage('Vui lòng nhập đầy đủ thông tin');
      return;
    }
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

    final url = Uri.parse('https://10.0.2.2:7234/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'fullName': fullNameController.text.trim(),
          'gender': gender,
          'password': passwordController.text.trim(),
          'confirmPassword': confirmPasswordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        showMessage('Đăng ký thành công');

        if (!mounted) return;
        Navigator.pop(context);
      } else {
        showMessage('Đăng ký thất bại');
      }
    } catch (e) {
      showMessage('Lỗi kết nối API: $e');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Họ tên',
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
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nhập lại mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : register,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Đăng ký'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
