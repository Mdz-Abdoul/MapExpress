import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/widget/appbar.dart';
import 'package:mapexpress/widget/appbarsecond.dart';
import 'package:mapexpress/screens/page_droit_homme.dart';

class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isLoading = false;

  Future<void> search(String lang) async {
    setState(() {
      isLoading = true;
    });

    final searchTerm = _searchController.text;

    if (searchTerm.isEmpty) {
      return null;
    }

    String url = "";

    if (lang == 'fr') {
      url = "https://www.mapexpress.ma/wp-json/wp/v2/actualite?_embed&search=$searchTerm&search_columns=title";
    } else if (lang == 'ar') {
      url = "https://www.mapexpress.ma/ar/wp-json/wp/v2/actualite?_embed&search=$searchTerm&search_columns=title";
    }
    else{
      url = "https://www.mapexpress.ma/wp-json/wp/v2/actualite?_embed&search=$searchTerm&search_columns=title";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dataList = json.decode(response.body);
      setState(() {
        searchResults = List<Map<String, dynamic>>.from(dataList);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception("Failed to load data from the API");
    }
  }

  @override
  Widget build(BuildContext context) {
     String lang = 'fr';
    lang = Provider.of<LangProvider>(context).getCurrentLang();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbarsecond(),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
              labelText: lang == 'fr' ? 'Terme à rechercher' : 'مصطلح للبحث عنه',
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: Icon(Icons.clear),
              ),), 
            ),
          ),
          ElevatedButton(
            onPressed: (){
              search(lang);
            },
            child: Text(lang == 'fr' ? 'Recherche' : 'بحث'),
          ),
          if (isLoading)
            CircularProgressIndicator()
          else
          // ...


  Expanded(
  child: ListView.builder(
    itemCount: searchResults.length,
    itemBuilder: (context, index) {
      final result = searchResults[index];
      final title = parseHtmlString(result['title']['rendered']);

      return Card(
        child: ListTile(
          title: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          leading: Image.network(result['featured_image_src_large']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(result),
              ),
            );
          },
        ),
      );
    },
  ),
),

// ...

        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> article;

  DetailPage(this.article);

  @override
  Widget build(BuildContext context) {
    String lang ='fr';
    lang = Provider.of<LangProvider>(context).getCurrentLang();
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbarsecond(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.network(article['featured_image_src_large']),
              SizedBox(height: 15,),
              // Customize how you want to display the details of the article here
              Text(parseHtmlString(article['title']['rendered']),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              Text(parseHtmlString(article['content']['rendered'])),
              // Add more widgets to display additional information as needed
            ],
          ),
        ),
      ),
    );
  }
}
