import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
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
                              'Contact Us',
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
                              child: Container(
                                height: screenSize.height * 0.45,
                                width: screenSize.width * 0.9,
                                child: Image.asset("assets/images/map.jpg"),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.black87,
                                  ),
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
                                "https://www.youtube.com/@sunpowercompany172");
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
                        )
                      ],
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
                                "https://www.youtube.com/@sunpowercompany172");
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
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenSize.width * 0.5),
                  height: screenSize.height * 0.7,
                  width: screenSize.width * 0.4,
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
                              'Contact Us',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Card(
                              elevation: 1,
                              child: Container(
                                height: screenSize.height * 0.45,
                                width: screenSize.width * 0.4,
                                child: Image.asset("assets/images/map.jpg"),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.black87,
                                  ),
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
