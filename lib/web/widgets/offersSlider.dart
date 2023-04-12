import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late List imageSlide = [];
  getOffer() {
    FirebaseFirestore.instance.collection('offers').get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          imageSlide.add(element['img']);
        });
      });
    });
  }

  @override
  void initState() {
    getOffer();
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  // final List<String> imageSlide = [
  //   'assets/images/offer2.jpg',
  //   'assets/images/offer1.jpg',
  //   'assets/images/offer4.jpg',
  // ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget.isSmallScreen(context)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 100.0, bottom: 80.0),
                child: Center(
                  child: Text(
                    "OFFERS",
                    style: TextStyle(
                      color: Color(0xFF35ddde),
                      fontFamily: 'Cardo',
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: screenSize.height * 0.6,
                  width: screenSize.width,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            width: screenSize.width,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  scrollDirection: Axis.vertical,
                                  autoPlay: true,
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 2)),
                              items: imageSlide
                                  .map((item) => Container(
                                        width: screenSize.width,
                                        height: screenSize.height / 3,
                                        child: Center(
                                            child: Container(
                                          // margin: EdgeInsets.all(1.0),
                                          child: Card(
                                            elevation: 5,
                                            color: Colors.white,
                                            child: Image.network(
                                              item,
                                              fit: BoxFit.cover,
                                              width: screenSize.width,
                                            ),
                                          ),
                                        )),
                                      ))
                                  .toList(),
                            )),
                      ),

                      //   Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(45),
                            color: Color(0xFF35ddde),
                            child: Center(
                              child: Text(
                                "We believe that our combination of quality, affordability, and eco-friendliness makes SunSpecs a compelling choice for entrepreneurs looking to enter the eyewear market. Join us today and help us bring our sunglasses to new audiences around the world!",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          )),
                      // Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 100.0, bottom: 80.0),
                child: Text(
                  "OFFERS",
                  style: TextStyle(
                    color: Color(0xFF35ddde),
                    fontFamily: 'Cardo',
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: screenSize.height * 0.4,
                  width: screenSize.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                            child: CarouselSlider(
                          options: CarouselOptions(
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              autoPlayAnimationDuration: Duration(seconds: 2)),
                          items: imageSlide
                              .map((item) => Container(
                                    width: screenSize.width / 2,
                                    height: screenSize.height / 3,
                                    child: Center(
                                        child: Container(
                                      // margin: EdgeInsets.all(1.0),
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        child: Image.network(
                                          item,
                                          fit: BoxFit.cover,
                                          width: screenSize.width,
                                        ),
                                      ),
                                    )),
                                  ))
                              .toList(),
                        )),
                      ),
                      //   Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.all(45),
                            color: Color(0xFF35ddde),
                            child: Center(
                              child: Text(
                                "We believe that our combination of quality, affordability, and eco-friendliness makes SunSpecs a compelling choice for entrepreneurs looking to enter the eyewear market. Join us today and help us bring our sunglasses to new audiences around the world!",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          )),
                      // Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
