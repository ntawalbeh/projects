import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nahleh_net/widget/constant.dart';

import 'azconnectionpage.dart';

class Codes extends StatefulWidget {
  const Codes({Key? key}) : super(key: key);

  @override
  _CodesState createState() => _CodesState();
}

class _CodesState extends State<Codes> {
  String _address = "...";
  String _name = "...";

  bool _autoAcceptPairingRequests = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text(
          'تشخيص الأعطال',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [AZConnectionPage()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
