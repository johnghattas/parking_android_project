import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import '../GUI/map_home.dart';
import '../GUI/owner_home_page.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';

import '../GUI/login_page.dart';
import '../constant_colors.dart';
import '../providers/change_index_provider.dart';
import '../shared/screen_sized.dart';
import '../widgets/custom_button.dart';
import '../widgets/welcome_pageview.dart';
import 'regester_page_index.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          color: Colors.white,
          child: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 0.0,
          ),
        ),
      ),
      body: Container(
        height: SizeConfig.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: SizeConfig.height - 24,
                    color: Colors.white,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => ChangeIndex(),
                    child: Positioned.fill(
                      top: 40,
                      child: SingleChildScrollView(
                        primary: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleWelcome(),
                            VerticalSpacing(of: 60.0),
                            StackPageView(),
                            IgnorePointer(
                              child: Transform.translate(
                                offset: Offset(0, -80),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/car.svg',
                                        height:
                                            getProportionateScreenWidth(100),

                                        // fit: BoxFit.fitWidth,
                                      ),
                                      VerticalSpacing(of: 20.0),
                                      Consumer<ChangeIndex>(
                                        builder: (context, value, child) {
                                          return _pointsContainer(
                                              value.pageIndex);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // VerticalSpacing(of: 60.0),

                            Consumer<ChangeIndex>(
                              builder: (context, value, child) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Hero(
                                      tag: 'heroButtonLogin',
                                      child: CustomButtonIcon(
                                        title: 'Login with phone',
                                        onPressed: () => navigateAndStopTimer(
                                            value, () async {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => LoginPage()));
                                        }),
                                      ),
                                    ),
                                  ),
                                  VerticalSpacing(of: 40),
                                  InkWell(
                                    onTap: () {
                                      navigateAndStopTimer(value, () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RegisterIndex()));
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        "Or Create My Account",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w300,
                                          fontSize:
                                              getProportionateScreenWidth(14),
                                          color: kBlackLight50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            VerticalSpacing(of: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _pointsContainer(int page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: EdgeInsets.only(right: 8),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: page == index ? kPrimaryColor : kBollColorBD),
        ),
      ),
    );
  }

  Widget _titleWelcome() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Hello, nice to meet you!\n",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenWidth(14),
                  color: Color(0xff303030),
                ),
              ),
              TextSpan(
                text: "Get a new experience",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(24),
                    color: Color(0xff303030),
                    height: 1.4),
              ),
            ]),
          ),
          Spacer(),
          InkWell(
            onTap: () async {
              Client? user = Hive.box('user_data').get('data');
              if (user?.isOwner ?? false) {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text('Go to Map'),
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.pushNamed(context, MapHome.NAME);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                        child: Text('Go to Owner'),
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.pushNamed(
                              context, OwnerHomePage.NAME);
                        },
                      )
                    ],
                    title: Text('where you wold to be'),
                  ),
                );
              } else
                Navigator.pushNamed(context, MapHome.NAME);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateAndStopTimer(ChangeNotifier value, [Function? function]) async {
    if (value is ChangeIndex) {
      (value).changeStopped(true);
      await function!();
      (value).changeStopped(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }
}
