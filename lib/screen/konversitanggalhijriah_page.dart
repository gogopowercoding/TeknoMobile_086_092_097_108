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

  List<int> hariList = [];

  final List<String> namaBulanHijriah = [
    "Muharram",
    "Safar",
    "Rabiul Awal",
    "Rabiul Akhir",
    "Jumadil Awal",
    "Jumadil Akhir",
    "Rajab",
    "Sya'ban",
    "Ramadhan",
    "Syawal",
    "Dzulqa'dah",
    "Dzulhijjah"
  ];

  void pilihTanggal() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(622, 7, 16),
      lastDate: DateTime(9999, 12, 31),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        hasil = "";
      });
    }
  }

  // 🔥 CEK TAHUN KABISAT HIJRIAH
  bool isLeapYearHijri(int year) {
    return ((11 * year + 14) % 30) < 11;
  }

  // 🔥 HITUNG MAX HARI
  int getMaxHari(int bulan, int tahun) {
    if (bulan == 12) {
      return isLeapYearHijri(tahun) ? 30 : 29;
    }
    return (bulan % 2 == 1) ? 30 : 29;
  }

  // 🔥 UPDATE LIST HARI OTOMATIS
  void updateHariList() {
    if (bulanHijriah != null && tahunHijriah != null) {
      int maxHari = getMaxHari(bulanHijriah!, tahunHijriah!);
      setState(() {
        hariList = List.generate(maxHari, (i) => i + 1);
        if (hariHijriah != null && hariHijriah! > maxHari) {
          hariHijriah = null;
        }
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

  String formatTanggal(DateTime date) {
    return DateFormat("dd MMMM yyyy", "id_ID").format(date);
  }

  void resetInput() {
    setState(() {
      hariHijriah = null;
      bulanHijriah = null;
      tahunHijriah = null;
      hariList = [];
    });
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
                  selectedDate = null;
                  resetInput();
                });
              },
            ),

            if (isMasehiToHijri) ...[
              ElevatedButton(
                onPressed: pilihTanggal,
                child: const Text("Pilih Tanggal"),
              ),
              const SizedBox(height: 8),
              Text(
                selectedDate != null
                    ? "Tanggal: ${formatTanggal(selectedDate!)}"
                    : "Belum memilih tanggal",
              ),
            ] else ...[
              // TAHUN
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Tahun Hijriah"),
                onChanged: (value) {
                  tahunHijriah = int.tryParse(value);
                  updateHariList();
                },
              ),

              const SizedBox(height: 10),

              // BULAN DROPDOWN
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: "Bulan Hijriah"),
                items: List.generate(12, (index) {
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text(namaBulanHijriah[index]),
                  );
                }),
                onChanged: (value) {
                  bulanHijriah = value;
                  updateHariList();
                },
              ),

              const SizedBox(height: 10),

              // HARI DROPDOWN DINAMIS
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: "Hari"),
                items: hariList.map((hari) {
                  return DropdownMenuItem(
                    value: hari,
                    child: Text(hari.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  hariHijriah = value;
                },
              ),
            ],

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