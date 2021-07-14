import 'package:flutter/material.dart';
import 'package:parking_project/Gui/add_data.dart';
import 'package:parking_project/widgets/custom_drawer.dart';

import 'cards_page.dart';

class Owner extends StatefulWidget {
  @override
  _OwnerState createState() => _OwnerState();
}

TextEditingController name = TextEditingController();

class _OwnerState extends State<Owner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal.shade800,
          title: Text(
            'owner',
            textAlign: TextAlign.center,
          ),

          elevation: 0.0,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Add()));
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 20.0,
                ),
                child: FilledData()),
          ),
        ),
        drawer: CustomDrawer());
  }
}


