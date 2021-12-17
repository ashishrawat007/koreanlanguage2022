// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hexcolor/hexcolor.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' ;
import 'package:koreanlanguage2022/services/admob_service.dart';


class DataScreen extends StatefulWidget {
  String name;

  DataScreen( this.name);

  @override
  _DataScreenState createState() => _DataScreenState();
}
enum TtsState { playing, stopped, paused, continued }

class _DataScreenState extends State<DataScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  List<String> allRows;
  List<Object> itemList;

  @override
  Widget build(BuildContext context)
  {
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

    var h = MediaQuery.of(context).size.height ;
    var w = MediaQuery.of(context).size.width ;


    return Scaffold(
        backgroundColor: Color(0xFF28334A),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString("assets/json/${widget.name}.json"),
              builder: (context, snapshot) {
                var question = json.decode(snapshot.data.toString());
                //int count = snapshot.data["Greetings"].length;
                print(question);

                print("hello there ${this.widget.name}");
                if(question == null)
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
                  return  SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: w*0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: w*0.05,
                            ),
                            label(this.widget.name,(h+w) *0.027 ,Color(0xFFFBDE44)),

                          ],
                        ),
                        SizedBox(
                          height: w*0.03,
                        ),
                        ListView.separated(
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: h*0.01,
                              );
                            },
                            itemCount: question[this.widget.name].length,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),

                            itemBuilder: (BuildContext context,int index){
                              return  ExpansionTileCard(
                                
                                baseColor: Colors.grey[200].withOpacity(0.8),
                                expandedColor: Colors.grey[200],
                                leading: CircleAvatar(
                                  backgroundColor: Color(0xFFDD493B),
                                    child: Text(' ${index+1} ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: (h+w) * 0.0156
                                    ),)),

                                title: Text(question[this.widget.name][index]["inEng"]),

                                subtitle: Text(question[this.widget.name][index]["inEngJap"]),

                                children: <Widget>[
                                  Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        question[this.widget.name][index]["inJap"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    buttonHeight: h*0.05,
                                    buttonMinWidth: w*0.05,

                                  ),
                                ],
                              );
                            }
                        ),

                      ],
                    ),
                  );
                }

              }
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
