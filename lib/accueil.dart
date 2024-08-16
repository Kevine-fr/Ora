import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ora/connexion.dart';
import 'package:http/http.dart' as http;
import 'package:ora/reservation.dart';

class Accueil extends StatefulWidget {
  
  
  final String name;
  final String email;

 Accueil({required this.name, required this.email});


  @override
  State<Accueil> createState() => _AccueilState(name:name , email:email);
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;
  String email;
  String name;

  _AccueilState({required this.name, required this.email});  //Permet d'initialiser l'id a chaque objet correspondant


  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully!');
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  Future<List<dynamic>> voitureShow() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/voitureShow'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> voitures = jsonData['voitures'];

      // Récupérer les données des modèles
      final responseModeles =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/voitureShow'));
      if (responseModeles.statusCode == 200) {
        Map<String, dynamic> modelesData = json.decode(responseModeles.body);
        List<dynamic> modeles = modelesData['modeles'];

        // Associer les noms des modèles aux voitures
        for (var voiture in voitures) {
          var modeleId = voiture['modele_id'];
          var modeleData = modeles.firstWhere(
              (modele) => modele['id'] == modeleId,
              orElse: () => null);
          if (modeleData != null) {
            voiture['nom_modele'] = modeleData['nom'];
          }
        }
      } else {
        throw Exception('Impossible de charger les données des modèles');
      }

      final responseMarques =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/voitureShow'));
      if (responseMarques.statusCode == 200) {
        Map<String, dynamic> marqueData = json.decode(responseMarques.body);
        List<dynamic> marques = marqueData['marques'];

        // Associer les noms des modèles aux voitures
        for (var voiture in voitures) {
          var marqueId = voiture['marque_id'];
          var marqueData = marques.firstWhere(
              (marque) => marque['id'] == marqueId,
              orElse: () => null);
          if (marqueData != null) {
            voiture['nom_marque'] = marqueData['nom'];
          }
        }
      } else {
        throw Exception('Impossible de charger les données des modèles');
      }

      return voitures;
    } else {
      throw Exception('Impossible de charger les données des voitures');
    }
  }

  late int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(185),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            height: 205,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Location',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Text(
                            'Togo, Lomé',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.5, vertical: 2.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white12),
                        child: IconButton(
                          onPressed: () {
                            signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Connexion(basculation: () {})));
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      labelStyle: TextStyle(color: Colors.grey),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      suffixIcon: Icon(
                        Icons.filter_list,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_max_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Marques',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      Text(
                        'Voir tous',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Liste de catégories avec image et texte
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryCard(
                    image: 'image/younde.jpg',
                    text: 'Hyundai',
                  ),
                  CategoryCard(
                    image: 'image/mercedes.jpeg',
                    text: 'Mercedes',
                  ),
                  CategoryCard(
                    image: 'image/toyota.png',
                    text: 'Toyota',
                  ),
                  CategoryCard(
                    image: 'image/apsonic.png',
                    text: 'Apsonic',
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Voiture populaire',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      Text(
                        'Voir tous',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ],
              ),
              FutureBuilder<List<dynamic>>(
                future: voitureShow(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        // Extraction du nom du fichier à partir de l'URL
                        String imageUrl = snapshot.data?[index]['image'];
                        String fileName = imageUrl.split('/').last;
                        String imaginer = "image/";
                        String finalImg = imaginer + fileName;
                        String modeleNom = snapshot.data?[index]
                                ['nom_modele'] ??
                            'Nom de modèle inconnu';
                        int prix = snapshot.data?[index]
                                ['prix'] ??
                            'Nom de modèle inconnu';
                        //Recupération de l'id de la voiture
                        int id = snapshot.data?[index]['id'] ??
                            'id de la voiture inconnu';

                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 40,
                                              padding:
                                                  EdgeInsets.only(left: 13),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey[100]),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '0.0',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.grey[200]),
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Reservation(
                                                id: id,
                                                modeleId: snapshot.data?[index]['modele_id'],
                                                marqueId: snapshot.data?[index]['marque_id'],
                                                name: name,
                                                email: email

                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(finalImg),
                                      ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Text(
                                          modeleNom,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "$prix₣",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            '/jr',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String image;
  final String text;

  const CategoryCard({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}
