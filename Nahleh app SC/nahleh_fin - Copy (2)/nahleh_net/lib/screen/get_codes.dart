import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nahleh_net/widget/constant.dart';

import 'desccode.dart';
import 'homepage.dart';

import 'package:restart_app/restart_app.dart';

class AZGetCodes extends StatefulWidget {
  dynamic AZCodes;
  dynamic AZDevice;
  dynamic AZUUID;

  AZGetCodes(
      {Key? key,
      required this.AZCodes,
      required this.AZDevice,
      required this.AZUUID})
      : super(key: key);

  @override
  State<AZGetCodes> createState() => AZ_GetCodesState();
}

class AZ_GetCodesState extends State<AZGetCodes> {
  static final clientID = 0;
  List list2 = [];

  List<String>? stringlist = [];

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  bool isloading = true;
  String statustext = 'جاري التشخيص';
  String errortext = '';

  Future fetchcodes(String code) async {
    setState(() {
      statustext = 'جاري تشخيص الأخطاء';
      errortext = code.trim();
    });
    print('https://nahleh.bitsblend.org/api/V1/Decode?codes=${code}');
    dynamic response = await http.get(
        Uri.parse('https://nahleh.bitsblend.org/api/V1/Decode?codes=${code}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('https://nahleh.bitsblend.org/api/V1/Decode?codes=$code');
      print(response.body);
      setState(() {
        isloading = false;
      });
      return list2 = jsonDecode(response.body) as List;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchcodes(widget.AZCodes.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: firstColor,
        title: Text('تشخيص الأعطال', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.60,
                child: !isloading
                    ? list2.length != 0
                        ? ListView.builder(
                            itemCount: list2.length,
                            itemBuilder: (context, index) {
                              if (list2.isNotEmpty) {
                                var finallist = list2[index] as List;
                                if (finallist.isNotEmpty) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: finallist.length,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, int) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return CodeDesc(
                                                    code: finallist[int]
                                                        .toString(),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.error,
                                                        color:
                                                            Color(0xFFf2573b),
                                                      ),
                                                      SizedBox(width: 15),
                                                      Text(
                                                        finallist[int]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider()
                                                ],
                                              )),
                                        );
                                      });
                                } else {
                                  return Center(
                                    child: Text(
                                      'لا يوجد أخطاء',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }
                              } else {
                                return Center(
                                  child: Text(
                                    'لا يوجد أخطاء',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }
                            })
                        : Center(
                            child: Text(
                              'لا يوجد أخطاء',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitFadingCircle(
                              color: firstColor,
                              size: 100,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              statustext,
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
              ),
              list2.length != 0
                  ? Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(firstColor)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: const Text(
                            'مسح الأخطاء',
                            style:
                                TextStyle(fontFamily: 'Tajawal', fontSize: 18),
                          ),
                        ),
                        onPressed: () async {
                          widget.AZDevice.write(
                              widget.AZUUID,
                              Uint8List.fromList(utf8.encode("04" + "\r\n"))
                                  .toList());
                          setState(() {
                            statustext = 'جاري مسح الأخطاء';
                            isloading = true;
                          });
                          Future.delayed(Duration(seconds: 5))
                              .then((value) async {
                            setState(() {
                              statustext =
                                  'تم مسح الاخطاء بنجاح. اعادة التشغيل ...';
                              Restart.restartApp();
                            });
                          });
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
