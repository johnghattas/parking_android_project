import 'package:flutter/material.dart';

import '../constant_colors.dart';
import 'add_data.dart';
import 'cards page.dart';

class OwnerHomePage extends StatefulWidget {
  static const NAME = 'owner_home';
  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Owner',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FilledData(),
      ),
    );
  }
}
