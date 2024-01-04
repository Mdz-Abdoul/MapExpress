import 'package:flutter/material.dart';
import 'package:mapexpress/screens/page_favoris.dart';


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

class PageReglageone extends StatefulWidget {
  @override
  _PageReglageoneState createState() => _PageReglageoneState();
}

class _PageReglageoneState extends State<PageReglageone> {
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // Définissez une liste d'éléments sélectionnables
    final List<String> items = [
      'Activités Royales',
      'Activités Princières',
      'Activités Parlementaires',
      'Activités Gouvernementales',
      'Activités Partisanes et Syndicales',
      'Société et Région',
      'Economie et Finances',
      'Culture et Média',
      'Opinions et Débats',
      'Sports',
      'Société Civile et vie associative',
      'Droits de l\'Homme',
      'Grand Maghreb',
      'Monde',
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
              "NOTIFICATIONS",
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

class MultiSelect extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  MultiSelect({required this.items, required this.selectedItems});

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.items.map((item) {
          return CheckboxListTile(
            value: widget.selectedItems.contains(item),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) {
              setState(() {
                if (isChecked!) {
                  widget.selectedItems.add(item);
                } else {
                  widget.selectedItems.remove(item);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
