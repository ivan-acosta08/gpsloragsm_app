import 'package:flutter/material.dart';
import 'package:gpsloragsm_app/auth/forgot.dart';
import 'package:gpsloragsm_app/auth/signin.dart';
import 'package:gpsloragsm_app/context/auth.dart';
import 'package:gpsloragsm_app/context/theme.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  bool _isObscured = true;
  String? _emailError, _passwordError;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthModel>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Container(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.asset('assets/icon.png', fit: BoxFit.cover, width: 20, height: 20),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Inicia Sesión",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Correo electrónico',
                      errorText: _emailError,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_email.isNotEmpty)
                            IconButton(
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
                            ),
                        ],
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _emailError = null;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      errorText: _passwordError,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_password.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: _passwordError != null ? Color(0xFFa41b22) : Theme.of(context).textTheme.bodyLarge!.color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordController.clear();
                                  _password = '';
                                });
                              },
                            ),
                          IconButton(
                            icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).textTheme.bodyLarge!.color),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                        _passwordError = null;
                      });
                    },
                  ),
                  SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RecoverPasswordScreen()),
                        );
                      },
                      child: Text(
                        "¿Olvidaste tu contraseña?",
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
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
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      child: Text(
                        'Iniciar Sesión',
                        style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _emailError = _isValidEmail(_email) ? null : 'Ingrese un correo válido';
                        _passwordError = _password.isNotEmpty ? null : 'Ingrese una contraseña valida';
                      });

                      if (_isValidEmail(_email)) {
                        authProvider.signIn(_email, _password);
                      } else {
                        setState(() {
                          _emailError = 'Ingrese un correo válido';
                          _passwordError = 'Ingrese una contraseña valida';
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "¿No tienes una cuenta?",
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Text(
                              "Crea una",
                              style: TextStyle(fontWeight: FontWeight.w500, color: Color.fromARGB(255, 251, 166, 56)),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Color(0xFFeaedf2),
                        height: 1,
                        width: MediaQuery.of(context).size.width * 0.425,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "o",
                      ),
                      SizedBox(width: 4),
                      Container(
                        color: Color(0xFFeaedf2),
                        height: 1,
                        width: MediaQuery.of(context).size.width * 0.425,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 245, 245, 245),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/google.png', fit: BoxFit.cover, width: 20, height: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Google',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            color: Color(0xFF5e657a),
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      authProvider.signInWithGoogle();
                    },
                  ),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
