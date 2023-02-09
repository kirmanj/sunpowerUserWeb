import 'package:carousel_slider/carousel_slider.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';

class OffersImageSlider extends StatelessWidget {
  OffersImageSlider(
      {Key? key, required this.screenSize, required this.imageSlide});

  final Size screenSize;
  final List imageSlide;

  final List<String> assets = [
    'assets/images/truck.jpg',
    'assets/images/cars.jpg',
    'assets/images/delivery.jpg',
  ];

  final List<String> title = ['Trucks', 'Cars', 'Shipping'];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Container(
            child: CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 2)),
            items: imageSlide
                .map((item) => Container(
                      child: Center(
                          child: Container(
                        width: screenSize.width,
                        height: screenSize.height / 3.8,
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
          ))
        : Padding(
            padding: EdgeInsets.only(
              top: screenSize.height * 0.06,
              left: screenSize.width / 15,
              right: screenSize.width / 15,
            ),
            child: Container(
                child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 2)),
              items: imageSlide
                  .map((item) => Container(
                        width: screenSize.width / 2,
                        height: screenSize.height / 3.8,
                        child: Center(
                            child: Container(
                          margin: EdgeInsets.all(1.0),
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
          );
  }
}
