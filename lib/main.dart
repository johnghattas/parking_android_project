import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_project/GUI/map_home.dart';
import 'package:parking_project/GUI/owner_home_page.dart';
import 'package:parking_project/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:parking_project/constant_colors.dart';
import 'package:parking_project/providers/change_verification_state.dart';
import 'package:parking_project/providers/loading_and_response_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'GUI/welcome_page.dart';
import 'package:http/http.dart' as http;
import 'block/garage_bloc.dart';
import 'const_data.dart';
import 'repositers/parking_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // http.get(Uri.http('localhost:8000', '/'));
  http.get(Uri.parse(cUrl.substring(0, cUrl.length - 4)));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));

  await Firebase.initializeApp();

  await Hive.initFlutter();
  Hive.registerAdapter(ClientAdapter());
  await Hive.openBox('user_data');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChangeVerificationState>(
          create: (context) => ChangeVerificationState(),
        ),
        ChangeNotifierProvider<LoadingAndErrorProvider>(
          create: (context) => LoadingAndErrorProvider(),
        ),

        BlocProvider<GarageBloc>(create: (context) => GarageBloc(ParkingRepo()),)

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          MapHome.NAME : (context) => MapHome(),
          OwnerHomePage.NAME : (context) => OwnerHomePage(),
        },
        home: ValueListenableBuilder(
            valueListenable: Hive.box('user_data').listenable(),
            builder: (context, box, widget) {
              return ((box! as Box).get('token') == null? WelcomePage() : WelcomePage());
            }),
      ),
    );
  }
}
