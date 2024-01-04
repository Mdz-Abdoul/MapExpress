import 'package:flutter/material.dart';
import 'package:mapexpress/screens/page_favoris.dart';
import 'package:mapexpress/widget/appbar.dart';

import 'package:mapexpress/widget/menudrawer.dart';
import 'package:mapexpress/widget/navigationBottom.dart';
import 'package:mapexpress/widget/sectionone_reglage.dart';
import 'package:mapexpress/widget/sectiontwo_reglage.dart';

class PageReglage extends StatelessWidget {
  const PageReglage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbar(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            height: 60,
            child: MyBottomNavigationBar(
              indexG: 0,
            )),
      ),
      drawer: CustomDrawer(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 200, child: PageReglageone()),
          SizedBox(height: 200, child: PageReglagetwo()),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
            label: Text(
              "Accéder aux Favoris",
              style: TextStyle(
                color: Colors.white, // Couleur de la police blanche
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF1F72A5), // Couleur de l'arrière-plan bleu foncé
            ),
            icon: Icon(
              Icons.star,
              color: Colors.white, // Couleur de l'icône blanche
            ),
          )
        ],
      ),
    );
  }
}
