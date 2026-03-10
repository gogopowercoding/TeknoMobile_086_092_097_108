import 'package:flutter/material.dart';

class PiramidPage extends StatelessWidget {
  const PiramidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Luas & Volume Piramid"),
      ),
      body: const Center(
        child: Text("Halaman Piramid"),
      ),
    );
  }
}