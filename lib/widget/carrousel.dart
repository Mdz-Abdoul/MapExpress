import 'dart:convert';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mapexpress/config/lang.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:dots_indicator/dots_indicator.dart';
import 'package:mapexpress/widget/appbarsecond.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mapexpress/screens/page_droit_homme.dart';
import 'package:mapexpress/services/activites_royales.dart';





class Royales {
  final int id;
  final String title;
  final String content;
  final String featuredImageSrcLarge;
  final String links;

  Royales({
    required this.id,
    required this.title,
    required this.content,
    required this.featuredImageSrcLarge,
    required this.links,
  });

  factory Royales.fromJson(Map<String, dynamic> json) {
    return Royales(
      id: json['id'],
      title: json['title'].toString(),
      content: json['content'].toString(),
      featuredImageSrcLarge: json['featured_image'] ['large'].toString() ?? '',
      links: json['links'].toString() ?? '',
    );
  }

  String parseHtmlString(String htmlString) {
    final htmlDocument = htmlParser.parse(htmlString);
    final text = htmlDocument.body!.text;
    return text;
  }
}

Future<List<Royales>> fetchData(BuildContext context) async {
      // Remplacez par la valeur correcte de lang
  String lang = Provider.of<LangProvider>(context, listen: false).language!;

  try {
    String url ="";
    if(lang == 'fr'){
       url = "https://www.mapexpress.ma/wp-json/wl/v1/sld";
    }else if( lang =='ar'){
      url = "https://www.mapexpress.ma/ar/wp-json/wl/v1/sld";
    }else{
      url = "https://www.mapexpress.ma/wp-json/wl/v1/sld";
    }
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final List<dynamic> dataList = json.decode(res.body);
      List<Royales> royalesList = dataList.map((json) {
        return Royales.fromJson(json);
      }).toList();
      return royalesList;
    } else {
      throw Exception("Échec du chargement des données de l'API");
    }
  } catch (e) {
    debugPrint(e.toString());
    
    throw e;
  }
}

class ImageCarousel extends StatefulWidget {
  final List<Royales> royalesList;

  ImageCarousel({required this.royalesList});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
  }
  String lang='fr';
  class _ImageCarouselState extends State<ImageCarousel> {
 
      CarouselController _carouselController = CarouselController();

      @override
      Widget build(BuildContext context) {
        return Column(
          
          children: [
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: widget.royalesList.length,
              options: CarouselOptions(
                height: 350.0,
                aspectRatio: 2.4,
                viewportFraction: 1,
                initialPage: 0,
                pauseAutoPlayOnManualNavigate: true,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final royale = widget.royalesList[index];
                return buildCarouselItem(
                  context,
                  royale.featuredImageSrcLarge,
                  royale.title,
                  royale.content,
                  royale.links,
                  royale.id.toString() ,
                  // royale.formatted_date,
                );
              },
            ),
            // DotsIndicator(
            //   dotsCount: widget.royalesList.length,
            //   position: _currentPosition.round(),
            //   decorator: DotsDecorator(
            //     size: Size(8, 8),
            //     color: Colors.grey,
            //     activeColor: Color(0xFF1F72A5),
            //     activeSize: Size(8, 8),
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         _carouselController.previousPage(
            //           duration: Duration(milliseconds: 300),
            //           curve: Curves.ease,
            //         );
            //       },
            //       child: Icon(Icons.arrow_left),
            //     ),
            //     SizedBox(width: 16),
            //     ElevatedButton(
            //       onPressed: () {
            //         _carouselController.nextPage(
            //           duration: Duration(milliseconds: 300),
            //           curve: Curves.ease,
            //         );
            //       },
            //       child: Icon(Icons.arrow_right),
            //     ),
            //   ],
            // ),
          ],
        );
      }

    Widget buildCarouselItem(
    BuildContext context, String imagePath, String title, String content,String links , String idArticle ) {
     lang = Provider.of<LangProvider>(context).getCurrentLang();
    return InkWell(
      onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                imagePath: imagePath,
                title: title,
                content: content, 
                links: links,
                idArticle: idArticle, 
                // formatted_date: formatted_date,
              ),
            ),
          );
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.white,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  parseHtmlString(title),
                  textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          imagePath: imagePath,
                          title: title,
                          content: content, 
                          links: links,
                          idArticle: idArticle, 
                          // formatted_date: formatted_date,
                        ),
                      ),
                    );
                  },
                  child: Text(
                   lang == 'fr' ? "Lire la suite" : 'اقرأ المزيد',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(40, 20),
                    backgroundColor: Color(0xFF1F72A5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final String idArticle;
  final String imagePath;
  final String title;
  final String content;
  final String links;

  DetailPage({
    required this.imagePath,
    required this.title,
    required this.content,
    required this.links,
    required this.idArticle,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

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
  try {
    String url = "";
    if (lang == 'fr') {
      url = "https://www.mapexpress.ma/wp-json/wp/v2/actualite/${widget.idArticle}?_embed";
    } else if (lang == 'ar') {
      url = "https://www.mapexpress.ma/ar/wp-json/wp/v2/actualite/${widget.idArticle}?_embed";
    } else {
      url = "https://www.mapexpress.ma/wp-json/wp/v2/actualite/${widget.idArticle}?_embed";
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
 

  @override
  Widget build(BuildContext context) {
    // List<String> dateformat = postDetail['formatted_date']?.replaceAll('Ã', ' ').split(' ');
    // String datefm = convertToAMPMFormat(dateformat[1].toString());
    // String artDate = "${dateformat[0]}  $datefm";
    String con =  parseHtmlString(widget.content);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Sectionappbarsecond(),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(12.0),
      //   child: SizedBox(
      //       height: 60,
      //       child: MyBottomNavigationBar(
      //         indexG: 0,
      //       )),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            children: [
              SizedBox(
                height: 20, 
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                parseHtmlString(widget.title),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerRight,
                // child: Text(
                //   parseHtmlString(formatted_date),
                //   style: TextStyle(
                //     fontSize: 15.0,
                //     // fontWeight: FontWeight.w800,
                //   ),
                // ),
              ),
              Center(
              // child: Text(
              //   postDetail['formatted_date']?.replaceAll('Ã', ' ') ?? '',
              //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              // ),
              child: Text(
                lang == 'fr' ? formatDateFrench(postDetail['date'] ?? '', lang) : formatArabicDate(postDetail['date'] ?? '' ),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
            ),

              SizedBox(height: 8.0),
             Text(
                 con,
                  // textAlign: lang == 'ar' ? TextAlign.start : TextAlign.end,
                  textDirection: lang == 'ar' ? ui.TextDirection.rtl  : ui.TextDirection.ltr,
                  style: const TextStyle(
                    fontSize: 14.0,
                    // fontWeight: FontWeight.w800,
                  ),
                ) , // ou TextDirection.rtl selon le cas par défaut

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
                        const SizedBox(width: 8.0), // Espacement entre l'icône et le texte
                        Text(
                              lang == 'fr' ? 'Partagez cet article' : 'مشاركة',
                              style: TextStyle(color: Colors.grey),
                            ),  // Texte du bouton
                      ],
                    ),
                  ),),
              // Include more details as needed
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


