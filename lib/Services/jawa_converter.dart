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

  /// Konversi dari DateTime ke jawir
  static JawaDate fromGregorian(DateTime date) {
    // Hari biasa
    String hari = hariList[date.weekday % 7];

    // Basis: 1 Januari 1900 = Pon (sebenarnya matematika pasaran membutuhkan offset +1
    // agar tanggal bertepatan dengan kalender Jawa/indikasi lokal saat ini).
    DateTime base = DateTime(1900, 1, 1);

    int selisih = date.difference(base).inDays;

    // Offset +1 untuk menyesuaikan dengan referensi pasaran yang akurat (contoh: 18 Mar 2026 = Wage)
    String pasaran = pasaranList[(selisih + 1) % 5];

    return JawaDate(hari: hari, pasaran: pasaran);
  }
}