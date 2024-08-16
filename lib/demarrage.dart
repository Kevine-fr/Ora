import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demarrage extends StatefulWidget {
  const Demarrage({super.key});

  @override
  State<Demarrage> createState() => _DemarrageState();
}

class _DemarrageState extends State<Demarrage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 350),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white
                ),
                child: Icon(
                  Icons.car_rental,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
              SizedBox(height: 10,),
              Text('DomCarCenter',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),)
            ],
          ),
        ),),
    );
  }
}


