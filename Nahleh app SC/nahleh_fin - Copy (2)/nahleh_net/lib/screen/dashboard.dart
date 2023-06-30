import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nahleh_net/widget/constant.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.05;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text(
          'الرئيسية',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: 250,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'هنا نص يمكن تغيره هنا نص يمكن تغيره هنا نص يمكن تغيره هنا نص يمكن تغيره هنا نص يمكن تغيره هنا نص يمكن تغيره هنا نص يمكن تغيره هنا نص يمكن تغيره ',
                  style: TextStyle(
                      fontFamily: 'Tajawal', fontWeight: FontWeight.w500),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, bottom: 30.0, right: 8),
                    child: Column(
                      children: [
                        Text(
                          'طريقة الإستخدام',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: secontColor),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              '1- ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: secontColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: size.width * 0.75,
                              child: Text(
                                  'قم بتوصيل جهاز الفحص بالمدخل المخصص ',
                                  maxLines: 2,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '2- ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: secontColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('أذهب الى صفحة تشخيص الأعطال',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: SvgPicture.asset(
                                'assets/images/code.svg',
                                color: secontColor,
                                width: 35,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '3- ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: secontColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(' تأكد من أن حالة البلوتوث متصل',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '4- ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: secontColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('للمزيد من الشرح ',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: 5,
                            ),
                            Text('أنقر هنا',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: firstColor))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
