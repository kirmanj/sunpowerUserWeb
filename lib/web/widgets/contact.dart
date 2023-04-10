import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            width: screenSize.width,
            height: screenSize.height,
            //color: Colors.red,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    // margin: EdgeInsets.only(left: screenSize.width * 0.5),
                    //  height: screenSize.height * 0.7,

                    width: screenSize.width,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xFF35ddde), width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "FIND US",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF35ddde),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Card(
                                  color: Color(0xFF35ddde),
                                  elevation: 1,
                                  child: InkWell(
                                    onTap: () {
                                      _launchURL(
                                          "https://goo.gl/maps/gofgJvJGfVUrCWbj8");
                                    },
                                    child: Container(
                                      width: screenSize.width,
                                      child: Image.asset(
                                        "assets/images/gmap.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _launchURL(
                                            "https://goo.gl/maps/gofgJvJGfVUrCWbj8");
                                      },
                                      child: Container(
                                          width: 15,
                                          height: 15,
                                          child: Image.asset(
                                            "assets/images/google_logo.png",
                                          )),
                                    ),
                                    Text(
                                      '   Address: G33, North Industrial Area, Erbil, Iraq',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF35ddde),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: screenSize.width,
                    margin: EdgeInsets.only(top: screenSize.height * 0),
                    child: Container(
                      padding: EdgeInsets.only(
                        right: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/sunglass.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: screenSize.width * 0.32,
                                    child: Image.asset(
                                      'assets/images/ios.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: screenSize.width * 0.4,
                                    child: Image.asset(
                                      'assets/images/googlePlay.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: screenSize.width,
            height: screenSize.height * 0.7,
            child: Stack(
              children: [
                Container(
                  width: screenSize.width,
                  margin: EdgeInsets.only(top: screenSize.height * 0.1),
                  height: screenSize.height * 0.5,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.025,
                      left: AppLocalizations.of(context)
                                  .locale
                                  .languageCode
                                  .toString() !=
                              'en'
                          ? 5
                          : screenSize.width * 0.0,
                      right: AppLocalizations.of(context)
                                  .locale
                                  .languageCode
                                  .toString() ==
                              'en'
                          ? 5
                          : screenSize.width * 0.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: SizedBox(
                            height: screenSize.height * 0.3,
                            width: screenSize.width * 0.4,
                            child: Image.asset(
                              'assets/images/sunglass.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.width * 0.4,
                          padding: EdgeInsets.only(
                              left: screenSize.width * 0.1,
                              top: screenSize.height * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: screenSize.width * 0.1,
                                  child: Image.asset(
                                    'assets/images/ios.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: screenSize.width * 0.12,
                                  child: Image.asset(
                                    'assets/images/googlePlay.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: AppLocalizations.of(context)
                              .locale
                              .languageCode
                              .toString() !=
                          'en'
                      ? EdgeInsets.only(right: screenSize.width * 0.01)
                      : EdgeInsets.only(left: screenSize.width * 0.5),
                  height: screenSize.height * 0.7,
                  width: screenSize.width * 0.4,
                  child: Card(
                    //  color: Color(0xFF35ddde),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFF35ddde), width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: AppLocalizations.of(context)
                                      .locale
                                      .languageCode
                                      .toString() !=
                                  'en'
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Find Us",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF35ddde),
                              ),
                            ),
                            Card(
                              color: Color(0xFF35ddde),
                              elevation: 1,
                              child: InkWell(
                                onTap: () {
                                  _launchURL(
                                      "https://goo.gl/maps/gofgJvJGfVUrCWbj8");
                                },
                                child: Container(
                                  height: screenSize.height * 0.5,
                                  width: screenSize.width * 0.4,
                                  child: Image.asset(
                                    "assets/images/gmap.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://goo.gl/maps/gofgJvJGfVUrCWbj8");
                                  },
                                  child: Container(
                                      width: 25,
                                      height: 25,
                                      child: Image.asset(
                                        "assets/images/google_logo.png",
                                      )),
                                ),
                                Text(
                                  '   Address: G33, North Industrial Area, Erbil, Iraq',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF35ddde),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
