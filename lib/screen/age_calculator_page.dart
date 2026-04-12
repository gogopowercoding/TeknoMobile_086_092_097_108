import 'dart:async';
import 'package:flutter/material.dart';

class AgeCalculatorPage extends StatefulWidget {
  const AgeCalculatorPage({super.key});

  @override
  State<AgeCalculatorPage> createState() => _AgeCalculatorPageState();
}

class _AgeCalculatorPageState extends State<AgeCalculatorPage> {
  DateTime? selectedDateTime;
  String ageResult = '';
  final TextEditingController _dateTimeController = TextEditingController();

  Timer? _timer;

  final Map<String, int> _timezones = {
    'UTC-12': -720,
    'UTC-11': -660,
    'UTC-10': -600,
    'UTC-9': -540,
    'UTC-8': -480,
    'UTC-7': -420,
    'UTC-6': -360,
    'UTC-5': -300,
    'UTC-4': -240,
    'UTC-3': -180,
    'UTC-2': -120,
    'UTC-1': -60,
    'UTC+0': 0,
    'UTC+1': 60,
    'UTC+2': 120,
    'UTC+3': 180,
    'UTC+4': 240,
    'UTC+5': 300,
    'UTC+6': 360,
    'UTC+7': 420,
    'UTC+8': 480,
    'UTC+9': 540,
    'UTC+10': 600,
    'UTC+11': 660,
    'UTC+12': 720,
    'UTC+13': 780,
    'UTC+14': 840,
  };

  late String _selectedTimeZone;
  late String _selectedBirthTimeZone;

  bool isAbsoluteMode = false;

  @override
  void initState() {
    super.initState();

    final localTz = _getLocalTimezone();
    _selectedTimeZone = localTz;
    _selectedBirthTimeZone = localTz;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (selectedDateTime != null) {
        _calculateAge();
      }
    });
  }

  String _getLocalTimezone() {
    final offset = DateTime.now().timeZoneOffset.inHours;
    return 'UTC${offset >= 0 ? '+' : ''}$offset';
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDateTime = pickedDateTime;
          _dateTimeController.text =
              '${pickedDateTime.day}/${pickedDateTime.month}/${pickedDateTime.year} ${pickedDateTime.hour}:${pickedDateTime.minute.toString().padLeft(2, '0')}';
          _calculateAge();
        });
      }
    }
  }

  // 🔥 UMUR KALENDER
  String _calculateCalendarAge(DateTime birth, DateTime now) {
    int years = now.year - birth.year;
    int months = now.month - birth.month;
    int days = now.day - birth.day;

    if (days < 0) {
      months--;
      final prevMonth = DateTime(now.year, now.month, 0);
      days += prevMonth.day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    Duration diff = now.difference(birth);
    int hours = diff.inHours % 24;
    int minutes = diff.inMinutes % 60;
    int seconds = diff.inSeconds % 60;

    return '$years tahun, $months bulan, $days hari\n'
        '$hours jam, $minutes menit, $seconds detik';
  }

  // 🔥 UMUR ABSOLUT
  String _calculateAbsoluteAge(DateTime birth) {
    final birthOffset =
        Duration(minutes: _timezones[_selectedBirthTimeZone] ?? 0);
    final nowOffset =
        Duration(minutes: _timezones[_selectedTimeZone] ?? 0);

    final birthUtc = birth.subtract(birthOffset);
    final nowUtc = DateTime.now().toUtc();
    final nowInZone = nowUtc.add(nowOffset);

    Duration diff = nowInZone.difference(birthUtc);

    return '''
${diff.inDays} hari
${diff.inHours} jam
${diff.inMinutes} menit
${diff.inSeconds} detik
''';
  }

  void _calculateAge() {
    if (selectedDateTime == null) return;

    final now = DateTime.now();

    setState(() {
      if (isAbsoluteMode) {
        ageResult = _calculateAbsoluteAge(selectedDateTime!);
      } else {
        ageResult = _calculateCalendarAge(selectedDateTime!, now);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Umur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                isAbsoluteMode
                    ? 'Mode Absolut (UTC)'
                    : 'Mode Kalender',
              ),
              value: isAbsoluteMode,
              onChanged: (value) {
                setState(() {
                  isAbsoluteMode = value;
                  _calculateAge();
                });
              },
            ),

            const SizedBox(height: 16),

            if (isAbsoluteMode) ...[
              Row(
                children: [
                  const Text('Timezone Lahir:'),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedBirthTimeZone,
                      items: _timezones.keys
                          .map((tz) => DropdownMenuItem(
                                value: tz,
                                child: Text(tz),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _selectedBirthTimeZone = value!;
                        _calculateAge();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Timezone Sekarang:'),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedTimeZone,
                      items: _timezones.keys
                          .map((tz) => DropdownMenuItem(
                                value: tz,
                                child: Text(tz),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _selectedTimeZone = value!;
                        _calculateAge();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            TextFormField(
              controller: _dateTimeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Tanggal & Waktu Lahir',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _selectDateTime(context),
            ),

            const SizedBox(height: 20),

            if (selectedDateTime == null)
              const Text(
                'Silakan pilih tanggal lahir terlebih dahulu',
                style: TextStyle(color: Colors.grey),
              ),

            if (ageResult.isNotEmpty)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Umur Anda',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ageResult,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}