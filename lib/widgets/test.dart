import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_project/bloc/garage_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ListAnimation(
        child: Container(height: 200, width: 200, color: Colors.red),
        minimize: false,
      ),
    );
  }
}

class ListAnimation extends StatefulWidget {
  final bool minimize;
  final Widget? child;
  final double height;
  final double minHeight;

  const ListAnimation(
      {Key? key,
      this.minimize = false,
      this.child,
      this.height = 200,
      this.minHeight = 100})
      : super(key: key);

  @override
  _ListAnimationState createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation> {
  @override
  void initState() {
    super.initState();
    print('this');
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const double SAVE_POSITION = 100;
  Function? onClick;
  double bottomPosition = 0,
      first = 0,
      firstPosition = 0,
      secondPosition = SAVE_POSITION;
  bool isFirstPosition = true;
  bool isTaped = false;

  _changeTopBottom(
      double first, double second, double? sFirst, double toBottom) {
    double def;

    if (first > second && sFirst! > first) {
      def = first - second;
      if (bottomPosition + def > 0) {
        return;
      }
      // setState(() => bottomPosition += def);
      context.read<GarageBloc>().add(ChangeBPEvent(bottomPosition += def));

    }
    if (first <= second && sFirst! < first) {
      def = second - first;
      if (bottomPosition - def < toBottom) {
        print('this button < 100');
        // setState(() => bottomPosition = toBottom);
        context.read<GarageBloc>().add(ChangeBPEvent(bottomPosition = toBottom));

        return;
      }
      // setState(() => bottomPosition -= def);
      context.read<GarageBloc>().add(ChangeBPEvent(bottomPosition -= def));

    }
  }

  @override
  Widget build(BuildContext context) {
    var height = widget.height;
    var _toBottom = widget.minHeight - widget.height;

    if (widget.minimize && !isTaped) {
      bottomPosition = _toBottom;
    }
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(milliseconds: 150),
          bottom: context.watch<GarageBloc>().bottomPosition,
          height: widget.height,
          child: GestureDetector(
            onPanUpdate: (details) {
              isTaped = true;
              // _startDragStart = details.localPosition.dy;
              if (isFirstPosition) {
                firstPosition = details.globalPosition.dy;
                first = firstPosition;
                isFirstPosition = false;
              } else {
                secondPosition = details.globalPosition.dy;
              }
              _changeTopBottom(
                  firstPosition, secondPosition, first, _toBottom);
              firstPosition = secondPosition;
            },
            onPanEnd: (details) {
              isTaped = false;
              print(details.velocity.pixelsPerSecond.distance);
              double velocity = details.velocity.pixelsPerSecond.dy;
              print(
                  'the velocity is $first,    $secondPosition  $firstPosition  $velocity');
              if (velocity < -100 &&
                  first> firstPosition &&
                  firstPosition < height - bottomPosition) {
                if (velocity < 0) setState(() => bottomPosition = height);
                // setState(() => bottomPosition = height);
                // sleep(Duration(milliseconds: 150));
              } else if (secondPosition > first &&
                  (velocity >= 100 || velocity == 0)) {
                // setState(() => );

                context.read<GarageBloc>().add(ChangeBPEvent(_toBottom));

                bottomPosition = _toBottom;
              } else {

                // setState(() {
                //
                // });
                context.read<GarageBloc>().add(ChangeBPEvent(0));
                bottomPosition = 0;
                isFirstPosition = true;
              }
            },
            child: widget.child,
          ),
        )
      ],
    );
  }
}
