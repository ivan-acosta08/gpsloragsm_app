import 'package:flutter/material.dart';
import 'package:gpsloragsm_app/context/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isObscured = true;
  String? _nameError, _emailError, _passwordError, _confirmPasswordError;

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
          "Crea una Cuenta",
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
                  SizedBox(height: 60),
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
                      child: Image.asset('assets/add-user.png', fit: BoxFit.cover, width: 20, height: 20),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Nombre
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nombre completo',
                      errorText: _nameError,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                        _nameError = null;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  // Correo electrónico
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Correo electrónico',
                      errorText: _emailError,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _emailError = null;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  // Contraseña
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      errorText: _passwordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                        _passwordError = null;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  // Confirmar Contraseña
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      hintText: 'Confirmar contraseña',
                      errorText: _confirmPasswordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                        _confirmPasswordError = null;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // Botón de registro
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
                        'Registrarse',
                        style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _nameError = _name.isNotEmpty ? null : 'Ingrese su nombre completo';
                        _emailError = _isValidEmail(_email) ? null : 'Ingrese un correo válido';
                        _passwordError = _password.isNotEmpty ? null : 'Ingrese una contraseña válida';
                        _confirmPasswordError = _password == _confirmPassword ? null : 'Las contraseñas no coinciden';
                      });

                      if (_emailError == null && _passwordError == null && _confirmPasswordError == null) {
                        authProvider.signUp(_email, _password);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cuenta creada exitosamente')),
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿Ya tienes una cuenta?",
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Inicia sesión",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 251, 166, 56),
                            ),
                          ),
                        )
                      ],
                    ),
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
