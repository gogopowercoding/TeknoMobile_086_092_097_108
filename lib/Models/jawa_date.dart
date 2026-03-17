class JawaDate {
  final String hari;
  final String pasaran;

  JawaDate({required this.hari, required this.pasaran});

  @override
  String toString() {
    return "$hari $pasaran";
  }
}