import 'package:flutter/material.dart';
import 'package:teknomobile_086_092_097_108/screen/konversitanggalhijriah_page.dart';
import 'login_page.dart';

import 'penjumlahan_page.dart';
import 'ganjil_genap_page.dart';
import 'jumlah_total_page.dart';
import 'stopwatch_page.dart';
import 'piramid_page.dart';
import 'age_calculator_page.dart';
import 'kalendersaka_page.dart';

class DashboardPage extends StatefulWidget {

  final String username;

  const DashboardPage({super.key, required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List menu = [
    {
      "title": "Penjumlahan & Pengurangan",
      "icon": Icons.calculate,
      "page": const PenjumlahanPage()
    },
    {
      "title": "Ganjil / Genap & Bilangan Prima",
      "icon": Icons.numbers,
      "page": const GanjilGenapPage()
    },
    {
      "title": "Jumlah Total Angka",
      "icon": Icons.summarize,
      "page": const JumlahTotalPage()
    },
    {
      "title": "Stopwatch",
      "icon": Icons.timer,
      "page": const StopwatchPage()
    },
    {
      "title": "Luas & Volume Piramid",
      "icon": Icons.change_history,
      "page": const PiramidPage()
    },
    {
      "title": "Konversi Tanggal Hijriah",
      "icon": Icons.calendar_today,
      "page": const KonversiTanggalHijriahPage()
    },
    {
      "title": "Kalkulator Umur",
      "icon": Icons.cake,
      "page": const AgeCalculatorPage()
    },
    {
      "title": "Kalender Saka",
      "icon": Icons.calendar_month,
      "page": const KalendersakaPage()
    },

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Loginpage(),
              ),
            );
          },
        ),

        title: Text("Halo ${widget.username}, selamat datang!"),
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Anggota Kelompok Multilator'),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('123230086 Hiero Purbandono'),
                        SizedBox(height: 8),
                        Text('123230092 Martin Aji Nugraha'),
                        SizedBox(height: 8),
                        Text('123230097 Faisal Dani Noto Leogowo'),
                        SizedBox(height: 8),
                        Text('123230108 Furraihan Al Harits'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tutup'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],

      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: menu.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue[50],
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => menu[index]['page'],
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue[300],
                      child: Icon(
                        menu[index]['icon'],
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      menu[index]['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}