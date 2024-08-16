import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ora/discussion.dart';

class DebatListe extends StatefulWidget {
  const DebatListe({super.key});

  @override
  State<DebatListe> createState() => _DebatListeState();
}

class _DebatListeState extends State<DebatListe> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.black,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 40, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.more_horiz_rounded, color: Colors.blue),
                Row(
                  children: [
                    Icon(CupertinoIcons.camera, color: Colors.blue),
                    SizedBox(width: 35),
                    Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.grey[900]?.withOpacity(0.5),
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_max),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.group, size: 33),
              label: 'Communautés',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2_fill, size: 30),
              label: 'Debats',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discussions',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[800],
                        filled: true,
                        prefixIcon: Icon(Icons.search, color: Colors.white54),
                        iconColor: Colors.white54,
                        labelText: 'Recherche',
                        labelStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                  SizedBox(width: 13),
                  Icon(
                    Icons.filter_list,
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.grey,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'images/kaiser.jpg',
                            width: 45,
                            height: 45,
                            fit: BoxFit
                                .cover, // Ajuster l'image pour couvrir complètement le cercle
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kévine',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                          Text(
                            "Femme est bizarre keh !",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    '03:00',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.1,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Discussion()),
    );
  },
      backgroundColor: Colors.blue,
      shape: CircleBorder(),  // Définir la forme circulaire
      child: Icon(Icons.add,
      color: Colors.white,),
    ),
    );
  }
}
