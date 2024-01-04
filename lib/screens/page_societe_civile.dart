import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:mapexpress/widget/appbar.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:mapexpress/widget/flash_info.dart';
import 'package:mapexpress/widget/menudrawer.dart';
import 'package:mapexpress/widget/appbarsecond.dart';
import 'package:mapexpress/widget/navigationBottom.dart';


class Actualite {
  final String title;
  final String content;
  final String featuredImageSrc;
  final String formatted_date;
  final String links;
  final String dateain;

  Actualite({
    required this.title,
    required this.content,
    required this.featuredImageSrc,
    required this.formatted_date,
    required this.links,
    required this.dateain,
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
      formatted_date: json['formatted_date'] ?? '',
      dateain: json['date'] ?? '',
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
     List<String> date= actualite.formatted_date.split('Ã');
    String datedate = date[0];
    String datetime = date[1]; 
    String dateg ="$datetime  $datedate";
    String datefr = actualite.formatted_date.replaceAll('Ã', 'à');
    String d='';


    String lang ='fr';
    lang = Provider.of<LangProvider>(context).getCurrentLang();
    if(lang == 'fr'){
      d=datefr;
    }else{
      d=dateg;
    }
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
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://www.mapexpress.ma/wp-content/themes/map-v2/images/v2/flash-fr.png"), // Remplacez par le chemin de votre image
                              // image: AssetImage('assets/images/flash-fr.webp'), // Remplacez par le chemin de votre image
                              fit: BoxFit.cover, // Ajustez selon vos besoins
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(.0),
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
              SizedBox(height: 10.0),
              Image.network(
                actualite.featuredImageSrc, // Affichez l'image de l'actualité
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10.0),
              Text(
                actualite.title,
                textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  lang == 'fr' ? formatDateFrench(actualite.dateain ?? '', lang) : formatArabicDate(actualite .dateain ?? '' ),
                  // d,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                actualite.content,
                style: TextStyle(fontSize: 14),
                //  textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
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
          
        Share.share(actualite.links);
      }
}

class CustomContainerSocieteCivileList extends StatefulWidget {
  @override
  _CustomContainerSocieteCivileListState createState() =>
      _CustomContainerSocieteCivileListState();
}

class _CustomContainerSocieteCivileListState
    extends State<CustomContainerSocieteCivileList> {
  List<Future<List<Actualite>>> _Gactualites =[];    
  late Future<List<Actualite>> _actualites;
  int _nombreActuCharges = 10; 
  String lang='fr';

  @override
  void initState() {
    super.initState();
    _actualites = fetchActualites(_nombreActuCharges);
    _Gactualites.add(_actualites);
  }

   Future<List<Actualite>> _combineFutures(List<Future<List<Actualite>>> futures) {
    return Future.wait(futures).then((listOfLists) {
      List<Actualite> combinedList = [];
      for (var list in listOfLists) {
        combinedList.addAll(list);
      }
      return combinedList;
    });
  }
Future<List<Actualite>> fetchActualites(int _nombreActuCharges) async {
      // Remplacez par la valeur correcte de lang
      lang = Provider.of<LangProvider>(context, listen: false).language!;
      Uri apiUri;

      if (lang == 'fr') {
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/actualite?actualites=25&per_page=$_nombreActuCharges');
      } else if (lang == 'ar') {
        apiUri = Uri.parse('https://www.mapexpress.ma/ar/wp-json/wp/v2/actualite?actualites=8&per_page=$_nombreActuCharges');
      } else {
        // Gérez le cas par défaut si lang n'est ni 'fr' ni 'ar'
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/actualite?actualites=25&per_page=$_nombreActuCharges'); // Remplacez 'URL_PAR_DEFAUT' par l'URL souhaitée en cas de défaut
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

      String d='';
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
              indexG: 0,
            )),
      ),
      body: Column(
        children: [
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Row(
                  children: [
                    // const SizedBox(
                    //     width: 8.0), // Espacement entre l'icône et le texte
                    SizedBox(
                      width: 130,
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
                                  'FLASH INFO',
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
            child: FutureBuilder<List<Actualite>>(
              future: _combineFutures(_Gactualites),
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
                    itemCount: actualites.length,
                    itemBuilder: (context, index) {
                      final actualite = actualites[index];

                      return InkWell(
                        onTap: () {
                           Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ActualiteDetailPage(
                                          actualite: actualite),
                                    ),
                                  );
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          // margin: EdgeInsets.all(16.0),
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.grey,
                          //     width: 1.0,
                          //   ),
                          //   borderRadius: BorderRadius.circular(0.0),
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // const Text(
                              //   'Activités Parlementaires',
                              //   style: TextStyle(
                              //     fontSize: 20,
                              //     color: Color.fromARGB(226, 44, 161, 219),
                              //   ),
                              // ),
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
                                ),
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child: Text(
                                   lang == 'fr' ? formatDateFrench(actualite.dateain ?? '', lang) : formatArabicDate(actualite .dateain ?? '' ),
                                  style: TextStyle(
                                    fontSize: 14,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                  actualite.content,
                                  textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 3,
                                ),
                                SizedBox(height: 10.0),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ActualiteDetailPage(
                                            actualite: actualite),
                                      ),
                                    );
                                  },
                                    child: Text(
                                    lang == 'fr' ? "Lire la suite" : 'اقرأ المزيد',
                                    style: TextStyle(color: Colors.white),
                                    ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1F72A5),
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
                    },
                  );
                }
              },
            ),
          ),
         ElevatedButton(
            onPressed: () {
              setState(() {
                _nombreActuCharges += 10; // Chargez 10 actualités de plus
                _actualites = fetchActualites(_nombreActuCharges);
                _Gactualites.add(_actualites); // Appelez à nouveau la requête pour charger plus d'actualités
              });
            },
            child: Text(
               lang == 'fr' ? 'Afficher toutes les informations' : 'إظهار كافة المعلومات',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1F72A5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
