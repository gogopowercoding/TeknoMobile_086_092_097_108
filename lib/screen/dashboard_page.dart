import 'package:flutter/material.dart';
import 'package:teknomobile_086_092_097_108/screen/konversitanggalhijriah_page.dart';
import 'login_page.dart';

import 'penjumlahan_page.dart';
import 'ganjil_genap_page.dart';
import 'jumlah_total_page.dart';
import 'stopwatch_page.dart';
import 'piramid_page.dart';
import 'age_calculator_page.dart';

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

        title: Text("Welcome, ${widget.username}!"),
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
                    Icon(
                      menu[index]['icon'],
                      size: 48.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      menu[index]['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
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