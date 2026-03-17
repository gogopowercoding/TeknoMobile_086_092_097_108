import 'package:flutter/material.dart';
import 'package:teknomobile_086_092_097_108/screen/konversitanggalhijriah_page.dart';
import 'login_page.dart';

import 'penjumlahan_page.dart';
import 'ganjil_genap_page.dart';
import 'jumlah_total_page.dart';
import 'stopwatch_page.dart';
import 'piramid_page.dart';

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

      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {

          return Card(
            margin: const EdgeInsets.all(10),

            child: ListTile(
              leading: Icon(menu[index]['icon']),
              title: Text(menu[index]['title']),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => menu[index]['page'],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}