// @dart=2.9
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' ;
import 'package:hexcolor/hexcolor.dart';
import 'package:koreanlanguage2022/services/admob_service.dart';

class JapanseseAlpha extends StatefulWidget {
  final String name;
  final String subName;
  final Color headClr;

  JapanseseAlpha( this.name, this.subName, this.headClr);

  @override
  _JapanseseAlphaState createState() => _JapanseseAlphaState();
}

class _JapanseseAlphaState extends State<JapanseseAlpha> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  @override
  Widget build(BuildContext context)
  {

    var h = MediaQuery.of(context).size.height ;
    var w = MediaQuery.of(context).size.width ;
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 15,
        fontWeight: FontWeight.bold,

        color: Colors.white
    );
    Widget GridButton(String inJAP , String inENg, String numb)
    {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          child:   Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white

              ),

              child: Column(
                children: [
                  Text(numb,
                    style: TextStyle(
                        color: widget.headClr,
                        fontWeight: FontWeight.bold,
                      fontSize:  (h+w) * 0.018
                    ),),
                  SizedBox(
                      height: h* 0.02
                  ),
                  Text(inJAP,
                    style: TextStyle(
                        fontSize: (h+w) * 0.025
                    ),
                  ),
                ],
              )),
          footer: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.headClr,
              ),

              child: Center(child: Text( inENg , style: cardTextStyle ))),
        ),
      );

    }
    return Scaffold(
      backgroundColor:Color(0xFF28334A),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString("assets/json/${this.widget.name}.json"),
              builder: (context, snapshot) {
                var hiragana = json.decode(snapshot.data.toString());
                //int count = snapshot.data["Greetings"].length;
                print(hiragana);

                print("hello there ${this.widget.name}");
                if(hiragana == null)
                {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: h *0.45,
                      ),
                      Center(
                        child:SpinKitCubeGrid(size: 51.0,
                            color: Colors.white),
                      ),

                    ],
                  );
                }
                else
                {
                  print('this is before length');
                  var length = (hiragana[this.widget.name]).length;

                  return  SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: h*0.05,
                        ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center ,
                          children: [
                            SizedBox(
                              width: w*0.05,
                            ),


                            SizedBox(
                                width: w*0.8,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: AutoSizeText( widget.subName,
                                    style: TextStyle(
                                        color: widget.headClr,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold
                                    ),
                                    minFontSize: 20,
                                    maxLines: 1,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: h*0.05,
                        ),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 12.0,
                              childAspectRatio: ( 20/ 20),
                            ),
                            itemCount:length,
                            itemBuilder: (BuildContext context, int index)
                            {
                              return GridButton(hiragana[this.widget.name][index]["inJap"],
                                  hiragana[this.widget.name][index]["inEng"],
                                  index.toString()
                              );
                            }
                        )
                      ],
                    ),
                  );
                }

              }
          ),
        ),
    bottomNavigationBar: SizedBox(
      height: 50,
      child: AdWidget(
        key: UniqueKey(),
        ad: AdmobService.createBannerAd()..load(),
      ),
    ),
    );
  }
}
