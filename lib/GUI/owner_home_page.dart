import 'package:flutter/material.dart';

class OwnerHomePage extends StatefulWidget {
  static const NAME = 'owner_home';
  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owner Home'),
      ),
    );
  }
}
