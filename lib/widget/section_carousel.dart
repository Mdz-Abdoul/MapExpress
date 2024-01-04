import 'package:flutter/material.dart';
import 'package:mapexpress/widget/carrousel.dart';

class SectionCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: FutureBuilder<List<Royales>>(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Erreur: ${snapshot.error}"));
            } else {
              final royalesList = snapshot.data!;
              return ImageCarousel(royalesList: royalesList);
            }
          },
        ),
      
    );
  }
}
