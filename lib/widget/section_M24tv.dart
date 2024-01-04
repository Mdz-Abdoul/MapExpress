import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mapexpress/screens/page_droit_homme.dart';

class Actualite {
  final String title;
  final String content;
  final String featuredImageSrc;

  Actualite({
    required this.title,
    required this.content,
    required this.featuredImageSrc,
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
      featuredImageSrc: "https://img.youtube.com/vi/$v_link/0.jpg",
    );
  }
}

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  List<Actualite> actualites = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://www.mapexpress.ma/wp-json/wp/v2/videos?per_page=10'));

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
      //   title: Text('Carrousel Automatique Flutter'),
      // ),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: Duration(seconds: 3),
          ),
          items: actualites.map((actualite) {
            String imageUrl = actualite.featuredImageSrc;
            String title = actualite.title;
            // Vous pouvez également utiliser actualite.content si nécessaire
            return Builder(
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Image.network(imageUrl),
                    Text(title),
                    ElevatedButton(
                      onPressed: () {
                        // Ouvrir la vidéo dans un navigateur ou une application vidéo
                      },
                      child: Text('Voir la vidéo'),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
