import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final String imageUrl;
  final String comment;

  PostDetailPage({required this.imageUrl, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Commentaire :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              comment,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}



