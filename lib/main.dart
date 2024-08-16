import 'package:ora/accueil.dart';
import 'package:ora/homePage.dart';
import 'package:ora/controlAuth.dart';
import 'package:flutter/material.dart';
import 'package:ora/verification.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Utilisateur?>.value(
      value: StreamProviderAuth().utilisateur,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => Passerelle(),
          '/accueil': (context) => Accueil(name: '', email: '',),
        },
      ),
    );
  }
}
