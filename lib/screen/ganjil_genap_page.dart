import 'package:flutter/material.dart';

class GanjilGenapPage extends StatelessWidget {
  const GanjilGenapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ganjil / Genap & Prima"),
      ),
      body: const Center(
        child: Text("Halaman Ganjil Genap & Prima"),
      ),
    );
  }
}