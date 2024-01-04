import 'dart:convert';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mapexpress/widget/flash_info.dart';
import 'package:mapexpress/widget/appbarsecond.dart';
import 'package:mapexpress/widget/navigationBottom.dart';



// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/': (context) => ActualitesPage(),
//       '/detail': (context) => DetailActualitePage(),
//     },
//   ));
// }

class Actualite {
  final String title;
  final String content;
  final String imageSrc;
  final String date;
  final String pdfAssetPath;

  Actualite({
    required this.title,
    required this.content,
    required this.imageSrc,
    required this.date,
    required this.pdfAssetPath,
  });

  factory Actualite.fromJson(Map<String, dynamic> json) {
    final titreRaw = json['title']['rendered'] ?? '';
    final contenuRaw = json['content']['rendered'] ?? '';

    final titreNettoye = parseHtmlString(titreRaw);
    final contenuNettoye = parseHtmlString(contenuRaw);

    return Actualite(
      title: titreNettoye,
      content: contenuNettoye,
      imageSrc: json['featured_image_src_large'] ?? '',
      date: json['date'] ?? '',
      pdfAssetPath: json['content']['rendered'] ?? '',
    );
  }
}

class ActualitesPage extends StatefulWidget {
  @override
  _ActualitesPageState createState() => _ActualitesPageState();
}

class _ActualitesPageState extends State<ActualitesPage> {
  late Future<List<Actualite>> futurActualites;
  String lang='fr';

  @override
  void initState() {
    super.initState();
     initializeDateFormatting();
    futurActualites = fetchActualites();
  }

  Future<List<Actualite>> fetchActualites() async {
      // Remplacez par la valeur correcte de lang
      lang = Provider.of<LangProvider>(context, listen: false).language!;
      Uri apiUri;

      if (lang == 'fr') {
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/communiques-de-press?per_page=10');
      } else if (lang == 'ar') {
        apiUri = Uri.parse('https://www.mapexpress.ma/ar/wp-json/wp/v2/communiques-de-press?per_page=10');
      } else {
        // Gérez le cas par défaut si lang n'est ni 'fr' ni 'ar'
        apiUri = Uri.parse('https://www.mapexpress.ma/wp-json/wp/v2/communiques-de-press?per_page=10'); // Remplacez 'URL_PAR_DEFAUT' par l'URL souhaitée en cas de défaut
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
    return Scaffold(
      body: FutureBuilder<List<Actualite>>(
        future: futurActualites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erreur : ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Aucune donnée disponible"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final actualite = snapshot.data![index];
                return PostContainer(
                  title: actualite.title,
                  content: actualite.content,
                  date: actualite.date,
                  pdfAssetPath:actualite.pdfAssetPath,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PostContainer extends StatefulWidget {
  final String title;
  final String content;
  final String date;
  final String pdfAssetPath;

  PostContainer({
    required this.title,
    required this.content,
    required this.date,
    required this.pdfAssetPath,
  });

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  

  @override
  Widget build(BuildContext context) {
    String lang ='fr';
    // dynamic date= widget.date.split('Ã');
    // String datedate = date[0];
    // String datetime = date[1]; 
    // String dateg = datetime + ' ' + datedate;
    lang = Provider.of<LangProvider>(context).getCurrentLang();
    // String formattedDate = widget.date.replaceAll('T', ' ');
    // if (lang =='ar') {
    
    //    formattedDate = _formatDateArabic(formattedDate);
    // }
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            // title,
            parseHtmlString(widget.title),
            style: TextStyle(
              fontSize: 14.0,
              // fontWeight: FontWeight.bold,
              
            ),
            textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
          ),
          SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    lang == 'fr' ? formatDateFrench(widget.date ?? '', lang) : formatArabicDate(widget .date ?? '' ),
                    // parseHtmlString(formattedDate),
                    // parseHtmlString(widget.date.replaceAll('T', ' ')),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailActualitePage(widget.title, widget.content, widget.date,widget.pdfAssetPath),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1), // <-- Radius
                  ),
                ),
                  child: Text(
                  lang == 'fr' ? "Lire la suite" : 'اقرأ المزيد',
                  style: TextStyle(color: Colors.white),
                  ),
              ),
            ],
          ),
        ],
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



//     String _formatDateArabic(String inputDate) {
//   initializeDateFormatting('ar');
//   DateTime dateTime = DateTime.parse(inputDate);
//   String formattedDate = DateFormat.yMMMMd('ar').add_jms().format(dateTime);
//   return formattedDate;
// }
}

class DetailActualitePage extends StatefulWidget {
  final String title;
  final String content;
  final String date;
  final String pdfAssetPath;

  DetailActualitePage(this.title, this.content, this.date,this.pdfAssetPath);

  @override
  State<DetailActualitePage> createState() => _DetailActualitePageState();
}

class _DetailActualitePageState extends State<DetailActualitePage> {
  Future<void> _launchURL() async {
     String inputString = widget.pdfAssetPath;
     String cleanedLink='';

          RegExp regExp = RegExp(r'href="([^"]+)"');
            RegExpMatch? match = regExp.firstMatch(inputString);

            if (match != null) {
              String href = match.group(1)!; // Use ! to assert non-null
              // Remove everything after ".pdf"
               cleanedLink = href.split('.pdf')[0] + ".pdf";
              print("Cleaned Link: $cleanedLink");
            } else {
              print("No link found in the input string.");
            }
          if (await canLaunch(cleanedLink)) {
            await launch(cleanedLink);
          } else {
            throw 'Impossible d\'ouvrir l\'URL : $cleanedLink';
          }
        }

  @override
  Widget build(BuildContext context) {
 String lang ='fr';
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
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
                      width: 130,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/flash-fr.webp'), // Remplacez par le chemin de votre image
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
              SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child:Row(
                            mainAxisAlignment: lang == 'fr' ? MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                                Text(
                                  lang == 'fr' ? "Communiqués de presse" : 'بيانات صحفية',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFF1F72A5),
                                  ),
                                ),
                              ],
                            ),
                        
                      ),
                    ),
                  ),
                  Divider(),
                Text(
                  parseHtmlString(widget.title),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                ),

                SizedBox(height: 8.0),
                // Text(
                //   content,
                //   style: TextStyle(
                //     fontSize: 18.0,
                //   ),
                // ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: (){
                      _launchURL();
               
                  },
                  child: Text('Télécharger'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String parseHtmlString(String htmlString) {
  return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
}
