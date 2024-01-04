import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

// void main() {
//   runApp(MaterialApp(
//     home: VideoListPage(),
//   ));
// }

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

class ImageCarouselM24TV extends StatefulWidget {
  @override
  _ImageCarouselM24TVState createState() => _ImageCarouselM24TVState();
}

class _ImageCarouselM24TVState extends State<ImageCarouselM24TV> {
  List<Actualite> actualites = [];
  String lang='fr';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    lang = Provider.of<LangProvider>(context, listen: false).language!;
      Uri apiUri;

      if (lang == 'fr') {
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/videos?per_page=10');
      } else if (lang == 'ar') {
        apiUri = Uri.parse('https://www.mapexpress.ma/ar/wp-json/wp/v2/videos?per_page=10');
      } else {
        // Gérez le cas par défaut si lang n'est ni 'fr' ni 'ar'
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/videos?per_page=10'); // Remplacez 'URL_PAR_DEFAUT' par l'URL souhaitée en cas de défaut
      }

      final response = await http.get(apiUri);

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
    
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Liste de Vidéos'),
      // ),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 350,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            // pauseAutoPlayOnTouch: Duration(seconds: 10),
            // enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: actualites.map((actualite) {
            String imageUrl = actualite.featuredImageSrc;
            String title = actualite.title;
            String link = 'https://www.youtube.com/watch?v=${actualite.link}';

            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    if (link != null && link.isNotEmpty) {
                      launch(link);
                    }
                  },
                  child: Column(
                    children: [
                      Image.network(imageUrl),
                      Text(parseHtmlString(title)),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Ouvrir la vidéo dans un navigateur ou une application vidéo
                      //   },
                      //   child: Text('Voir la vidéo'),
                      // ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

String parseHtmlString(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}
