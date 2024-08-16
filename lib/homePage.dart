import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ora/debatListe.dart';
import 'package:ora/poste.dart';
import 'package:ora/profil.dart';
import 'package:ora/search.dart';
import 'package:ora/stream.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully!');
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 2) {
        // Vérifie si l'onglet sélectionné est "Débats"
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DebatListe()),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false, // Permet de faire disparaitre le bouton arrow_back par defaut
            backgroundColor: Colors.black,
            floating: true,
            snap: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(top: 40, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
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
                          fit: BoxFit
                              .cover, // Ajuster l'image pour couvrir complètement le cercle
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profil()));
                    },
                  ),

                  // Text(
                  //   'H o m e',
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontFamily: 'DiamorScript',
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 33),
                  // ),

                  // IconButton(
                  //   onPressed: () {
                  //     signOut();
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 Connexion(basculation: () {})));
                  //   },
                  //   icon: Icon(
                  //     Icons.logout,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Search()));
                      },
                      icon: Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Stream()));
                      },
                      icon: Icon(
                        CupertinoIcons.cloud,
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          )
        ],
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1,
                thickness: 0.3,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
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
                              'image/kevine.PNG',
                              width: 40,
                              height: 40,
                              fit: BoxFit
                                  .cover, // Ajuster l'image pour couvrir complètement le cercle
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Kevine-Fr ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Icon(Icons.verified,
                                  color: Colors.blue, size: 20),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Never back down never what ?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              // overflow: TextOverflow.ellipsis, #Qui permet de mettre des points de suspension si l'espace width est atteint!
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'image/kaiser.jpg',
                                width: double.infinity,
                                height: 175,
                                fit: BoxFit
                                    .cover, // Ajuster l'image pour couvrir complètement le cercle
                              ),
                            ),
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
                                    CupertinoIcons.chat_bubble,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '41',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '14',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '144',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '414',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                thickness: 0.1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
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
                              'image/dev.jpg',
                              width: 40,
                              height: 40,
                              fit: BoxFit
                                  .cover, // Ajuster l'image pour couvrir complètement le cercle
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Chovro Goldo ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Icon(Icons.verified,
                                  color: Colors.blue, size: 20),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "POV quand ton pote te dit qu'il a enfin pecho :",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              // overflow: TextOverflow.ellipsis, #Qui permet de mettre des points de suspension si l'espace width est atteint!
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'image/l.jpg',
                                width: double.infinity,
                                height: 175,
                                fit: BoxFit
                                    .cover, // Ajuster l'image pour couvrir complètement le cercle
                              ),
                            ),
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
                                    CupertinoIcons.chat_bubble,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '11',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '25',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '66',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '123',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                thickness: 0.1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
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
                              'image/gojo.jpg',
                              width: 40,
                              height: 40,
                              fit: BoxFit
                                  .cover, // Ajuster l'image pour couvrir complètement le cercle
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Djewi ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Icon(Icons.verified,
                                  color: Colors.blue, size: 20),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "😂😂😂",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              // overflow: TextOverflow.ellipsis, #Qui permet de mettre des points de suspension si l'espace width est atteint!
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'image/yuji.jpg',
                                width: double.infinity,
                                height: 175,
                                fit: BoxFit
                                    .cover, // Ajuster l'image pour couvrir complètement le cercle
                              ),
                            ),
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
                                    CupertinoIcons.chat_bubble,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '211',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '122',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '333',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '798',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                thickness: 0.1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
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
                              'image/belzebuth.jpg',
                              width: 40,
                              height: 40,
                              fit: BoxFit
                                  .cover, // Ajuster l'image pour couvrir complètement le cercle
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Zstin4 ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Icon(Icons.verified,
                                  color: Colors.blue, size: 20),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Isagi yoichi x Hiori Yo 🤯😍🔥",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              // overflow: TextOverflow.ellipsis, #Qui permet de mettre des points de suspension si l'espace width est atteint!
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'image/hiori.jpg',
                                width: double.infinity,
                                height: 175,
                                fit: BoxFit
                                    .cover, // Ajuster l'image pour couvrir complètement le cercle
                              ),
                            ),
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
                                    CupertinoIcons.chat_bubble,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '57',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '87',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '101',
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '269',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
                thickness: 0.1,
                color: Colors.grey,
              ),
            ],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Post()),
          );
        },
        backgroundColor: Colors.white,
        shape: CircleBorder(), // Définir la forme circulaire
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }
}
