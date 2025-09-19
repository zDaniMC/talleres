import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String message;

  const DetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla de Detalle")),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
