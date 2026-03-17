import 'package:flutter/material.dart';

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {
  final TextEditingController textController = TextEditingController();

  int jumlahHuruf = 0;
  int jumlahSimbol = 0;
  int jumlahSpasi = 0;
  double totalAngka = 0;

  void hitung() {
    String input = textController.text;

    int huruf = 0;
    int simbol = 0;
    int spasi = 0;
    double angka = 0;

    String buffer = "";

    for (int i = 0; i < input.length; i++) {
      String char = input[i];

      if (RegExp(r'[0-9\.\-]').hasMatch(char)) {
        buffer += char;
      } else {
        if (buffer.isNotEmpty) {
          double? nilai = double.tryParse(buffer);
          if (nilai != null) angka += nilai;
          buffer = "";
        }

        if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
          huruf++;
        } else if (char == " ") {
          spasi++;
        } else {
          simbol++;
        }
      }
    }

    if (buffer.isNotEmpty) {
      double? nilai = double.tryParse(buffer);
      if (nilai != null) angka += nilai;
    }

    setState(() {
      jumlahHuruf = huruf;
      jumlahSimbol = simbol;
      jumlahSpasi = spasi;
      totalAngka = angka;
    });
  }

  void clearInput() {
    textController.clear();

    setState(() {
      jumlahHuruf = 0;
      jumlahSimbol = 0;
      jumlahSpasi = 0;
      totalAngka = 0;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analisis Teks "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: "Masukkan teks bebas",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: hitung,
                  child: const Text("Hitung"),
                ),

                const SizedBox(width: 15),

                ElevatedButton(
                  onPressed: clearInput,
                  child: const Text("Clear"),
                ),

              ],
            ),

            const SizedBox(height: 30),

            Text("Jumlah Huruf: $jumlahHuruf",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            Text("Jumlah Simbol: $jumlahSimbol",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            Text("Jumlah Spasi: $jumlahSpasi",
                style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            Text(
              "Total Angka: $totalAngka",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}