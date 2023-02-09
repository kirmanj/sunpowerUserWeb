import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class WallperSlider extends StatefulWidget {
  const WallperSlider({Key? key}) : super(key: key);

  @override
  State<WallperSlider> createState() => _WallperSliderState();
}

class _WallperSliderState extends State<WallperSlider> {
  List images = [];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: images.isEmpty
          ? Container(
              child: Center(child: Text("No Data")),
            )
          : Expanded(
              flex: 3,
              child: CarouselSlider(
                options: CarouselOptions(),
                items: images
                    .map((item) => Container(
                          child: Center(
                              child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(item,
                                        fit: BoxFit.cover,
                                        height: screenSize.height * 0.35,
                                        width: screenSize.width * 0.25),
                                    Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(100, 0, 0, 0),
                                              Color.fromARGB(0, 0, 0, 0)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        child: Text(
                                          'No. ${images.indexOf(item) + 1}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          )),
                        ))
                    .toList(),
              )),
    );
  }
}
