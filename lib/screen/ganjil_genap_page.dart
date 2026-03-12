import 'package:flutter/material.dart';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});

  @override
  State<GanjilGenapPage> createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  TextEditingController angkaController = TextEditingController();

  String hasilGanjilGenap = "";
  String hasilPrima = "";

  void cekBilangan() {
    String input = angkaController.text;

    // ERROR 1: jika kosong
    if (input.isEmpty) {
      tampilkanError("Input tidak boleh kosong");
      return;
    }

    int? angka = int.tryParse(input);

    // ERROR 2: jika bukan angka
    if (angka == null) {
      tampilkanError("Input harus berupa angka");
      return;
    }

    // ERROR 3: jika angka negatif
    if (angka < 0) {
      tampilkanError("Masukkan angka positif");
      return;
    }

    // cek ganjil genap
    if (angka % 2 == 0) {
      hasilGanjilGenap = "Genap";
    } else {
      hasilGanjilGenap = "Ganjil";
    }

    // cek prima
    bool prima = true;

    if (angka <= 1) {
      prima = false;
    } else {
      for (int i = 2; i <= angka ~/ 2; i++) {
        if (angka % i == 0) {
          prima = false;
          break;
        }
      }
    }

    hasilPrima = prima ? "Bilangan Prima" : "Bukan Bilangan Prima";

    setState(() {});
  }

  void tampilkanError(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ganjil / Genap & Prima"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: angkaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan Angka",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: cekBilangan,
              child: const Text("Cek Bilangan"),
            ),

            const SizedBox(height: 20),

            Text(
              "Jenis Bilangan: $hasilGanjilGenap",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Status Prima: $hasilPrima",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}