import 'package:flutter/material.dart';

class PenjumlahanPage extends StatelessWidget {
  const PenjumlahanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Penjumlahan & Pengurangan"),
      ),
      body: const Center(
        child: Text("Halaman Penjumlahan & Pengurangan"),
      ),
    );
  }
}