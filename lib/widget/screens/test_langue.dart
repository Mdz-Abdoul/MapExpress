// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:mapexpress/config/lang.dart';
// import 'package:mapexpress/widget/communique_presse.dart';

// class LanguageSelectionPageTest extends StatefulWidget {
//   @override
//   _LanguageSelectionPageTestState createState() => _LanguageSelectionPageTestState();
// }

// class _LanguageSelectionPageTestState extends State<LanguageSelectionPageTest> {
//   late Future<List<Actualite>> _actualites;
//   String selectedLanguage = 'fr';

//   @override
//   void initState() {
//     super.initState();
//     // Récupérer le provider LangProvider
//     final langProvider = Provider.of<LangProvider>(context, listen: false);
//     _actualites = fetchActualites(langProvider.language ?? 'fr');
//   }
//   Future<List<Actualite>> fetchActualites(String languageCode) async {
//   String apiUrl = 'https://www.mapexpress.ma/wp-json/wp/v2/actualite?actualites=28&per_page=1';

//   if (languageCode == 'ar') {
//     apiUrl = 'https://www.mapexpress.ma/ar/wp-json/wp/v2/actualite?actualites=11&per_page=1';
//   }

//   final response = await http.get(Uri.parse(apiUrl));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = json.decode(response.body);
//     final actualitesList = data.map((item) => Actualite.fromJson(item)).toList();

//     return actualitesList;
//   } else {
//     throw Exception('Failed to load actualites');
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sélection de langue'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   // Utiliser le provider pour changer la langue
//                   final langProvider = Provider.of<LangProvider>(context, listen: false);
//                   langProvider.setLang('fr');
//                   selectedLanguage = 'fr';
//                   _actualites = fetchActualites('fr');
//                 });
//               },
//               child: Text('Français'),
//               style: selectedLanguage == 'fr'
//                   ? ElevatedButton.styleFrom(primary: Colors.blue)
//                   : null,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   final langProvider = Provider.of<LangProvider>(context, listen: false);
//                   langProvider.setLang('ar');
//                   selectedLanguage = 'ar';
//                   _actualites = fetchActualites('ar');
//                 });
//               },
//               child: Text('Arabe'),
//               style: selectedLanguage == 'ar'
//                   ? ElevatedButton.styleFrom(primary: Colors.blue)
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
