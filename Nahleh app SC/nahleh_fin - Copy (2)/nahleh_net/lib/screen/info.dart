import 'package:flutter/material.dart';
import 'package:nahleh_net/widget/constant.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        centerTitle: true,
        title: Text('إتصل بنا',
            style: TextStyle(fontFamily: 'Tajawal', color: Colors.white)),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Text(
                        'لوريم إيبسوم(Lorem Ipsum) هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص، بل انه حتى صار مستخدماً وبشكله الأصلي في الطباعة والتنضيد الإلكتروني. انتشر بشكل كبير في ستينيّات هذا القرن مع إصدار رقائق "ليتراسيت" (Letraset) البلاستيكية تحوي مقاطع من هذا النص، وعاد لينتشر مرة أخرى مؤخراَ مع ظهور برامج النشر الإلكتروني مثل "ألدوس بايج مايكر" (Aldus PageMaker) والتي حوت أيضاً على نسخ من نص لوريم إيبسوم.',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Text(
                        'معلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنامعلومات نص كامل هنا',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Tajawal'),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.phone),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(
                            firstColor), // <-- Button color
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed))
                            return kPrimaryColor; // <-- Splash color
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '079999999999',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.email),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(
                            firstColor), // <-- Button color
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed))
                            return kPrimaryColor; // <-- Splash color
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'info@asd.com',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.web),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(
                            firstColor), // <-- Button color
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed))
                            return kPrimaryColor; // <-- Splash color
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'www.ssssss.com',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
