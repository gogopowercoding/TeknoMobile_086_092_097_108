class HijriDate {
  final int day;
  final int month;
  final int year;

  HijriDate({
    required this.day,
    required this.month,
    required this.year,
  });

  static const List<String> namaBulan = [
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

  String get namaBulanString => namaBulan[month - 1];

  @override
  String toString() {
    return "$day $namaBulanString $year H";
  }
}