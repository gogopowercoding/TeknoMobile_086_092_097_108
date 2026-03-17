import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class KonversiTanggalHijriahPage extends StatefulWidget {
  const KonversiTanggalHijriahPage({super.key});

  @override
  State<KonversiTanggalHijriahPage> createState() => _KonversiTanggalHijriahPageState();
}

class _KonversiTanggalHijriahPageState extends State<KonversiTanggalHijriahPage> {
  bool isMasehiToHijri = true;
  DateTime? selectedDate;
  String hasil = "";
  int? hariHijriah;
  int? bulanHijriah;
  int? tahunHijriah;

  final List<String> namaBulanHijriah = [
    "Muharram","Safar","Rabiul Awal","Rabiul Akhir",
    "Jumadil Awal","Jumadil Akhir","Rajab","Sya'ban",
    "Ramadhan","Syawal","Dzulqa'dah","Dzulhijjah"
  ];
  void pilihTanggal() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        hasil = "";
      });
    }
  }
  int maxHariHijriah(int bulan) {
    // bulan ganjil = 30, genap = 29 (aturan sederhana)
    if (bulan % 2 == 1) return 30;
    return 29;
  }

  void konversi() {
    try {
      if (isMasehiToHijri) {
        if (selectedDate == null) {
          _error("Pilih tanggal dulu");
          return;
        }

        final h = HijriCalendar.fromDate(selectedDate!);

        setState(() {
          hasil = "${h.hDay} ${h.longMonthName} ${h.hYear} H";
        });

      } else {
        if (hariHijriah == null ||
            bulanHijriah == null ||
            tahunHijriah == null) {
          _error("Semua field Hijriah harus dipilih");
          return;
        }
        if (tahunHijriah! < 1356 || tahunHijriah! > 1500) {
          _error("Tahun hanya didukung antara 1356 - 1500 H");
          return;
        }
        int maxHari = maxHariHijriah(bulanHijriah!);
        if (hariHijriah! > maxHari) {
          _error("Bulan ${namaBulanHijriah[bulanHijriah! - 1]} hanya sampai $maxHari hari");
          return;
        }

        final h = HijriCalendar();

        DateTime masehi = h.hijriToGregorian(
          tahunHijriah!,
          bulanHijriah!,
          hariHijriah!,
        );

        setState(() {
          hasil = DateFormat("dd MMMM yyyy", "id_ID").format(masehi);
        });
      }
    } catch (e) {
      _error("Gagal konversi, cek kembali input");
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: SwitchListTile(
                  title: Text(
                    isMasehiToHijri
                        ? "Masehi → Hijriah"
                        : "Hijriah → Masehi",
                  ),
                  value: isMasehiToHijri,
                  onChanged: (val) {
                    setState(() {
                      isMasehiToHijri = val;
                      hasil = "";
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: isMasehiToHijri
                      ? Column(
                          children: [
                            Text(
                              selectedDate == null
                                  ? "Belum pilih tanggal"
                                  : formatTanggal(selectedDate!),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: pilihTanggal,
                              icon: const Icon(Icons.calendar_today),
                              label: const Text("Pilih Tanggal"),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            DropdownButtonFormField<int>(
                              initialValue: hariHijriah,
                              hint: const Text("Pilih Hari"),
                              items: List.generate(30, (i) {
                                return DropdownMenuItem(
                                  value: i + 1,
                                  child: Text("${i + 1}"),
                                );
                              }),
                              onChanged: (val) {
                                setState(() => hariHijriah = val);
                              },
                            ),

                            const SizedBox(height: 10),
                            DropdownButtonFormField<int>(
                              initialValue: bulanHijriah,
                              hint: const Text("Pilih Bulan"),
                              items: List.generate(12, (i) {
                                return DropdownMenuItem(
                                  value: i + 1,
                                  child: Text(namaBulanHijriah[i]),
                                );
                              }),
                              onChanged: (val) {
                                setState(() => bulanHijriah = val);
                              },
                            ),

                            const SizedBox(height: 10),

                            DropdownButtonFormField<int>(
                              initialValue: tahunHijriah,
                              hint: const Text("Pilih Tahun"),
                              items: List.generate(201, (i) {
                                int year = 1356 + i;
                                return DropdownMenuItem(
                                  value: year,
                                  child: Text("$year H"),
                                );
                              }),
                              onChanged: (val) {
                                setState(() => tahunHijriah = val);
                              },
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: konversi,
                      child: const Text("Konversi"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: clearAll,
                      child: const Text("Clear"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              if (hasil.isNotEmpty)
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text("Hasil",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(
                          hasil,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}