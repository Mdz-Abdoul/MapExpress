import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FlashData {
  final String title;
  final String imageUrl;

  FlashData({
    required this.title,
    required this.imageUrl,
  });

  factory FlashData.fromJson(Map<String, dynamic> json) {
    return FlashData(
      title: json['title'] ?? "",
      imageUrl: json['featured_image']['medium'] ?? "",
    );
  }
}

class Dropmani extends StatefulWidget {
  @override
  State<Dropmani> createState() => _DropmaniState();
}

class _DropmaniState extends State<Dropmani> {
  late Future<List<FlashData>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchDataFromApi();
  }

  Future<List<FlashData>> fetchDataFromApi() async {
    final apiUrl = 'https://www.mapexpress.ma/wp-json/wl/v1/flash';

    try {
      final response = await http.get(Uri.parse(apiUrl));

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Marquee avec des List<Royales>'),
        ),
        body: FutureBuilder<List<FlashData>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else {
              final flashDataList = snapshot.data;
              return ListView.builder(
                itemCount: flashDataList?.length,
                itemBuilder: (context, index) {
                  return MarqueeItem(royale: flashDataList![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class MarqueeItem extends StatelessWidget {
  final FlashData royale;

  MarqueeItem({required this.royale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Image.network(
            royale.imageUrl,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 16),
          Text(royale.title),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(Dropmani());
// }
