import 'package:flutter/material.dart';

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {

  final TextEditingController angka1 = TextEditingController();
  final TextEditingController angka2 = TextEditingController();
  final TextEditingController angka3 = TextEditingController();

  int total = 0;

  void hitungTotal() {
    int a = int.tryParse(angka1.text) ?? 0;
    int b = int.tryParse(angka2.text) ?? 0;
    int c = int.tryParse(angka3.text) ?? 0;

    setState(() {
      total = a + b + c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumlah Total Angka"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: angka1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Input angka 1",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: angka2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Input angka 2",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: angka3,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Input angka 3",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: hitungTotal,
              child: const Text("Hitung Total"),
            ),

            const SizedBox(height: 20),

            Text(
              "Total: $total",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )

          ],
        ),
      ),
    );
  }
}