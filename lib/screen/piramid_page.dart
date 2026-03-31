import 'dart:math';

import 'package:flutter/material.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final _formKey = GlobalKey<FormState>();
  final _sisiController = TextEditingController();
  final _tinggiController = TextEditingController();

  double? _luasPermukaan;
  double? _volume;

  void _hitung() {
    if (_formKey.currentState?.validate() != true) return;

    final sisi = double.tryParse(_sisiController.text.replaceAll(',', '.')) ?? 0;
    final tinggi = double.tryParse(_tinggiController.text.replaceAll(',', '.')) ?? 0;

    if (sisi <= 0 || tinggi <= 0) {
      setState(() {
        _luasPermukaan = null;
        _volume = null;
      });
      return;
    }

    final luasAlas = sisi * sisi;
    final tinggiSisi = sqrt(pow(sisi / 2, 2) + pow(tinggi, 2));
    final luasSelimut = 2 * sisi * tinggiSisi;
    final luasPermukaan = luasAlas + luasSelimut;
    final volume = luasAlas * tinggi / 3;

    setState(() {
      _luasPermukaan = luasPermukaan;
      _volume = volume;
    });
  }

  void _reset() {
    _sisiController.clear();
    _tinggiController.clear();
    setState(() {
      _luasPermukaan = null;
      _volume = null;
    });
  }

  @override
  void dispose() {
    _sisiController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luas & Volume Piramid'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Piramid Segiempat (Alas Persegi)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sisiController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Panjang Sisi Alas (s)',
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan nilai sisi alas (contoh: 10)',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Sisi tidak boleh kosong';
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return 'Masukkan angka positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tinggiController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Tinggi Piramid (t)',
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan nilai tinggi (contoh: 15)',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tinggi tidak boleh kosong';
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null || parsed <= 0) {
                    return 'Masukkan angka positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: _hitung,
                      child: const Text('Hitung'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: _reset,
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_luasPermukaan != null && _volume != null)
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hasil Perhitungan', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text('Luas Permukaan = ${_luasPermukaan!.toStringAsFixed(2)} satuan²'),
                        const SizedBox(height: 8),
                        Text('Volume = ${_volume!.toStringAsFixed(2)} satuan³'),
                        const SizedBox(height: 12),
                        const Text('Rumus:'),
                        const Text('Luas Alas = s × s'),
                        const Text('Tinggi Sisi = √((s/2)² + t²)'),
                        const Text('Luas Selimut = 2 × s × tinggi sisi'),
                        const Text('Luas Permukaan = Luas Alas + Luas Selimut'),
                        const Text('Volume = (1/3) × Luas Alas × t'),
                      ],
                    ),
                  ),
                )
              else
                const Center(
                  child: Text('Masukkan nilai kemudian tekan Hitung'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
