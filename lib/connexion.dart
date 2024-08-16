import 'package:flutter/material.dart';
import 'package:ora/chargement.dart';
import 'package:ora/controlAuth.dart';
import 'package:ora/homePage.dart';
import 'package:ora/inscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key, required void Function() basculation});

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  bool _isObscured = true;
  bool chargement = false;
  bool _termsAccepted = true;

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Vérifier si l'utilisateur existe déjà dans Firestore
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (documentSnapshot.exists) {
        // L'utilisateur existe déjà, ne rien faire
        print('User already registered!');
        return;
      }

      // L'utilisateur n'existe pas, enregistrer les informations
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'nom': nameController.text,
        'email': emailController.text,
        'mot de passe': passwordController.text,
      });

      // Assigner l'userId
      userId = userCredential.user!.uid;
      // Appeler saveUserData avec l'userId initialisé
      await saveUserData(userId);

      print('User registered successfully!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Passerelle()),
      );
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  Future<void> saveUserData(String userId) async {
    await _firestore.collection('users').doc(userId).set({
      'nom': nameController.text,
      'email': emailController.text,
      'mot_de_passe': passwordController.text,
    });
  }

  late String userId;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return chargement 
    ? Chargement()
    : Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Center(
                  child: Text(
                    'Bon retour chez Cars, votre application favorite de location',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mail';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                Text(
                  'Mot de passe',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  style: TextStyle(color: Colors.black),
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Mot de passe',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          _isObscured ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      },
                    ),
                    Text(
                      'J\'accepte les conditions d\'utilisation',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              UserCredential userCredential =
                                  await _auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              // Vérifier si l'utilisateur existe déjà dans Firestore
                              DocumentSnapshot documentSnapshot =
                                  await _firestore
                                      .collection('users')
                                      .doc(userCredential.user!.uid)
                                      .get();
                              if (!documentSnapshot.exists) {
                                // L'utilisateur n'existe pas
                                print('User does not exist!');
                                return;
                              }

                              // L'utilisateur existe, connectez-le
                              print('User signed in successfully!');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            } catch (e) {
                              // Une erreur s'est produite lors de la connexion
                              print('Error during sign in: $e');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Erreur de connexion'),
                                    content: Text(
                                        "Le mot de passe ou l'adresse mail sont incorrectes."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pas de compte ?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => inscription(
                                        basculation: () {},
                                      )));
                        },
                        child: Text(
                          "S'inscrire !",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
