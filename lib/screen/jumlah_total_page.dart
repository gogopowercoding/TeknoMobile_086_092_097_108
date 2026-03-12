import 'package:flutter/material.dart';

class JumlahTotalPage extends StatefulWidget {
  const JumlahTotalPage({super.key});

  @override
  State<JumlahTotalPage> createState() => _JumlahTotalPageState();
}

class _JumlahTotalPageState extends State<JumlahTotalPage> {

  final TextEditingController jumlahController = TextEditingController();
  final List<TextEditingController> angkaControllers = [];
  final _formJumlahKey = GlobalKey<FormState>();
  int total = 0;
  bool inputSudahDibuat = false;

  void buatInput() {

    if (!_formJumlahKey.currentState!.validate()) {
      return;
    }

    int jumlah = int.parse(jumlahController.text);

    angkaControllers.clear();

    for (int i = 0; i < jumlah; i++) {
      angkaControllers.add(TextEditingController());
    }

    setState(() {
      inputSudahDibuat = true;
      total = 0;
    });
  }
  void tambahField() {
    setState(() {
      angkaControllers.add(TextEditingController());
    });
  }

  void kurangiField() {
    if (angkaControllers.isNotEmpty) {
      setState(() {
        angkaControllers.removeLast().dispose();
      });
    }
  }

  void resetInput() {

    for (var c in angkaControllers) {
      c.dispose();
    }

    angkaControllers.clear();
    jumlahController.clear();

    setState(() {
      inputSudahDibuat = false;
      total = 0;
    });
  }

  void hitungTotal() {

    int hasil = 0;

    for (var controller in angkaControllers) {

      if (controller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Semua field harus diisi")),
        );
        return;
      }

      int? angka = int.tryParse(controller.text);

      if (angka == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Input harus berupa angka")),
        );
        return;
      }

      hasil += angka;
    }

    setState(() {
      total = hasil;
    });
  }

  String? validasiAngka(String value) {

    if (value.isEmpty) {
      return "Tidak boleh kosong";
    }

    if (!RegExp(r'^-?\d+$').hasMatch(value)) {
      return "Harus angka";
    }

    return null;
  }

  @override
  void dispose() {
    jumlahController.dispose();
    for (var c in angkaControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumlah Total Angka"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [

             
              if (!inputSudahDibuat) ...[

                Form(
                  key: _formJumlahKey,
                  child: TextFormField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: "Berapa angka yang akan diinput?",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return "Jumlah angka harus diisi";
                      }

                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return "Harus berupa angka";
                      }

                      int jumlah = int.parse(value);

                      if (jumlah <= 0) {
                        return "Jumlah harus lebih dari 0";
                      }

                      if (jumlah > 50) {
                        return "Maksimal 50 input";
                      }

                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 15),

                ElevatedButton(
                  onPressed: buatInput,
                  child: const Text("Buat Input"),
                ),
              ],

              if (inputSudahDibuat) ...[

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: angkaControllers.length,
                  itemBuilder: (context, index) {

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: angkaControllers[index],
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => validasiAngka(value ?? ''),
                        decoration: InputDecoration(
                          labelText: "Angka ${index + 1}",
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      onPressed: tambahField,
                      child: const Text("+ Field"),
                    ),

                    const SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: kurangiField,
                      child: const Text("- Field"),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: hitungTotal,
                  child: const Text("Hitung Total"),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: resetInput,
                  child: const Text("Reset Input"),
                ),

                const SizedBox(height: 20),

                Text(
                  "Total: $total",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]

            ],
          ),
        ),
      ),
    );
  }
}