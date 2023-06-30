import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class CodeDesc extends StatefulWidget {
  final String? code;
  const CodeDesc({ Key? key, this.code }) : super(key: key);

  @override
  _CodeDescState createState() => _CodeDescState();
}

class _CodeDescState extends State<CodeDesc> {
    bool isloaded = false;
    String? htmlData;
    Future fetchcodedesc(String code) async {
    final response = await http.get(
        Uri.parse('https://nahleh.bitsblend.org/api/V1/Codes/$code'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var list2 = jsonDecode(response.body);
      setState(() {
        htmlData = list2['Code']['text'];
        isloaded = true;
      });
      return print(htmlData);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchcodedesc(widget.code!);
  }
  @override
  Widget build(BuildContext context) {
    // dom.Document document = htmlparser.parse(htmlData);
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color(0xFFf2573b),
        title: Text('وصف الكود : ${widget.code}',
            style: TextStyle(
              fontFamily: 'Tajawal',
            )),
        actions: <Widget>[],
      ),
      body: Padding(padding: EdgeInsets.only(top:20,right: 15),child: Column(
        children: [
         isloaded? Text('وصف الخطأ' ,style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Tajawal',
                              fontSize: 18)):Text('جاري البحث', style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Tajawal',
                              fontSize: 18)),
        isloaded? SizedBox(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height * 0.80,
           child: SingleChildScrollView(
             child: Html(
                data:"""${htmlData!}""",
             ),
           ),
         ):Center()
        ],
      ),),
    );
  }
}