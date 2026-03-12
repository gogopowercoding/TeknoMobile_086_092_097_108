import 'package:flutter/material.dart';

class PenjumlahanPage extends StatefulWidget {
  const PenjumlahanPage({super.key});

  @override
  State<PenjumlahanPage> createState() => _PenjumlahanPageState();
}

class _PenjumlahanPageState extends State<PenjumlahanPage> {

  String currentInput = "";
  String history = "";
  double result = 0;
  String operator = "";

  void inputAngka(String angka) {
    setState(() {
      currentInput += angka;
    });
  }

  void setOperator(String op) {
    if (currentInput.isEmpty) return;

    double value = double.parse(currentInput);

    if (operator == "+") {
      result += value;
    } else if (operator == "-") {
      result -= value;
    } else {
      result = value;
    }

    history += "$currentInput $op ";

    operator = op;
    currentInput = "";

    setState(() {});
  }

  void hitungHasil() {
    if (currentInput.isEmpty) return;

    double value = double.parse(currentInput);

    if (operator == "+") {
      result += value;
    } else if (operator == "-") {
      result -= value;
    }

    setState(() {
      history += "$currentInput =";
      currentInput = result.toString();
      result = 0;
      operator = "";
    });
  }

  void clear() {
    setState(() {
      currentInput = "";
      history = "";
      result = 0;
      operator = "";
    });
  }

  Widget tombol(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator Sederhana"),
      ),
      body: Column(
        children: [

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              history,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              currentInput.isEmpty ? "0" : currentInput,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Row(
            children: [
              tombol("1", onPressed: () => inputAngka("1")),
              tombol("2", onPressed: () => inputAngka("2")),
              tombol("3", onPressed: () => inputAngka("3")),
              tombol("+", onPressed: () => setOperator("+")),
            ],
          ),

          Row(
            children: [
              tombol("4", onPressed: () => inputAngka("4")),
              tombol("5", onPressed: () => inputAngka("5")),
              tombol("6", onPressed: () => inputAngka("6")),
              tombol("-", onPressed: () => setOperator("-")),
            ],
          ),

          Row(
            children: [
              tombol("7", onPressed: () => inputAngka("7")),
              tombol("8", onPressed: () => inputAngka("8")),
              tombol("9", onPressed: () => inputAngka("9")),
              tombol("=", onPressed: hitungHasil),
            ],
          ),

          Row(
            children: [
              tombol("0", onPressed: () => inputAngka("0")),
              tombol("C", onPressed: clear),
            ],
          ),
        ],
      ),
    );
  }
}