import 'package:flutter/material.dart';

class Img extends StatefulWidget {
  const Img({super.key});

  @override
  State<Img> createState() => _ImgState();
}

class _ImgState extends State<Img> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('images/gojo.jpg'),
    );
  }
}