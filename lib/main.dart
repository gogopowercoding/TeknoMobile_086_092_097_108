import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teknomobile_086_092_097_108/screen/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(
    DevicePreview(
      enabled: true, // WAJIB true
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true, // WAJIB untuk device_preview
      debugShowCheckedModeBanner: false,

      locale: DevicePreview.locale(context), // biar ikut device
      builder: DevicePreview.appBuilder, // penting juga

      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const Loginpage(),
    );
  }
}