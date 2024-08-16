import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ora/homePage.dart';

class Liste extends StatefulWidget {
  const Liste({Key? key}) : super(key: key);

  @override
  State<Liste> createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  late Timer _timer;
  bool showBackButton = true;

  @override
  void initState() {
    super.initState();
    // Rafraîchissement toutes les secondes pour mettre à jour le temps écoulé
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Arrête le timer pour éviter les fuites de mémoire
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: showBackButton
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              )
            : null,
        title: Center(
          child: Text(
            'Mes Postes',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Aucun post trouvé.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              var imageUrl = post['image_url'];
              var comment = post['comment'];
              var timestamp = post['timestamp'] as Timestamp;

              // Convertir Timestamp en DateTime
              DateTime postDateTime = timestamp.toDate();

              // Calcul de la durée écoulée depuis le poste
              var difference = DateTime.now().difference(postDateTime);
              var timeAgo = '';
              if (difference.inDays > 0) {
                timeAgo = '${difference.inDays} j';
              } else if (difference.inHours > 0) {
                timeAgo = '${difference.inHours} h';
              } else if (difference.inMinutes > 0) {
                timeAgo = '${difference.inMinutes} min';
              } else {
                timeAgo = 'à l\'instant';
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.grey,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'image/kaiser.jpg',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Stin ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Il y'a $timeAgo", // Affichage du temps écoulé
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: double.infinity,
                    child: Text(
                      comment,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 175,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 175,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '0',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.repeat,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '0',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '0',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.eye,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '0',
                              style: TextStyle(color: Colors.grey),
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
        },
      ),
    );
  }
}
