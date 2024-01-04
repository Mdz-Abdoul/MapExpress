// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';



// class Actualite {
//   final String title;
//   final String content;
//   final String featuredImageSrc;
//   final String link;

//   Actualite({
//     required this.title,
//     required this.content,
//     required this.featuredImageSrc,
//     required this.link,
//   });

//   factory Actualite.fromJson(Map<String, dynamic> json) {
//     final rawTitle = json['title']['rendered'] ?? '';
//     final rawContent = json['content']['rendered'] ?? '';
//     final v_link = json['metadata']['v_link'][0] ?? '';

//     final cleantitle = parseHtmlString(rawTitle); // Nettoyer le titre HTML
//     final cleanContent = parseHtmlString(rawContent); // Nettoyer le contenu HTML

//     return Actualite(
//       title: cleantitle,
//       content: cleanContent,
//       featuredImageSrc: "https://img.youtube.com/vi/$v_link/0.jpg" ?? '',
//       link: v_link,
//     );
//   }
// }

// class MyWidgetMapLive extends StatefulWidget {
//   @override
//   _MyWidgetMapLiveState createState() => _MyWidgetMapLiveState();
// }

// class _MyWidgetMapLiveState extends State<MyWidgetMapLive> {
//   List<Actualite> actualites = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(
//         Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/videos?per_page=1'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);

//       setState(() {
//         actualites = jsonData
//             .map((json) => Actualite.fromJson(json))
//             .toList();
//       });
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Liste de Vidéos'),
//       // ),
//       body: Center(
//         child: CarouselSlider(
//           options: CarouselOptions(
//             height: 320,
//           aspectRatio: 16/9,
//           viewportFraction: 0.9,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: Duration(seconds: 4),
//           autoPlayAnimationDuration: Duration(milliseconds: 800),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           // pauseAutoPlayOnTouch: Duration(seconds: 10),
//           // enlargeCenterPage: true,
//           scrollDirection: Axis.horizontal,
//           ),
//           items: actualites.map((actualite) {
//             String imageUrl = actualite.featuredImageSrc;
//             String title = actualite.title;
//             String link = 'https://www.youtube.com/watch?v=${actualite.link}';
            
//             return Builder(
//               builder: (BuildContext context) {
//                 return GestureDetector(
//                   onTap: () {
//                     if (link != null && link.isNotEmpty) {
//                       launch(link);
//                     }
//                   },
//                   child: Column(
//                     children: [
//                       Image.network(imageUrl),
//                       // Text(title),
//                       // ElevatedButton(
//                       //   onPressed: () {
//                       //     // Ouvrir la vidéo dans un navigateur ou une application vidéo
//                       //   },
//                       //   child: Text('Voir la vidéo'),
//                       // ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// String parseHtmlString(String htmlString) {
//   return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

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
    final v_link = json['metadata']['v_link'][0] ?? '';

    final cleantitle = parseHtmlString(rawTitle); // Nettoyer le titre HTML

    return Actualite(
      title: cleantitle,
      content: "",
      featuredImageSrc: "https://img.youtube.com/vi/$v_link/0.jpg" ?? '',
      link: v_link,
    );
  }
}

class MyWidgetMapLive extends StatefulWidget {
  @override
  _MyWidgetMapLiveState createState() => _MyWidgetMapLiveState();
}

class _MyWidgetMapLiveState extends State<MyWidgetMapLive> {
  List<Actualite> actualites = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/videos?per_page=1'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      setState(() {
        actualites = jsonData
            .map((json) => Actualite.fromJson(json))
            .toList();
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 320,
          width: double.infinity,
          child: actualites.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    final link =
                        'https://www.youtube.com/watch?v=${actualites.first.link}';
                    if (link != null && link.isNotEmpty) {
                      launch(link);
                    }
                  },
                  child: Column(
                    children: [
                      Image.network(actualites.first.featuredImageSrc),
                      // Text(actualites.first.title),
                    ],
                  ),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

String parseHtmlString(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}
