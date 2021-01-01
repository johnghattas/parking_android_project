import 'package:flutter/material.dart';
import '../shared/screen_sized.dart';
import '../customs/custom_shape.dart';

class TextAndCustomPaint extends StatelessWidget {
  final String title;

  const TextAndCustomPaint({
    Key key, this.title = 'WELCOME',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
      painter: CustomShape(),
      child: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenWidth(30.0)),
        child: SizedBox(
          height: getProportionateScreenWidth(30),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);

                },
                alignment: Alignment.center,
                splashRadius: 10,
              ),
              SizedBox(
                height: 48,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: getProportionateScreenWidth(14) > 30? 30 : getProportionateScreenWidth(14),
                      color: const Color(0xffffffff),
                      letterSpacing: 1.0000000305175782,
                      fontWeight: FontWeight.w700,
                      // height: 48,
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
