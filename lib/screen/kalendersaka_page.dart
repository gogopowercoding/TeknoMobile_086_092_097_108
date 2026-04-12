import 'package:flutter/material.dart';

class KalendersakaPage extends StatefulWidget {
  const KalendersakaPage({super.key});

  @override
  State<KalendersakaPage> createState() => _KalendersakaPageState();
}

class _KalendersakaPageState extends State<KalendersakaPage> {
  DateTime selectedDate = DateTime.now();

  final List<String> sakaMonths = [
    "Chaitra",
    "Vaisakha",
    "Jyaistha",
    "Asadha",
    "Sravana",
    "Bhadra",
    "Asvina",
    "Kartika",
    "Agrahayana",
    "Pausa",
    "Magha",
    "Phalguna"
  ];

  String convertToSaka(DateTime date) {
    int year = date.year;
    bool isLeap =
        (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);

    // Awal tahun Saka
    DateTime sakaNewYear =
        DateTime(year, 3, isLeap ? 21 : 22);

    int sakaYear;
    DateTime startYear;

    if (date.isBefore(sakaNewYear)) {
      sakaYear = year - 79;
      bool prevLeap =
          ((year - 1) % 4 == 0 && (year - 1) % 100 != 0) ||
              ((year - 1) % 400 == 0);

      startYear =
          DateTime(year - 1, 3, prevLeap ? 21 : 22);
    } else {
      sakaYear = year - 78;
      startYear = sakaNewYear;
    }

    int diffDays = date.difference(startYear).inDays;

    List<int> monthDays = [
      isLeap ? 31 : 30, // Chaitra
      31,
      31,
      31,
      31,
      31,
      30,
      30,
      30,
      30,
      30,
      30
    ];

    int month = 0;
    while (diffDays >= monthDays[month]) {
      diffDays -= monthDays[month];
      month++;
    }

    int day = diffDays + 1;

    return "$day ${sakaMonths[month]} $sakaYear";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender Saka"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              
              const Text(
                "Pilih Tanggal Masehi",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: const Text("Pilih Tanggal"),
              ),

              const SizedBox(height: 30),

              Text(
                "Tanggal Masehi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
              ),

              const SizedBox(height: 25),

              const Text(
                "Tanggal Saka",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                convertToSaka(selectedDate),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // 🔥 hitam
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}