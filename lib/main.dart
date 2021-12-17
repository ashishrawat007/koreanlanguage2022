// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:koreanlanguage2022/services/admob_service.dart';

import 'screen/start_screen.dart';


void main() {
 WidgetsFlutterBinding.ensureInitialized();
 AdmobService.initialize();
  SystemChrome.setPreferredOrientations(
      [  DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
  );
  runApp(LangApp());
}

class LangApp extends StatelessWidget {
  const LangApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home: StartScreen()
    );

  }
}

