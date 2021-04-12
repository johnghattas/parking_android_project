import 'package:flutter/material.dart';
import '../block/keyboard_change.dart';
import '../shared/screen_sized.dart';

class TextWithKeyboardAnimation extends StatelessWidget {


  const TextWithKeyboardAnimation({
    Key? key,
    required this.position,
  }) : super(key: key);

  final double position;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: getProportionateScreenHeight(280),
      child: Expanded(
        child: Stack(
          children: [
            StreamBuilder<double>(
                stream: keyboardBlock.chuckListStream,
                builder: (context, snapshot) {
                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 0),
                    // top: 50,
                    bottom: SizeConfig.orientation == Orientation.portrait &&
                        (snapshot.data ?? 0) > 0
                        ? ((snapshot.data)?? 0) + 10 - position
                        : 10,

                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: getProportionateScreenWidth(12),
                          color: const Color(0xff303030),
                        ),
                        children: [
                          TextSpan(
                            text: 'Resend Code in ',
                          ),
                          TextSpan(
                            text: '10 seconds',
                            style: TextStyle(
                              color: const Color(0xff58be3f),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
