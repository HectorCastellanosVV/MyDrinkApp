import 'package:flutter/material.dart';
import 'package:mydrink_app/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  final User usuario;
  const HomeScreen({super.key, required this.usuario});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, ${widget.usuario.username}',
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 40),
            ),
            const SizedBox(height: 20),
            Text('Token: ${widget.usuario.token}'),
          ],
        ),
      ),
    );
  }
}
