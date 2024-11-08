import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  User? get user => _user;

  // Constructor: escucha los cambios en el estado de autenticación
  AuthModel() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Métodos de autenticación
  Future<void> signIn(String email, String password) async {
    print(email);
    print(password);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Error en inicio de sesión: $e');
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Error en registro: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Error en inicio de sesión con Google: $e');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    print('Intentando enviar el enlace de recuperación a: $email');

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Enlace de recuperación enviado exitosamente a: $email');
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            print('Error: El correo electrónico ingresado no es válido.');
            break;
          case 'user-not-found':
            print('Error: No existe ninguna cuenta asociada con el correo electrónico ingresado.');
            break;
          default:
            print('Error al enviar enlace de recuperación: ${e.message}');
        }
      } else {
        print('Error desconocido al enviar enlace de recuperación: $e');
      }
    }
  }
}
