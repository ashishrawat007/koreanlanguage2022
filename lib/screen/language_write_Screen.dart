import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:koreanlanguage2022/services/admob_service.dart';

import 'japaneseAlpha.dart';

class LangWriteScreen extends StatelessWidget {
  const LangWriteScreen({Key? key}) : super(key: key);

//"higa"  "kata"  "Kanji"
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Widget label(var head, var col) {
      return AutoSizeText(
        head,
        style: TextStyle(color: col, fontSize: 40, fontWeight: FontWeight.bold),
        minFontSize: 25,
        stepGranularity: 1,
      );
    }

    Widget Clickable(String subject, String arg, var qtime, Color clr) {
      return Container(
        height: height * 0.080,
        width: width * 0.8500,
        child: InkWell(
          onTap: () {
            Get.to(() => JapanseseAlpha(arg, subject, clr));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: clr),
            child: Center(
              child: Text(
                subject,
                style: TextStyle(
                    fontFamily: " assets/fonts/Inter-SemiBold.ttf",
                    fontSize: (width + height) * 0.018,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF28334A),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Spacer(
                    flex: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      label('Learn ', Color(0xFFF65058)),
                      label('Hangal', Color(0xFFFBDE44)),
                    ],
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  Center(
                    child: Text(
                      "Hangul Modules",
                      style: TextStyle(
                          fontSize: (width + height) * 0.024,
                          color: Colors.white,
                          fontFamily: "assets/fonts/Inter-Bold.ttf",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ), //FFA351FF FFBE7BFF #EED971FF
                  Clickable("Vowel", "higa", 20, Color(0xFF53A567)),

                  Spacer(),

                  Clickable("Consonant ", "Kanji", 10, Color(0xFFDB3A2E)),

                  Spacer(),

                  Clickable("Consonant + Vowel", "kata", 15, Color(0xFF56A8CB)),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: AdWidget(
                key: UniqueKey(),
                ad: AdmobService.createBannerAd()..load(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
