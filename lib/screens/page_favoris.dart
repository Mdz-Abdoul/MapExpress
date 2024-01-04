import 'package:flutter/material.dart';
import 'package:mapexpress/widget/appbar.dart';
import 'package:mapexpress/widget/menudrawer.dart';
import 'package:mapexpress/widget/navigationBottom.dart';

class FavoritesManager {
  static List<String> favorites = [];

  static void addToFavorites(String item) {
    if (!favorites.contains(item)) {
      favorites.add(item);
    }
  }

  static void removeFromFavorites(String item) {
    favorites.remove(item);
  }
}
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbar(),
      ),
      drawer: CustomDrawer(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            height: 60,
            child: MyBottomNavigationBar(
              indexG: 0,
            )),
      ),
      body: ListView.builder(
        itemCount: FavoritesManager.favorites.length,
        itemBuilder: (context, index) {
          final item = FavoritesManager.favorites[index];
          return ListTile(
            title: Text(item),
          );
        },
      ),
    );
  }
}