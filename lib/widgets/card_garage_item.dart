import 'package:flutter/material.dart';
import 'package:parking_project/models/garage.dart';
import 'package:parking_project/shared/screen_sized.dart';

class CardGarageItem extends StatelessWidget {
  const CardGarageItem({
    Key? key,
    required this.garage,
    this.onTap,
  }) : super(key: key);

  final Garage garage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Container(
            width: SizeConfig.width! * 0.85,
            child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: SizeConfig.width! * 0.52,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                garage.name ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                garage.city ??
                                    '' + ', ' + (garage.street ?? ''),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                    fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 🚨 Share Button 🚨
                      Align(
                        alignment: Alignment(0.0, -0.7),
                        child: FlatButton(
                          onPressed: null,
                          child: Icon(
                            Icons.share_outlined,
                            color: Colors.green,
                          ),
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.grey)),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Row(
                      children: [
                        // 🚨 Directions Button 🚨
                        FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                          label: Text('Direction'),
                          textColor: Colors.white,
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // 🚨 Call Button 🚨
                        FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                          label: Text('call'),
                          textColor: Colors.black,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(18.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 🚨 When User Click On Card 🚨
        onTap: onTap);
  }
}