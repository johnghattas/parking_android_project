import 'package:flutter/material.dart';

class Alerts {

  Future<void> errorDialog(BuildContext context,{String title="Error", String? content}) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(content??"Error"),
        title: Text(title),
      ),
    );
  }

  Future<void> loadingDialog(BuildContext context) async{
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(height: 50,child: Row(
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(width: 15,),
            Text("Loading")
          ],
        )),
        title: Text("Loading"),
      ),
    );
  }
}