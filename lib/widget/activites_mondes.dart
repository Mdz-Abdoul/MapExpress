import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:mapexpress/widget/flash_info.dart';
import 'package:mapexpress/screens/page_monde.dart';
import 'package:mapexpress/widget/appbarsecond.dart';
import 'package:mapexpress/widget/navigationBottom.dart';
import 'package:mapexpress/screens/page_gouvernementales.dart';

class Actualite {
  final String title;
  final String content;
  final String featuredImageSrc;
  final String links;

  Actualite({
    required this.title,
    required this.content,
    required this.featuredImageSrc,
    required this.links,
  });

  factory Actualite.fromJson(Map<String, dynamic> json) {
    final rawTitle = json['title']['rendered'] ?? '';
    final rawContent = json['content']['rendered'] ?? '';

    final cleantitle = parseHtmlString(rawTitle); // Nettoyer le titre HTML
    final cleanContent =
        parseHtmlString(rawContent); // Nettoyer le contenu HTML

    return Actualite(
      title: cleantitle,
      content: cleanContent,
      featuredImageSrc: json['featured_image_src_large'] ?? '',
      links: json['link'] ?? '',
    );
  }
}

// Fonction pour analyser le texte HTML et en extraire le texte brut
String parseHtmlString(String htmlString) {
  final htmlDocument = htmlParser.parse(htmlString);
  final text = htmlDocument.body!.text;
  return text;
}

class ActualiteDetailPage extends StatelessWidget {
  final Actualite actualite;

  ActualiteDetailPage({required this.actualite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbarsecond(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            height: 60,
            child: MyBottomNavigationBar(
              indexG: 0,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 8.0), // Espacement entre l'icône et le texte
                      SizedBox(
                        width: 120,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    lang == 'fr' ? 'FLASH INFO' : 'آخر الأخبار',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Icon(
                          Icons.newspaper, // Icône de journal
                          size: 24.0,
                          color: Colors.black,
                        ),
                      ),
                      TextScrollerWidget(),
                      // const Spacer(), // Pour pousser TextScrollerWidget vers la droite
                      // TextScrollerWidget(monMenu: monMenu),
                      SizedBox(),
                    ],
                  ),
                ),
              ),
              Text(
                actualite.title,
                textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Image.network(
                actualite.featuredImageSrc, // Affichez l'image de l'actualité
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10.0),
              Text(
                actualite.content,
                textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      shareContent(); // Appeler la fonction de partage
                    },
                     style: ElevatedButton.styleFrom(
                                  // backgroundColor: Color(0xFF1F72A5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/share.png",height: 20,width: 20, color: Colors.grey,), // Icône que vous souhaitez afficher
                        SizedBox(width: 8.0), // Espacement entre l'icône et le texte
                        Text(
                              lang == 'fr' ? 'Partagez cet article' : 'مشاركة',
                              style: TextStyle(color: Colors.grey),
                            ), // Texte du bouton
                      ],
                    ),
                  ),),
            ],
          ),
        ),
      ),
    );
  }
  void shareContent() {
          
        Share.share(actualite.links);
      }
}

class CustomContainerMondes extends StatefulWidget {
  @override
  _CustomContainerMondesState createState() => _CustomContainerMondesState();
}

class _CustomContainerMondesState extends State<CustomContainerMondes> {
  late Future<List<Actualite>> _actualites;
  String lang='fr';

  @override
  void initState() {
    super.initState();
    _actualites = fetchActualites();
  }

  Future<List<Actualite>> fetchActualites() async {
    lang = Provider.of<LangProvider>(context, listen: false).language!;
      Uri apiUri;

      if (lang == 'fr') {
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/actualite?actualites=53&per_page=1');
      } else if (lang == 'ar') {
        apiUri = Uri.parse('https://www.mapexpress.ma/ar/wp-json/wp/v2/actualite?actualites=24&per_page=1');
      } else {
        // Gérez le cas par défaut si lang n'est ni 'fr' ni 'ar'
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/actualite?actualites=53&per_page=1'); // Remplacez 'URL_PAR_DEFAUT' par l'URL souhaitée en cas de défaut
      }

      final response = await http.get(apiUri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final actualitesList =
          data.map((item) => Actualite.fromJson(item)).toList();

      return actualitesList;
    } else {
      throw Exception('Failed to load actualites');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Actualite>>(
      future: _actualites,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('Aucune actualité disponible');
        } else {
          final actualite = snapshot.data!.first;

          return InkWell(
            onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CustomContainerMondesList(),
                        ),
                      );
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              // margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFFEFEFEF),
                // border: Border.all(
                //   color: Colors.grey,
                //   width: 1.0,
                // ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Row(
                      mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        Text(
                          lang == 'fr' ? 'Monde' : 'عالم',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF1F72A5),
                          ),
                        ),
                      ],
                    ),
                 
                  SizedBox(height: 10.0),
            
                  // Affichez l'image de l'actualité
                  Image.network(
                    actualite.featuredImageSrc,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    actualite.title,
                    textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),maxLines: 3,
                  ),
                  SizedBox(height: 10.0),
                     Text(
                  actualite.content,
                  textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                  style: TextStyle(fontSize: 12),
                  maxLines: 3,
                ),
                 SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomContainerMondesList(),
                          ),
                        );
                      },
                        child: Text(
                          lang == 'fr' ? 'Afficher toutes les informations' : 'إظهار كافة المعلومات',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#1f72a5"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0), // <-- Radius
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}


