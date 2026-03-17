import '../models/jawa_date.dart';

class JawaConverter {
  static const List<String> hariList = [
    "Minggu",
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu"
  ];

  static const List<String> pasaranList = [
    "Legi",
    "Pahing",
    "Pon",
    "Wage",
    "Kliwon"
  ];

  /// Konversi dari DateTime ke Jawa
  static JawaDate fromGregorian(DateTime date) {
    // Hari biasa
    String hari = hariList[date.weekday % 7];

    // 🔥 Kunci: hitung pasaran
    // Basis: 1 Januari 1900 = Pon
    DateTime base = DateTime(1900, 1, 1);

    int selisih = date.difference(base).inDays;

    String pasaran = pasaranList[selisih % 5];

    return JawaDate(hari: hari, pasaran: pasaran);
  }
}