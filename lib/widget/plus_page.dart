import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PlusPage extends StatefulWidget {
  @override
  State createState() => new PlusPageState();
}

class PlusPageState extends State<PlusPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Speed Dial Example')),
      // Utilisez SpeedDial pour les boutons flottants
      floatingActionButton: SpeedDial(
        animatedIcon:
            AnimatedIcons.menu_close, // Icône animée lorsque le FAB est ouvert
        children: [
          SpeedDialChild(
            child: Icon(Icons.sms),
            label: 'SMS',
            onTap: () {
              // Action pour le bouton SMS
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.mail),
            label: 'Mail',
            onTap: () {
              // Action pour le bouton Mail
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.phone),
            label: 'Phone',
            onTap: () {
              // Action pour le bouton Phone
            },
          ),
        ],
      ),
    );
  }
}
