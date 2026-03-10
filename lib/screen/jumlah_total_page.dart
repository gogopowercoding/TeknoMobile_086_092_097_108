import 'package:flutter/material.dart';

class JumlahTotalPage extends StatelessWidget {
  const JumlahTotalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumlah Total Angka"),
      ),
      body: const Center(
        child: Text("Halaman Jumlah Total"),
      ),
    );
  }
}