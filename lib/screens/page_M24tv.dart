import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/widget/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mapexpress/widget/flash_info.dart';
import 'package:mapexpress/widget/menudrawer.dart';
import 'package:mapexpress/widget/navigationBottom.dart';


class Actualite {
  final String title;
  final String content;
  final String featuredImageSrc;
  final String link;

  Actualite({
    required this.title,
    required this.content,
    required this.featuredImageSrc,
    required this.link,
  });

  factory Actualite.fromJson(Map<String, dynamic> json) {
    final rawTitle = json['title']['rendered'] ?? '';
    final rawContent = json['content']['rendered'] ?? '';
    final v_link = json['metadata']['v_link'][0] ?? '';

    final cleantitle = parseHtmlString(rawTitle); // Nettoyer le titre HTML
    final cleanContent =
        parseHtmlString(rawContent); // Nettoyer le contenu HTML

    return Actualite(
      title: cleantitle,
      content: cleanContent,
      featuredImageSrc: "https://img.youtube.com/vi/$v_link/0.jpg" ?? '',
      link: v_link,
    );
  }
}

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  List<Actualite> actualites = [];
  int _nombreActuCharges = 10;
   String lang='fr';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://www.mapexpress.ma/wp-json/wp/v2/videos?per_page=$_nombreActuCharges'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      setState(() {
        actualites = jsonData.map((json) => Actualite.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    String lang ='fr';
    lang = Provider.of<LangProvider>(context).getCurrentLang();
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
              indexG: 2,
            )),
      ),
      body: Column(
        children: [
           Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                child: Row(
                  children: [
                    // const SizedBox(
                    //     width: 8.0), // Espacement entre l'icône et le texte
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/flash-fr.png"), // Remplacez par le chemin de votre image
                              // image: AssetImage('assets/images/flash-fr.webp'), // Remplacez par le chemin de votre image
                              fit: BoxFit.cover, // Ajustez selon vos besoins
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  lang == 'fr' ? 'FLASH INFO' : 'آخر الأخبار',
                                  style: TextStyle(color: Colors.white,fontSize: 12),
                                )),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   child: Icon(
                    //     Icons.newspaper, // Icône de journal
                    //     size: 24.0,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    TextScrollerWidget(),
                    // const Spacer(), // Pour pousser TextScrollerWidget vers la droite
                    // TextScrollerWidget(monMenu: monMenu),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: actualites.length,
              itemBuilder: (context, index) {
                final actualite = actualites[index];
                String imageUrl = actualite.featuredImageSrc;
                String title = actualite.title;
                String link =
                    'https://www.youtube.com/watch?v=${actualite.link}'; // Format du lien

                return GestureDetector(
                  onTap: () {
                    if (link != null && link.isNotEmpty) {
                      launch(link);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.network(imageUrl),
                        SizedBox(height: 8.0),
                        Text(title),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String parseHtmlString(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}
