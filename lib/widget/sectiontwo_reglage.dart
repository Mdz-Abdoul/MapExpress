import 'package:flutter/material.dart';
import 'package:mapexpress/screens/page_favoris.dart';
import 'package:mapexpress/widget/sectionone_reglage.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

class PageReglagetwo extends StatefulWidget {
  @override
  _PageReglagetwoState createState() => _PageReglagetwoState();
}

class _PageReglagetwoState extends State<PageReglagetwo> {
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // Définissez une liste d'éléments sélectionnables
    final List<String> items = [
      'Acceuil',
      'Activités Royales',
      'Activités Princières',
      'Activités Gouvernementales',
      'Activités Parlementaires',
      'Activités Partisanes et Syndicales',
      'Société et Régions',
      'Economie et Finances',
      'Culture et Média',
      'Opinions et Débats',
      'Sports',
      'Société Civile et vie associative',
      'Droits de l\'Homme',
      'Grand Maghreb',
      'Monde',
      'Communiqués de presse',
      'MAP TV',
      'MAP LIVE',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choisissez"),
          content: MultiSelect(items: items, selectedItems: _selectedItems),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Valider"),
              onPressed: () {
                Navigator.of(context).pop(_selectedItems);
                _selectedItems.forEach((item) {
                  FavoritesManager.addToFavorites(item);
                });
              },
            ),
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ÉCRAN DE DÉMARRAGE",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              _selectedItems.join(", "),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _showMultiSelect,
              child: Text("Choisissez"),
            ),
          ],
        ),
      ),
    );
  }
}
