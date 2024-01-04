import 'dart:convert';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:mapexpress/widget/appbarsecond.dart';
import 'package:mapexpress/widget/navigationBottom.dart';

class Actualite {
  final int idArticle;
  final String title;
  final String date;
  final String content;
  final String featuredImage;
  final String links;
  final String dateain;
  

  Actualite({
    required this.idArticle,
    required this.title,
    required this.date,
    required this.content,
    required this.featuredImage,
    required this.links,
    required this.dateain,
    
  });

  factory Actualite.fromJson(Map<String, dynamic> json) {
    final idArticle= json['id'];
    final rawTitle = json['title'] as String? ?? '';
    final date= json['date'] as String? ?? '';
    final dateain= json['date'] as String? ?? '';
    final rawContent = json['content'] as String? ?? '';
    final featuredImageContent = json['featured_image']['large'] as String? ?? '';
    final links= json['link'] as String? ?? '';
 
   


    final cleantitle = parseHtmlString(rawTitle);
    final cleanContent = parseHtmlString(rawContent);

    return Actualite(
      idArticle: idArticle,
      title: cleantitle,
      date: date,
      dateain:dateain,
      content: cleanContent,
      featuredImage: featuredImageContent,
      links: links,
      
    );
  }
}

String parseHtmlString(String htmlString) {
  final htmlDocument = htmlParser.parse(htmlString);
  final text = htmlDocument.body!.text;
  return text;
}



class ActualiteDetailPage extends StatefulWidget {
  final Actualite actualite;
  final String idArticle;

  ActualiteDetailPage({required this.actualite,required this.idArticle,});

  @override
  State<ActualiteDetailPage> createState() => _ActualiteDetailPageState();
}

class _ActualiteDetailPageState extends State<ActualiteDetailPage> {
  @override
   Map<String, dynamic> postDetail = {};

@override
void initState() {
  super.initState();
  fetchPostDetails().then((data) {
    setState(() {
      postDetail = data!;
    });
  });
}

Future<Map<String, dynamic>?> fetchPostDetails() async {
  String lang = 'fr';
    lang = Provider.of<LangProvider>(context , listen: false).getCurrentLang();
  try {
    String url = "";
    if (lang == 'fr') {
      url = "https://www.mapexpress.ma/wp-json/wp/v2/actualite/${widget.actualite.idArticle}?_embed";
    } else if (lang == 'ar') {
      url = "https://www.mapexpress.ma/ar/wp-json/wp/v2/actualite/${widget.actualite.idArticle}?_embed";
    } else {
      url = "https://www.mapexpress.ma/wp-json/wp/v2/actualite/${widget.actualite.idArticle}?_embed";
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dataList = json.decode(response.body);
      return dataList;
    } else {
      throw Exception("Failed to load data from the API");
    }
  } catch (e) {
    debugPrint(e.toString());
    return null; // Return null in case of an error
  }
}
  Widget build(BuildContext context) {
        String lang = 'fr';
    lang = Provider.of<LangProvider>(context).getCurrentLang();
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
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.actualite.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
              ),
              SizedBox(height: 10.0),
              Image.network(
                widget.actualite.featuredImage, // Affichez l'image de l'actualité
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10.0),
             Center(
              child: Text(
                // lang == 'fr' ? formatDateFrench(widget.actualite.dateain ?? '', lang) : formatArabicDate(widget.actualite .dateain ?? '' ),
                lang == 'fr' ? formatDateFrench(postDetail['date'] ?? '', lang) : formatArabicDate(postDetail['date'] ?? '' ),
                // postDetail['formatted_date']?.replaceAll('Ã', ' ') ?? '',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
            ),

              SizedBox(height: 10.0),
              Text(
                widget.actualite.content,
                style: TextStyle(fontSize: 14),
                // textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,

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
                            ),  // Texte du bouton
                      ],
                    ),
                  ),),
            ],
          ),
        ),
      ),
    );
  }
  String formatDateFrench(String dateString, String lang) {
  try {
    if (dateString != null && dateString.isNotEmpty) {
      DateTime date = DateTime.parse(dateString);

      String formatString = 'EEEE, d MMMM, y à HH:mm'; // Default format for other languages

     

      String formattedDate = DateFormat(formatString, lang).format(date);

      return formattedDate;
    } else {
      print('La chaîne de date est nulle ou vide.');
      return '';
    }
  } catch (e) {
    print('Erreur de format de date : $e');
    return dateString;
  }
}
  String formatArabicDate(String dateString) {
    // Parse the input string to a DateTime object

    try {
      if (dateString != null && dateString.isNotEmpty) {
         DateTime dateTime = DateTime.parse(dateString);

        // Create a specific date format for the desired output
        String formattedDate = DateFormat('EEEE, d MMMM, y - HH:mm', 'ar').format(dateTime);

      // Manually replace Arabic numerals with Western numerals
        formattedDate = formattedDate.replaceAll('١', '1')
            .replaceAll('٢', '2')
            .replaceAll('٣', '3')
            .replaceAll('٤', '4')
            .replaceAll('٥', '5')
            .replaceAll('٦', '6')
            .replaceAll('٧', '7')
            .replaceAll('٨', '8')
            .replaceAll('٩', '9')
            .replaceAll('٠', '0');

    return formattedDate;
      }else{
             print('La chaîne de date est nulle ou vide.');
      return '';
      }
    } catch (e) {
          print('Erreur de format de date : $e');
          return '';
              }
  
  }

