import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';




class ButtonExpendable extends StatelessWidget {
  const ButtonExpendable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  floatingActionButton: SpeedDial( //Speed dial menu
    //margin bottom
    icon: Icons.menu, //icon on Floating action button
    activeIcon: Icons.close, //icon when menu is expanded on button
    backgroundColor: Colors.deepOrangeAccent, //background color of button
    foregroundColor: Colors.white, //font color, icon color in button
    activeBackgroundColor: Colors.deepPurpleAccent, //background color when menu is expanded
    activeForegroundColor: Colors.white,
     //button size
    visible: true,
    closeManually: false,
    curve: Curves.bounceIn,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
    onOpen: () => print('OPENING DIAL'), // action when menu opens
    onClose: () => print('DIAL CLOSED'), //action when menu closes

    elevation: 8.0, //shadow elevation of button
    shape: CircleBorder(), //shape of button
    
    children: [
      SpeedDialChild( //speed dial child
        child: Icon(Icons.accessibility),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        label: 'First Menu Child',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => print('FIRST CHILD'),
        onLongPress: () => print('FIRST CHILD LONG PRESS'),
      ),
      SpeedDialChild(
        child: Icon(Icons.brush),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        label: 'Second Menu Child',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => print('SECOND CHILD'),
        onLongPress: () => print('SECOND CHILD LONG PRESS'),
      ),
      SpeedDialChild(
        child: Icon(Icons.keyboard_voice),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        label: 'Third Menu Child',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => print('THIRD CHILD'),
        onLongPress: () => print('THIRD CHILD LONG PRESS'),
      ),

      //add more menu item childs here
    ],
  ),
);
  }
}


