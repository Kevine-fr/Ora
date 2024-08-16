import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    // Simuler la progression
    _simulateProgress();
  }

  void _simulateProgress() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _progressValue = 0.2;
      });
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _progressValue = 0.4;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _progressValue = 0.6;
      });
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _progressValue = 0.8;
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _progressValue = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 75),
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 150),
              LinearProgressIndicator(
                value: _progressValue,
                color: Colors.black,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 10), // Espace pour le texte du pourcentage
              Text(
                '${(_progressValue * 100).toInt()}%', // Affichage du pourcentage
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Ajustement de l'espace après le texte du pourcentage
              if (_progressValue == 1.0) // Condition pour afficher le message de succès
                Text(
                  'Réservation effectuée avec succès!',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (_progressValue < 1.0) // Condition pour cacher le message de succès si la réservation n'est pas terminée
                Text(
                  'Réservation en cours...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
