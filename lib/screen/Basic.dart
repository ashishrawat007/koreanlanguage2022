// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' ;
import 'package:hexcolor/hexcolor.dart';
import 'package:koreanlanguage2022/services/admob_service.dart';
import 'DataScreen.dart';


class Basic extends StatelessWidget {
  const Basic({Key key}) : super(key: key);

  Widget label(var head, double fsize, var col)
  {
    return  Text(
      head,
      style: TextStyle(
          color: col,
          fontSize: fsize,
          fontWeight: FontWeight.bold
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height ;
    var w = MediaQuery.of(context).size.width ;

    Widget GridButtons(String name, String LottAddr)
    {
      return InkWell(
        onTap: () {
          AdmobService.showInterstitialAd();
          print(name);
          Get.to(()=>DataScreen(name));

        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          elevation: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(LottAddr, height: h *0.09, width: w*0.2,),
              SizedBox(
                height: h*0.02,
              ),
              Container(
                child: Text(name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: (h+w)*0.012
                  ),),
              )
            ],
          ),
        ),
      );
    }
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.pink);

    return Scaffold(
      backgroundColor:Color(0xFF28334A),
      body: SafeArea(
        child: Column(
          children: [
           SizedBox(
             height: 30,
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: w*0.05,
                ),
                label('Basic ',(h+w) *0.027 ,Color(0xFFF65058)),
                label('Korean',(h+w) *0.027 ,Color(0xFFFBDE44)),
              ],
            ),
            Expanded(
              child: Container(

                color: Color(0xFF28334A),
                child: GridView.count(
                    padding: EdgeInsets.all(20),
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: ( 16/ 20),

                    children: [


                      GridButtons("Greetings","assets/lotte/greeting.png"),
                      GridButtons("General","assets/lotte/general.jpeg"),
                      GridButtons("Shopping","assets/lotte/shopping.png"),
                      GridButtons("Tourist Spot","assets/lotte/passport.jpg"),
                      GridButtons("Directions","assets/lotte/direction.jpeg"),
                      GridButtons("Date Time","assets/lotte/Calendar.png"),
                      GridButtons("Cities","assets/lotte/city.png"),
                      GridButtons("Dating","assets/lotte/dating.jpeg"),
                      GridButtons("Counting","assets/lotte/counting.png"),
                      GridButtons("Food","assets/lotte/food.jpeg"),
                      GridButtons("Mountain","assets/lotte/mountain.jpeg"),
                      GridButtons("Transport","assets/lotte/transport.png"),
                    ]
                ),
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
