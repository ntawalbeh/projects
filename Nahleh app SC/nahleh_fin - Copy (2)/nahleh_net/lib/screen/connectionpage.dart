// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:nahleh_net/widget/constant.dart';

// import 'desccode.dart';
// import 'homepage.dart';

// class _Message {
//   int whom;
//   String text;

//   _Message(this.whom, this.text);
// }

// class _ChatPage extends State<ChatPage> {
//   static final clientID = 0;
//   BluetoothConnection? connection;
//   List list2 = [];

//   List<_Message> messages = List<_Message>.empty(growable: true);
//   List<String>? stringlist = [];
//   String _messageBuffer = '';

//   final TextEditingController textEditingController =
//       new TextEditingController();
//   final ScrollController listScrollController = new ScrollController();
//   bool isloading = true;
//   String statustext = 'جاري الإتصال';
//   bool isConnecting = true;
//   bool get isConnected => (connection?.isConnected ?? false);
//   String lastreport = '';
//   String azLastReport = '';
//   String errortext = '';
//   bool isDisconnecting = false;

//   Future fetchcodes(String code) async {
//     setState(() {
//       statustext = 'جاري تشخيص الأخطاء';
//       errortext = code.trim();
//     });
//     print('https://nahleh.bitsblend.org/api/V1/Decode?codes=${code}');
//     dynamic response = await http.get(
//         Uri.parse('https://nahleh.bitsblend.org/api/V1/Decode?codes=${code}'));

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       print('https://nahleh.bitsblend.org/api/V1/Decode?codes=$code');
//       print(response.body);
//       setState(() {
//         isloading = false;
//       });
//       return list2 = jsonDecode(response.body) as List;
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load ');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     BluetoothConnection.toAddress(widget.server.address).then((_connection) {
//       print('hshshshs');
//       connection = _connection;
//       setState(() {
//         isConnecting = false;
//         isDisconnecting = false;
//       });

//       if (isConnected) {
//         setState(() {
//           statustext = 'جاري تشخيص المركبة';
//         });
//         // _sendMessage('01');
//         Future.delayed(Duration(milliseconds: 100))
//             .then((onValue) => _sendMessage('03'));
//         Future.delayed(Duration(seconds: 16)).then((value) {
//           // fetchcodes(azLastReport);
//         });
//       }

//       connection!.input!.listen(_onDataReceived).onDone(() {
//         if (isDisconnecting) {
//           print('Disconnecting locally!');
//         } else {
//           print('Disconnected remotely!');
//         }
//         if (this.mounted) {
//           setState(() {});
//         }
//       });
//     }).catchError((error) {
//       print('Cannot connect, exception occured');
//       print(error);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => const HomePageNavigator(
//                   indexpage: 1,
//                 )),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     // Avoid memory leak (`setState` after dispose) and disconnect
//     if (isConnected) {
//       isDisconnecting = true;
//       connection?.dispose();
//       connection = null;
//     }

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.white, //change your color here
//         ),
//         backgroundColor: firstColor,
//         title: Text('تشخيص الأعطال', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         actions: <Widget>[],
//       ),
//       backgroundColor: Colors.grey[200],
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 18.0),
//           child: Column(
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.60,
//                 child: !isloading
//                     ? list2.length != 0
//                         ? ListView.builder(
//                             itemCount: list2.length,
//                             itemBuilder: (context, index) {
//                               if (list2.isNotEmpty) {
//                                 var finallist = list2[index] as List;
//                                 if (finallist.isNotEmpty) {
//                                   return ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: finallist.length,
//                                       physics: ClampingScrollPhysics(),
//                                       itemBuilder: (context, int) {
//                                         return GestureDetector(
//                                           onTap: () {
//                                             Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                 builder: (context) {
//                                                   return CodeDesc(
//                                                     code: finallist[int]
//                                                         .toString(),
//                                                   );
//                                                 },
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                               padding: EdgeInsets.only(
//                                                   right: 20,
//                                                   top: 10,
//                                                   bottom: 20),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Icon(
//                                                         Icons.error,
//                                                         color:
//                                                             Color(0xFFf2573b),
//                                                       ),
//                                                       SizedBox(width: 15),
//                                                       Text(
//                                                         finallist[int]
//                                                             .toString(),
//                                                         style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 20),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Divider()
//                                                 ],
//                                               )),
//                                         );
//                                       });
//                                 } else {
//                                   return Center(
//                                     child: Text(
//                                       'لا يوجد أخطاء',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   );
//                                 }
//                               } else {
//                                 return Center(
//                                   child: Text(
//                                     'لا يوجد أخطاء',
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 );
//                               }
//                             })
//                         : Center(
//                             child: Text(
//                               'لا يوجد أخطاء',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           )
//                     : Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SpinKitFadingCircle(
//                               color: firstColor,
//                               size: 100,
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Text(
//                               statustext,
//                               style: TextStyle(
//                                   fontFamily: 'Tajawal',
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//               ),
//               list2.length != 0
//                   ? Container(
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(firstColor)),
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                           child: const Text(
//                             'مسح الأخطاء',
//                             style:
//                                 TextStyle(fontFamily: 'Tajawal', fontSize: 18),
//                           ),
//                         ),
//                         onPressed: () async {
//                           _sendMessage('04');
//                           setState(() {
//                             statustext = 'جاري مسح الأخطاء';
//                             isloading = true;
//                           });
//                           Future.delayed(Duration(seconds: 5))
//                               .then((value) async {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const HomePageNavigator(
//                                         indexpage: 1,
//                                       )),
//                             );
//                           });
//                         },
//                       ),
//                     )
//                   : Container()
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onDataReceived(Uint8List data) async {
//     dynamic azDecodedData = ascii.decode(data);
//     print('Data incoming: ${azDecodedData}');

//     if (azDecodedData.toString().length > 2) {
//       this.azLastReport = azDecodedData.replaceAll(' ', '');
//     }
//   }

//   void _sendMessage(String text) async {
//     text = text.trim();
//     textEditingController.clear();

//     if (text.length > 0) {
//       try {
//         print("Sent : ${text}");
//         connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
//         await connection!.output.allSent;

//         setState(() {
//           messages.add(_Message(clientID, text));
//         });
//       } catch (e) {
//         // Ignore error, but notify state
//         setState(() {});
//       }
//     }
//   }

//   void azSendMessages() async {
//     _sendMessage('01');
//   }
// }
