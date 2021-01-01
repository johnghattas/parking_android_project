
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../customs/custom_paint.dart';
import '../providers/change_index_provider.dart';
import '../shared/screen_sized.dart';
class StackPageView extends StatefulWidget {
  const StackPageView({
    Key key
  }) : super(key: key);

  @override
  _StackPageViewState createState() => _StackPageViewState();
}

class _StackPageViewState extends State<StackPageView> {
  PageController _pageController;

  double _position = -500;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _position = _pageController.offset;
        if (_position <= SizeConfig.width) {
          _position = getValue(_position, 0, SizeConfig.width, -500, -80);
        } else if (_position <= SizeConfig.width * 2 + 10) {
          _position = getValue(
              _position, SizeConfig.width, SizeConfig.width * 2, -80, -900);
        }else {
          _position = getValue(
              _position, SizeConfig.width, SizeConfig.width * 2, -80, -900);

        }
      });
    });


    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
        ChangeIndex changeIndex = Provider.of<ChangeIndex>(context, listen: false);
      if(!(changeIndex.isStopped?? false)) {
        //print('this running');
        _pageController.animateToPage(++changeIndex.pageIndex == 3? 0 : changeIndex.pageIndex, duration: Duration(milliseconds: 250), curve: Curves.easeIn);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: getProportionateScreenWidth(SizeConfig.height * 0.4),
            width: SizeConfig.width,
            child: CustomPaint(
              painter: CustomPaints(),
              // size: Size(getProportionateScreenWidth(500),getProportionateScreenHeight(200)),
            )),
        AnimatedPositioned(
          duration: Duration(milliseconds: 250),
          bottom: 0,
          right: getProportionateScreenWidth(_position),
          child: SvgPicture.asset(
            'assets/images/image111.svg',
            height: getProportionateScreenWidth(200),
            width: SizeConfig.width * 3,
            fit: BoxFit.fitWidth,
          ),
        ),
        Consumer<ChangeIndex>(
          builder: (context, value, child) {
            return Container(
              height: getProportionateScreenWidth(SizeConfig.height * 0.4),
              width: double.infinity,
              child: PageView(
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                pageSnapping: true,
                children: [
                  ...List.generate(
                    3,
                        (index) => Container(),
                  )
                ],
                onPageChanged: (v) {
                  value.changePage(v);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  double getValue(double value, double oldFirst, double oldSecond, double first,
      double second) {
    double oldRange = oldSecond - oldFirst;
    double newRange = second - first;
    return ((value - oldFirst) * newRange) / oldRange + first;
  }

  @override
  void dispose() {
    super.dispose();
    print('this deactived');

    _timer.cancel();

  }

  @override
  void deactivate() {
    print('this de');
    super.deactivate();

  }
}