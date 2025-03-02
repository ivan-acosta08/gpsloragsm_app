import 'package:flutter/material.dart';
import 'package:gpsloragsm_app/auth/login.dart';
import 'package:gpsloragsm_app/auth/signin.dart';
import 'package:gpsloragsm_app/context/theme.dart';
import 'package:gpsloragsm_app/home/home.dart';
import 'package:gpsloragsm_app/context/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => AuthModel()),
      ],
      child: const GPSLoRaGSM(),
    ),
  );
}

class GPSLoRaGSM extends StatelessWidget {
  const GPSLoRaGSM({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, AuthModel>(
      builder: (context, themeModel, authModel, child) {
        return SafeArea(
            child: MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          theme: ThemeData.light().copyWith(
            textTheme: GoogleFonts.plusJakartaSansTextTheme(
              TextTheme(
                bodySmall: TextStyle(color: Color(0xFF595f76), fontSize: 14),
                bodyMedium: TextStyle(color: Color(0xFF595f76), fontSize: 16),
                bodyLarge: TextStyle(color: Color(0xFF595f76), fontSize: 18),
                titleSmall: TextStyle(color: Color(0xFF595f76), fontSize: 20),
                titleMedium: TextStyle(color: Color(0xFF595f76), fontSize: 22),
                titleLarge: TextStyle(color: Color(0xFF595f76), fontSize: 24),
              ),
            ),
            scaffoldBackgroundColor: Color(0xFFffffff),
            shadowColor: Color.fromARGB(255, 240, 240, 240),
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Color.fromARGB(255, 245, 245, 245),
              filled: true,
              contentPadding: const EdgeInsets.all(15),
              hintStyle: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: const Color(0xff707589),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color.fromARGB(255, 241, 241, 241), width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color.fromARGB(255, 251, 166, 56), width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color.fromARGB(255, 136, 33, 27), width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color(0xffb12821), width: 2.0),
              ),
              errorStyle: TextStyle(color: Color.fromARGB(255, 136, 33, 27)),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: GoogleFonts.plusJakartaSansTextTheme(
              TextTheme(
                bodySmall: TextStyle(color: Colors.white, fontSize: 14),
                bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
                bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
                titleSmall: TextStyle(color: Colors.white, fontSize: 20),
                titleMedium: TextStyle(color: Colors.white, fontSize: 22),
                titleLarge: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            scaffoldBackgroundColor: Color.fromARGB(255, 15, 15, 15),
            shadowColor: Color.fromARGB(255, 30, 30, 30),
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Color(0xFF1a1d21),
              filled: true,
              contentPadding: const EdgeInsets.all(15),
              hintStyle: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: const Color(0xff707589),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color(0xFF1a1d21), width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color.fromARGB(255, 251, 166, 56), width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color.fromARGB(255, 136, 33, 27), width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(color: Color(0xffb12821), width: 2.0),
              ),
              errorStyle: TextStyle(color: Color.fromARGB(255, 136, 33, 27)),
            ),
          ),
          themeMode: themeModel.dark ? ThemeMode.dark : ThemeMode.light,
          home: authModel.user != null ? HomeScreen() : LoginScreen(),
          routes: {
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/home': (context) => HomeScreen(),
          },
        ));
      },
    );
  }
}