String _replaceNumberWithFrench(String digit) {
  Map<String, String> arabicToFrench = {
    '0': '0',
    '1': '١',
    '٢': '2',
    '3': '3',
    '4': '٤',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
  };

  return arabicToFrench[digit] ?? digit;
}

  void shareContent() {
          
        Share.share(postDetail['link']);
      }
}

class CustomContainerLast extends StatefulWidget {
  @override
  _CustomContainerLastState createState() => _CustomContainerLastState();
}

class _CustomContainerLastState extends State<CustomContainerLast> {
  late Future<List<Actualite>> _actualites;
  final ScrollController _scrollController = ScrollController();
  String lang='fr';

  @override
  void initState() {
    super.initState();
    _actualites = fetchActualites();
  }

 Future<List<Actualite>> fetchActualites() async {
      // Remplacez par la valeur correcte de lang
      lang = Provider.of<LangProvider>(context, listen: false).language!;
      Uri apiUri;

      if (lang == 'fr') {
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wl/v1/last');
      } else if (lang == 'ar') {
        apiUri = Uri.parse('https://www.mapexpress.ma/ar/wp-json/wl/v1/last');
      } else {
        // Gérez le cas par défaut si lang n'est ni 'fr' ni 'ar'
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wl/v1/last'); // Remplacez 'URL_PAR_DEFAUT' par l'URL souhaitée en cas de défaut
      }

      final response = await http.get(apiUri);

      if (response.statusCode == 200) {
        final List<dynamic> actualitesData = json.decode(response.body);
        final actualitesList = actualitesData.map((item) => Actualite.fromJson(item)).toList();
        return actualitesList;
      } else {
        throw Exception('Failed to load actualites');
      }
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
      child: Column(
        //  mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: lang == 'fr' ? CrossAxisAlignment.start: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 120,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child:Row(
                    mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: [
                        Text(
                          lang == 'fr' ? "Dernière Heure" : 'الساعة الأخيرة',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF1F72A5),
                          ),
                        ),
                      ],
                    ),
                //  Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     lang == 'fr' ? "Fake News" : 'أخبار وهمية',
                    
                //     style: TextStyle(
                //       fontSize: 20,
                //       color: Color(0xFF1F72A5),
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
          Divider(),
          // Center(
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12), // <-- Radius
          //       ),
          //     ),
          //     onPressed: () {
          //       // Faites défiler vers le haut d'un élément à la fois
          //       _scrollController.animateTo(
          //         _scrollController.offset - 80.0, // Défilez d'un élément vers le haut
          //         duration: Duration(seconds: 1),
          //         curve: Curves.easeInOut,
          //       );
          //     },
          //     child: Image.asset("assets/images/up.webp"),
          //   ),
          // ),
    
          Expanded(
            child: FutureBuilder<List<Actualite>>(
              future: _actualites,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erreur : ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Aucune actualité disponible');
                } else {
                  final actualites = snapshot.data!;
    
                  return ListView.builder(
                    controller: _scrollController, // Utilisez le contrôleur de défilement
                    itemCount: actualites.length,
                    itemBuilder: (context, index) {
                      final actualite = actualites[index];
                      return ListTile(
                        leading: Image.network(
                          actualite.featuredImage,
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          actualite.title,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                          textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ActualiteDetailPage(actualite: actualite, idArticle: '',),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          
          
        ],
      ),
    );
  }
}
