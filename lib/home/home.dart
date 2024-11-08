import 'package:flutter/material.dart';
import 'package:gpsloragsm_app/context/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthModel>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hola, ${user?.email}!'),
      ),
    );
  }
}
