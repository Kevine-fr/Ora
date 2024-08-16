import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:ora/loading.dart';

class Reservation extends StatefulWidget {
  final int id;
  final int modeleId;
  final int marqueId;
  final String name;
  final String email;

  Reservation(
      {required this.id,
      required this.modeleId,
      required this.marqueId,
      required this.name,
      required this.email});

  @override
  State<Reservation> createState() => _ReservationState(
      id: id, modeleId: modeleId, marqueId: marqueId, name: name, email: email);
}

class _ReservationState extends State<Reservation> {
  int id;
  int modeleId;
  int marqueId;
  String name;
  String email;
  late DateTime dateDebut;
  late DateTime dateFin;
  late String modeleNom;
  late String marqueNom;

  _ReservationState(
      {required this.id,
      required this.modeleId,
      required this.marqueId,
      required this.name,
      required this.email}); //Permet d'initialiser l'id a chaque objet correspondant

  Future<Map<String, dynamic>> voitureId(int id) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/voiture/$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print(data); // Imprime la réponse JSON brute
      return data;
    } else {
      throw Exception("Impossible d'identifier le véhicule");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Reservation du véhicule',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: voitureId(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text("Impossible de charger les données du véhicule"),
            );
          } else {
            var data = snapshot.data!;

            // Accès conditionnel aux champs JSON
            String imageUrl =
                data['voiture']?['image'] ?? 'Url_image_non_disponible';
            String fileName = imageUrl.split('/').last;
            String imaginer = "image/";
            String finalImg = imaginer + fileName;
            String modeleNom =
                data['voiture']?['modele']?['nom'] ?? 'Modèle inconnu';
            String marqueNom =
                data['voiture']?['marque']?['nom'] ?? 'Marque inconnue';
            String plaqueImmatriculation = data['voiture']
                    ?['plaque_immatriculation'] ??
                'Plaque immatriculation inconnue';
            String statut = data['voiture']?['statut'] ?? 'Statut inconnu';
            String coutLocationString =
                (data['voiture']?['prix']?.toString() ?? '0') + " ₣";
            String coutLocationWithoutCurrency =
                coutLocationString.replaceAll(' ₣', '');
            double coutLocation =
                double.tryParse(coutLocationWithoutCurrency) ?? 0.0;

            String anneeSortie = data['voiture']?['annee'] ?? 'Année inconnue';
            String option = data['voiture']?['option'] ?? 'Option inconnue';

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Image.asset(
                          finalImg,
                          height: 175,
                          width: 175,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  marqueNom,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 18,
                                    ),
                                    Text(
                                      '0.0',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              modeleNom,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.5,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  coutLocationString,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '/jr',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0.7,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Plaque d'immatriculation",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        plaqueImmatriculation,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Durée de la réservation",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "1 jours",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Marque du véhicule",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        marqueNom,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Modèle du véhicule",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        modeleNom,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Options intégrées",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        option,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Année de sortie",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        anneeSortie,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cout de location",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        coutLocationString,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Statut",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        statut,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blue),
                        child: TextButton(
                          onPressed: () async {
                            DateTime now = DateTime.now();
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(now);

                            // Obtention de la date du jour suivant
                            DateTime tomorrow =
                                DateTime.now().add(Duration(days: 1));
                            String formattedTomorrow =
                                DateFormat('yyyy-MM-dd').format(tomorrow);

                            Map<String, dynamic> data = {
                              'name': name,
                              'email': email,
                              'marque': marqueNom,
                              'modele': modeleNom,
                              'dateDebut': formattedDate,
                              'dateFin': formattedTomorrow,
                              'prix': coutLocation,
                            };

                            // URL de l'API Laravel
                            String apiUrl =
                                'http://10.0.2.2:8000/api/reservationSave';

                            try {
                              // Envoi de la requête POST
                              var response = await http.post(
                                Uri.parse(apiUrl),
                                body: jsonEncode(data),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                              );

                              // Vérification de la réponse
                              if (response.statusCode == 200) {
                                // Succès
                                print('Données envoyées avec succès');
                              } else {
                                // Erreur
                                print(
                                    'Erreur lors de l\'envoi des données : ${response.statusCode}');
                              }
                            } catch (e) {
                              // Erreur lors de la connexion
                              print('Erreur de connexion : $e');
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Loading()));
                          },
                          child: Text(
                            'Valider la réservation',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
