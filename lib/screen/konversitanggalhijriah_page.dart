import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/hijri_date.dart';
import '../Services/hijri_converter.dart';
import '../Services/jawa_converter.dart';

class KonversiTanggalHijriahPage extends StatefulWidget {
  const KonversiTanggalHijriahPage({super.key});

  @override
  State<KonversiTanggalHijriahPage> createState() =>
      _KonversiTanggalHijriahPageState();
}

class _KonversiTanggalHijriahPageState
    extends State<KonversiTanggalHijriahPage> {

  bool isMasehiToHijri = true;
  DateTime? selectedDate;
  String hasil = "";

  int? hariHijriah;
  int? bulanHijriah;
  int? tahunHijriah;

  void pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(622, 7, 16),
      lastDate: DateTime(5000000000),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        hasil = "";
      });
    }
  }

  void konversi() {
    try {
      if (isMasehiToHijri) {
        if (selectedDate == null) {
          _error("Pilih tanggal dulu");
          return;
        }

        final hijri = HijriConverter.fromGregorian(selectedDate!);
        final jawa = JawaConverter.fromGregorian(selectedDate!);

        setState(() {
          hasil =
              "${formatTanggal(selectedDate!)}\n"
              "Hijriah: $hijri\n"
              "Jawa: $jawa";
        });

      } else {
        if (hariHijriah == null ||
            bulanHijriah == null ||
            tahunHijriah == null) {
          _error("Semua field harus diisi");
          return;
        }

        final hijri = HijriDate(
          day: hariHijriah!,
          month: bulanHijriah!,
          year: tahunHijriah!,
        );

        DateTime masehi = HijriConverter.toGregorian(hijri);
        final jawa = JawaConverter.fromGregorian(masehi);

        setState(() {
          hasil =
              "${DateFormat("dd MMMM yyyy", "id_ID").format(masehi)}\n"
              "Jawa: $jawa";
        });
      }
    } catch (e) {
      _error("Gagal konversi");
    }
  }

  void _error(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  void clearAll() {
    setState(() {
      hasil = "";
      selectedDate = null;
      hariHijriah = null;
      bulanHijriah = null;
      tahunHijriah = null;
    });
  }

  String formatTanggal(DateTime date) {
    return DateFormat("dd MMMM yyyy", "id_ID").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Kalender"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(isMasehiToHijri
                  ? "Masehi → Hijriah"
                  : "Hijriah → Masehi"),
              value: isMasehiToHijri,
              onChanged: (val) {
                setState(() {
                  isMasehiToHijri = val;
                  hasil = "";
                });
              },
            ),

            ElevatedButton(
              onPressed: pilihTanggal,
              child: const Text("Pilih Tanggal"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: konversi,
              child: const Text("Konversi"),
            ),

            const SizedBox(height: 20),

            Text(hasil, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}