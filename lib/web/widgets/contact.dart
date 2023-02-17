import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/map.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

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
        ? SafeArea(
            child: Container(
              width: screenSize.width,
              child: Column(
                children: [
                  Container(
                    height: screenSize.height * 0.7,
                    width: screenSize.width,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .trans("contact_us"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Card(
                                elevation: 1,
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.google.com/maps/place/Sun+Power+Company,+North+Industrial+Area+G33,+Erbil+44001/@0,0,22z/data=!4m2!3m1!1s0x400721bde5c36167:0x3da92b465a7893c?hl=en-US&gl=us");
                                  },
                                  child: Container(
                                    height: screenSize.height * 0.45,
                                    width: screenSize.width * 0.9,
                                    child: Image.asset(
                                      "assets/images/map.png",
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
                                          "https://www.google.com/maps/place/Sun+Power+Company,+North+Industrial+Area+G33,+Erbil+44001/@0,0,22z/data=!4m2!3m1!1s0x400721bde5c36167:0x3da92b465a7893c?hl=en-US&gl=us");
                                    },
                                    child: Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            "assets/images/gmap.png")),
                                  ),
                                  Text(
                                    'Address: G33, North Industrial Area, Erbil, Iraq',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(254, 246, 238, 50),
                          Color.fromARGB(254, 211, 160, 38),
                          Color.fromARGB(254, 246, 238, 50),
                        ],
                      ),
                    ),
                    height: screenSize.height * 0.5,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: screenSize.width * 0.2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '+964 750 077 7000',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '+964 772 277 7000  ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '+964 750 033 3000',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            leading: Container(
                                width: 25,
                                height: 25,
                                child: Center(
                                    child: Image.asset(
                                        "assets/images/phone.png"))),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  "https://www.youtube.com/@sunpowercompany?themeRefresh=1");
                            },
                            child: ListTile(
                              title: Text(
                                "sunpowercompany",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Container(
                                  width: 25,
                                  height: 25,
                                  child:
                                      Image.asset("assets/images/youtube.png")),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  "https://m.facebook.com/SunPowerCompany/?refsrc=deprecated&_rdr");
                            },
                            child: ListTile(
                              title: Text(
                                "SunPowerCompany",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Container(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                      "assets/images/facebook.png")),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  "https://www.instagram.com/sunpower_iraq/?igshid=MWI4MTIyMDE%3D");
                            },
                            child: ListTile(
                              title: Text(
                                "sunpower_iraq",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Container(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                      "assets/images/instagram.png")),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  "https://www.tiktok.com/@sunpower_company");
                            },
                            child: ListTile(
                              title: Text(
                                "Sunpowercompany",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Container(
                                  width: 25,
                                  height: 25,
                                  child:
                                      Image.asset("assets/images/tiktok.png")),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  "hhttps://www.snapchat.com/add/sunpowercompany?share_id=X2yOzUPlQcK0OfOwinhpLw&locale=en_US&sid=c5e95bf95b814fefb7e9fca41d23bdab");
                            },
                            child: ListTile(
                              title: Text(
                                "Sunpowercompany",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Container(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset("assets/images/snap.png")),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              " info@sunpowerc.com",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Container(
                                width: 25,
                                height: 25,
                                child: Center(
                                    child: Image.asset(
                                        "assets/images/email.png"))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            width: screenSize.width,
            height: screenSize.height * 0.7,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenSize.height * 0.1),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(254, 246, 238, 50),
                        Color.fromARGB(254, 211, 160, 38),
                        Color.fromARGB(254, 246, 238, 50),
                      ],
                    ),
                  ),
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
                          : screenSize.width * 0.2,
                      right: AppLocalizations.of(context)
                                  .locale
                                  .languageCode
                                  .toString() ==
                              'en'
                          ? 5
                          : screenSize.width * 0.7,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '+964-750-077-7000',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '+964-772-277-7000  ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '+964-750-033-3000',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          leading: Container(
                              width: 25,
                              height: 25,
                              child: Center(
                                  child:
                                      Image.asset("assets/images/phone.png"))),
                        ),
                        ListTile(
                          title: Text(
                            " info@sunpowerc.com",
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: Container(
                              width: 25,
                              height: 25,
                              child: Center(
                                  child:
                                      Image.asset("assets/images/email.png"))),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.youtube.com/@sunpowercompany?themeRefresh=1");
                          },
                          child: ListTile(
                            title: Text(
                              "sunpowercompany",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Container(
                                width: 25,
                                height: 25,
                                child:
                                    Image.asset("assets/images/youtube.png")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://m.facebook.com/SunPowerCompany/?refsrc=deprecated&_rdr");
                          },
                          child: ListTile(
                            title: Text(
                              "SunPowerCompany",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Container(
                                width: 25,
                                height: 25,
                                child:
                                    Image.asset("assets/images/facebook.png")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.instagram.com/sunpower_iraq/?igshid=MWI4MTIyMDE%3D");
                          },
                          child: ListTile(
                            title: Text(
                              "sunpower_iraq",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Container(
                                width: 25,
                                height: 25,
                                child:
                                    Image.asset("assets/images/instagram.png")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.tiktok.com/@sunpower_company");
                          },
                          child: ListTile(
                            title: Text(
                              "Sunpowercompany",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Container(
                                width: 25,
                                height: 25,
                                child: Image.asset("assets/images/tiktok.png")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.snapchat.com/add/sunpowercompany?share_id=X2yOzUPlQcK0OfOwinhpLw&locale=en_US&sid=c5e95bf95b814fefb7e9fca41d23bdab");
                          },
                          child: ListTile(
                            title: Text(
                              "Sunpowercompany",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Container(
                                width: 25,
                                height: 25,
                                child: Image.asset("assets/images/snap.png")),
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
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
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
                              AppLocalizations.of(context).trans("contact_us"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Card(
                              elevation: 1,
                              child: InkWell(
                                onTap: () {
                                  _launchURL(
                                      "https://www.google.com/maps/place/Sun+Power+Company,+North+Industrial+Area+G33,+Erbil+44001/@0,0,22z/data=!4m2!3m1!1s0x400721bde5c36167:0x3da92b465a7893c?hl=en-US&gl=us");
                                },
                                child: Container(
                                  height: screenSize.height * 0.5,
                                  width: screenSize.width * 0.4,
                                  child: Image.asset(
                                    "assets/images/map.png",
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
                                        "https://www.google.com/maps/place/Sun+Power+Company,+North+Industrial+Area+G33,+Erbil+44001/@0,0,22z/data=!4m2!3m1!1s0x400721bde5c36167:0x3da92b465a7893c?hl=en-US&gl=us");
                                  },
                                  child: Container(
                                      width: 25,
                                      height: 25,
                                      child: Image.asset(
                                        "assets/images/gmap.png",
                                      )),
                                ),
                                Text(
                                  'Address: G33, North Industrial Area, Erbil, Iraq',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
