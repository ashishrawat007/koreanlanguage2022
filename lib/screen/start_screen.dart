// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:koreanlanguage2022/services/admob_service.dart';
import 'Basic.dart';
import 'language_write_Screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Widget label(var head, double fsize, var col) {
    return Text(
      head,
      style:
          TextStyle(color: col, fontSize: fsize, fontWeight: FontWeight.bold),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdmobService.createInterstitialAd();
  }

  Future<bool> _popButton() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text('Do you want to exit Quiz'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: HexColor("##353a65"),
                      child: Text(
                        "YES",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: HexColor("##353a65"),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "NO",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    Widget GridButton(String name, String addr, String HeroName, Color clr) {
      return Container(
          height: h * 0.1,
          width: w * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: clr,
          ),
          child: Center(
              child: AutoSizeText(
            name,
            maxLines: 1,
            style: TextStyle(
                fontFamily: "Montserrat Regular",
                fontSize: 28,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            minFontSize: 20,
            stepGranularity: 1,
          )));
    }

    return Scaffold(
      backgroundColor: Color(0xFF28334A),
      body: WillPopScope(
        onWillPop: _popButton,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFF28334A),
                          const Color(0xFF28334A),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.05,
                          ),
                          label('Learn ', (h + w) * 0.027, Color(0xFFF65058)),
                          label('Korean', (h + w) * 0.027, Color(0xFFFBDE44)),
                        ],
                      ),
                      Container(
                        height: h * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: AssetImage('assets/lotte/working.png')),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text('Modules',
                          style: TextStyle(
                              fontFamily: "Montserrat Regular",
                              fontSize: (h + w) * 0.027,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8ACAE6))),
                      Spacer(
                        flex: 2,
                      ),
                      InkWell(
                          onTap: () {
                            AdmobService.showInterstitialAd();
                            Get.to(() => Basic());
                            //Get.to(()=>Ads());
                            print('here');
                          },
                          child: GridButton(
                              'Basic',
                              "assets/hiragana/basic.webp",
                              "Basic",
                              Color(0xFFDD493B))),
                      Spacer(
                        flex: 1,
                      ),
                      InkWell(
                          onTap: () {
                            AdmobService.showInterstitialAd();
                            Get.to(() => LangWriteScreen());
                          },
                          child: GridButton(
                              'Vowels',
                              "assets/hiragana/KatakanaA.png",
                              "kata",
                              Color(0xFFA52944))),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        //  color: Colors.deepPurple,
        child: AdWidget(
          key: UniqueKey(),
          ad: AdmobService.createBannerAd()..load(),
        ),
      ),
    );
  }
}
