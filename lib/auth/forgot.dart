import 'package:flutter/material.dart';
import 'package:gpsloragsm_app/context/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecoverPasswordScreen extends StatefulWidget {
  @override
  _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = '';
  String? _emailError;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reiniciar Contraseña",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(flex: 1, child: SizedBox(height: 20)),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(36),
                      ),
                      color: Color(Theme.of(context).brightness == Brightness.dark ? 0xFF1a1e21 : 0xFFf5f5f5),
                    ),
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.asset('assets/unlocked.png', fit: BoxFit.cover, width: 20, height: 20),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Introduzca la dirección de correo electrónico para enviarle un enlace y restablecer su contraseña.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Correo electrónico',
                      errorText: _emailError,
                      suffixIcon: _email.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: _emailError != null ? Color(0xFFa41b22) : Theme.of(context).textTheme.bodyLarge!.color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _emailController.clear();
                                  _email = '';
                                  _emailError = null;
                                });
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _emailError = null;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    "No olvides revisar tu carpeta de spam o correo no deseado.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: Color.fromARGB(255, 204, 204, 204),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(flex: 2, child: SizedBox(height: 20)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 251, 166, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        'Enviar enlace',
                        style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _emailError = _isValidEmail(_emailController.text.toString()) ? null : 'Ingrese un correo válido';
                      });

                      if (_isValidEmail(_emailController.text)) {
                        authProvider.sendPasswordResetEmail(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enlace de recuperación enviado a ${_emailController.text}')),
                        );
                      } else {
                        setState(() {
                          _emailError = 'Ingrese un correo válido';
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
