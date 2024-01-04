import 'package:flutter/material.dart';

class ImageMediateur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mediateur de la Map',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(226, 44, 161, 219),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity, // Largeur du container
              height: 250, // Hauteur du container
              color: Colors.blue, // Couleur de fond du container
              child: Image.asset(
                'assets/images/mediateur-map.jpg', // Chemin de l'image depuis les ressources
                fit: BoxFit.cover, // Ajustement de l'image dans le container
              ),
            ),
          ],
        ),
      ),
    );
  }
}
