import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/sales.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Bsales extends StatefulWidget {
  const Bsales({Key? key}) : super(key: key);

  @override
  State<Bsales> createState() => _BsalesState();
}

class _BsalesState extends State<Bsales> {
  final List<String> postSlide = [
    'assets/images/sun1.png',
    'assets/images/sun2.jpg',
    'assets/images/sun3.jpg',
    'assets/images/sun4.jpg',
    'assets/images/sun5.png',
    'assets/images/sun6.png',
    'assets/images/sun7.png',
  ];
  final List<String> postName = [
    "Snake Laser",
    "Black Gold",
    "Purple Fate",
    "Brown Laser",
    "Gucci Square",
    "Dark Brown",
    "Prada Angels",
  ];
  final List<double> postPrice = [
    18000,
    20000,
    22000,
    45000,
    50000,
    34000,
    60000
  ];

  List postBools = [false, false, false, false, false, false];

  launchWhatsAppUri(String name, String price) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+964-(750)5448229',
      text: "Hello HL SUNGLASS \n I Want this Sunglass \n Product Name: " +
          name +
          "\n Price: " +
          price,
    );

    await launchUrl(link.asUri());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            // color: Colors.grey[400],
            height: screenSize.height * 0.65,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      //  top: screenSize.height * 0.05,
                      bottom: screenSize.height * 0.05),
                  child: Text(
                    "BEST SALES",
                    style: TextStyle(
                      color: Color(0xFF35ddde),
                      fontFamily: 'Cardo',
                      fontSize: 32,
                    ),
                  ),
                ),
                Container(
                  height: screenSize.height * 0.5,
                  width: screenSize.width,
                  child: ListView.builder(
                      itemCount: postSlide.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sales()));
                            },
                            child: Container(
                              height: screenSize.height * 0.2,
                              decoration: BoxDecoration(
                                  color: Color(0xFF35ddde),
                                  border: Border.all(
                                    color: Color(0xFF35ddde),
                                  )),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      color: Colors.white,
                                      width: screenSize.width,
                                      child: Image.asset(
                                        postSlide[index],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: screenSize.width,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF35ddde),
                                          border: Border.all(
                                            color: Color(0xFF35ddde),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                color: Color(0xFF35ddde),
                                                child: Text(
                                                  postName[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                color: Color(0xFF35ddde),
                                                child: Text(
                                                  (postPrice[index].toString() +
                                                          " IQD")
                                                      .replaceAllMapped(
                                                          RegExp(
                                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                          (Match m) =>
                                                              '${m[1]},'),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                  onPressed: () {
                                                    launchWhatsAppUri(
                                                        postName[index],
                                                        (postPrice[index]
                                                                    .toString() +
                                                                " IQD")
                                                            .replaceAllMapped(
                                                                RegExp(
                                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                (Match m) =>
                                                                    '${m[1]},'));
                                                  },
                                                  icon: Icon(
                                                    Icons.ios_share_rounded,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        : Container(
            // color: Colors.grey[400],
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      //  top: screenSize.height * 0.05,
                      bottom: screenSize.height * 0.05),
                  child: Text(
                    "BEST SALES",
                    style: TextStyle(
                      color: Color(0xFF35ddde),
                      fontFamily: 'Cardo',
                      fontSize: 32,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.0),
                  child: Container(
                    height: screenSize.height * 0.2,
                    width: screenSize.width,
                    child: Center(
                      child: ListView.builder(
                          itemCount: postSlide.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Sales()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF35ddde),
                                      border: Border.all(
                                        color: Color(0xFF35ddde),
                                      )),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          color: Colors.white,
                                          width: screenSize.width * 0.2,
                                          child: Image.asset(
                                            postSlide[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: screenSize.width * 0.2,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF35ddde),
                                            border: Border.all(
                                              color: Color(0xFF35ddde),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  color: Color(0xFF35ddde),
                                                  child: Text(
                                                    postName[index],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  color: Color(0xFF35ddde),
                                                  child: Text(
                                                    (postPrice[index]
                                                                .toString() +
                                                            " IQD")
                                                        .replaceAllMapped(
                                                            RegExp(
                                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                            (Match m) =>
                                                                '${m[1]},'),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                    onPressed: () {
                                                      launchWhatsAppUri(
                                                          postName[index],
                                                          (postPrice[index]
                                                                      .toString() +
                                                                  " IQD")
                                                              .replaceAllMapped(
                                                                  RegExp(
                                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                  (Match m) =>
                                                                      '${m[1]},'));
                                                    },
                                                    icon: Icon(
                                                      Icons.ios_share_rounded,
                                                      color: Colors.white,
                                                      size: 18,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
