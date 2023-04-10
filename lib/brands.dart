import 'package:explore/web/widgets/ResponsiveSales.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/sales.dart';
import 'package:flutter/material.dart';

class Brands extends StatefulWidget {
  const Brands({Key? key}) : super(key: key);

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  final List<String> brandSlide = [
    'assets/images/dior.png',
    'assets/images/gucci.png',
    'assets/images/louis.png',
    'assets/images/prada.png',
    'assets/images/polo.png',
  ];
  final List<String> brandName = [
    "DIOR",
    "GUCCI",
    "LOUIS VUITTON",
    "PRADA",
    "POLO"
  ];

  List brandBools = [false, false, false, false, false, false];

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
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: screenSize.height * 0.1,
                      bottom: screenSize.height * 0.00),
                  child: Text(
                    "BRANDS",
                    style: TextStyle(
                      color: Color(0xFF35ddde),
                      fontFamily: 'Cardo',
                      fontSize: 32,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.05),
                  child: Container(
                    height: screenSize.height * 0.2,
                    //color: Colors.red,
                    width: screenSize.width,
                    child: Center(
                      child: ListView.builder(
                          itemCount: brandSlide.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                ResponsiveWidget.isSmallScreen(context)
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResponsiveSales()))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Sales()));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: screenSize.width * 0.05,
                                    right: screenSize.width * 0.05),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: screenSize.width * 0.2,
                                        child: Image.asset(
                                          brandSlide[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                          child: Text(
                                        brandName[index],
                                      )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        //  top: screenSize.height * 0.05,
                        bottom: screenSize.height * 0.05),
                    child: Text(
                      "BRANDS",
                      style: TextStyle(
                        color: Color(0xFF35ddde),
                        fontFamily: 'Cardo',
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.05),
                    child: Container(
                      height: screenSize.height * 0.2,
                      width: screenSize.width * 0.8,
                      child: Center(
                        child: ListView.builder(
                            itemCount: brandSlide.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  ResponsiveWidget.isSmallScreen(context)
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResponsiveSales()))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Sales()));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: screenSize.width * 0.05,
                                      right: screenSize.width * 0.05),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: screenSize.width * 0.05,
                                        height: screenSize.width * 0.05,
                                        child: Image.asset(
                                          brandSlide[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Center(
                                          child: Text(
                                        brandName[index],
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
