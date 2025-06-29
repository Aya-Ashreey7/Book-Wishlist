import 'package:flutter/material.dart';
import 'MainLayout.dart';
import 'register_page.dart';
import 'auth_service.dart';

class LoginPage extends StatelessWidget {
  final Map<String, dynamic>? bookToFavorite;
  const LoginPage({super.key, this.bookToFavorite});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome back!", style: TextStyle(fontSize: 20)),
            const Text("Login to your account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "E-mail"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty && passwordController.text.isNotEmpty) {
                  loginUser(email);
                  Navigator.pop(context, 'success');
                }
              },
              child: const Text("Login"),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
