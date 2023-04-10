import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/sales.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final List<String> scoialList = [
      'assets/images/youtube.png',
      'assets/images/facebook.png',
      'assets/images/instagram.png',
      'assets/images/tiktok.png',
      'assets/images/snap.png',
    ];

    _launchURL(url) async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    }

    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Color(0xFF35ddde),
                          width: screenSize.width,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Contact Us',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Divider(
                                                  color: Colors.white,
                                                  height: 1,
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              width: 25,
                                                              height: 25,
                                                              child: Image.asset(
                                                                  "assets/images/phone.png")),
                                                          Text(
                                                            '+964 750 077 7000           ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            width: 25,
                                                            height: 25,
                                                            child: Image.asset(
                                                                "assets/images/phone.png")),
                                                        Text(
                                                          '+964 772 277 7000            ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            width: 25,
                                                            height: 25,
                                                            child: Image.asset(
                                                                "assets/images/phone.png")),
                                                        Text(
                                                          '+964 750 033 3000            ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            width: 25,
                                                            height: 25,
                                                            child: Center(
                                                                child: Image.asset(
                                                                    "assets/images/email.png"))),
                                                        Text(
                                                          "     info@sunpowerc.com ",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        //  color: Colors.red,
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                'Social Media',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Divider(
                                                color: Colors.white,
                                                height: 1,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: Image.asset(
                                                          "assets/images/youtube.png")),
                                                  Container(
                                                      width: 25,
                                                      height: 25,
                                                      child: Image.asset(
                                                          "assets/images/facebook.png")),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                      width: 28,
                                                      height: 28,
                                                      child: Image.asset(
                                                          "assets/images/instagram.png")),
                                                  Container(
                                                      width: 25,
                                                      height: 25,
                                                      child: Image.asset(
                                                          "assets/images/tiktok.png")),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: Image.asset(
                                                          "assets/images/snap.png")),
                                                  Container(
                                                      width: 25,
                                                      height: 25,
                                                      child: Container()),
                                                ],
                                              ),
                                            )),
                                        Expanded(flex: 1, child: Container())
                                      ],
                                    ))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.copyright,
                              color: Color(0xFF35ddde),
                              size: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Guideware",
                              style: TextStyle(
                                  color: Color(0xFF35ddde), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )
        : Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Color(0xFF35ddde),
                  width: screenSize.width,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Center(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/phone.png")),
                                    Text(
                                      '+964 750 077 7000',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/phone.png")),
                                    Text(
                                      '+964 772 277 7000  ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/phone.png")),
                                    Text(
                                      '+964 750 033 3000',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.width * 0.02,
                                  right: screenSize.width * 0.02),
                              child: Container(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/youtube.png")),
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/facebook.png")),
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/instagram.png")),
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/tiktok.png")),
                                    Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/snap.png")),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 25,
                                    height: 25,
                                    child: Center(
                                        child: Image.asset(
                                            "assets/images/email.png"))),
                                Text(
                                  " info@sunpowerc.com",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.copyright,
                            color: Color(0xFF35ddde),
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Guideware",
                            style: TextStyle(
                                color: Color(0xFF35ddde), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          );
  }
}
