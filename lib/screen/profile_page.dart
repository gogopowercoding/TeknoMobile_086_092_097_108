import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Tim Multilator"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ProfileCard(
            nama: "Hiero Purbandono",
            nim: "123230086",
            imagePath: "assets/images/hiro.jpeg",
          ),
          ProfileCard(
            nama: "Martin Aji Nugraha",
            nim: "123230092",
            imagePath: "assets/images/martin.jpeg",
          ),
          ProfileCard(
            nama: "Faisal Dani Noto Leogowo",
            nim: "123230097",
            imagePath: "assets/images/faisal.jpeg",
          ),
          ProfileCard(
            nama: "Furraihan Al Harits",
            nim: "123230108",
            imagePath: "assets/images/fuu.png",
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String imagePath;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          nama,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "NIM: $nim",
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}