import 'dart:async';
import 'dart:convert';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';

class FlashData {
  final String title;

  FlashData({
    required this.title,
  });

  factory FlashData.fromJson(Map<String, dynamic> json) {
    return FlashData(
      title: json['title'] ?? '',
    );
  }
}

class TextScrollerWidget extends StatefulWidget {
  @override
  _TextScrollerWidgetState createState() => _TextScrollerWidgetState();
}

class _TextScrollerWidgetState extends State<TextScrollerWidget> {
  late Future<List<FlashData>> _data;
  String lang = 'fr';

  @override
  void initState() {
    super.initState();
    _data = fetchDataFromApi();
  }

  Future<List<FlashData>> fetchDataFromApi() async {
    lang = Provider.of<LangProvider>(context, listen: false).language!;
    Uri apiUri;

    if (lang == 'fr') {
      apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wl/v1/flash');
    } else if (lang == 'ar') {
      apiUri =
          Uri.parse('https://www.mapexpress.ma/ar/wp-json/wl/v1/flash');
    } else {
      apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wl/v1/flash');
    }

    try {
      final response = await http.get(apiUri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final flashDataList = data.map((item) {
          return FlashData.fromJson(item);
        }).toList();

        return flashDataList;
      } else {
        throw Exception('Échec du chargement des données');
      }
    } catch (e) {
      throw Exception('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlashData>>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Aucune donnée disponible');
        } else {
          final titles = snapshot.data!
              .map((flashData) => flashData.title);
              
          String mapTextSpanString = 'MAP';

          

        TextSpan mapTextSpan = TextSpan(
          text: mapTextSpanString,
          style: TextStyle(color: Colors.blue, fontSize: 16.0,fontWeight:  FontWeight.bold),
        );

        String marqueeText = titles
            .map((title) => '$title '   '  ${mapTextSpan.toPlainText()}')
            .join("       ");

          return Expanded(
            child: SizedBox(
              height: 35,
              width: double.infinity,
              child: Container(
                color: const Color.fromARGB(255, 221, 221, 221),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Marquee(
                    text: marqueeText,
                    velocity: 20.0,
                    blankSpace: 300.0,
                    startPadding: 20.0,
                    scrollAxis: Axis.horizontal,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
