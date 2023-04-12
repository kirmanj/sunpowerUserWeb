import 'package:explore/web/widgets/ResponsiveSales.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/sales.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List catBools = [false, false, false];

  update(int i) {
    setState(() {
      catBools[i] = !catBools[i];
    });
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
            color: Colors.transparent,
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: screenSize.height * 0.05,
                        bottom: screenSize.height * 0.05),
                    child: Text(
                      "CATEGORIES",
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
                      height: screenSize.height * 0.5,
                      width: screenSize.width,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: AnimatedContainer(
                                duration: Duration(seconds: 2),
                                curve: Curves.easeIn,
                                // padding: EdgeInsets.all(15),
                                child: InkWell(
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
                                  onHover: (e) {
                                    update(0);
                                  },
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      catBools[0]
                                          ? Color.fromARGB(0, 0, 0, 0)
                                          : Colors.grey,
                                      BlendMode.saturation,
                                    ),
                                    child: Container(
                                      height: screenSize.height * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/menswatch.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                        height: screenSize.height * 0.4,
                                        child: Center(
                                            child: Text(
                                          catBools[0] ? "" : "Mens Watch",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w800),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: AnimatedContainer(
                                duration: Duration(seconds: 2),
                                curve: Curves.easeIn,
                                // padding: EdgeInsets.all(15),
                                child: InkWell(
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
                                  onHover: (e) {
                                    update(1);
                                  },
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      catBools[1]
                                          ? Color.fromARGB(0, 0, 0, 0)
                                          : Colors.grey,
                                      BlendMode.saturation,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/women.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        catBools[1] ? "" : "Womens Sunglass",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800),
                                      )),
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: AnimatedContainer(
                                duration: Duration(seconds: 2),
                                curve: Curves.easeIn,
                                //  padding: EdgeInsets.all(15),
                                child: InkWell(
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
                                  onHover: (e) {
                                    update(2);
                                  },
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      catBools[2]
                                          ? Color.fromARGB(0, 0, 0, 0)
                                          : Colors.grey,
                                      BlendMode.saturation,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/menssunglass.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        catBools[2] ? "" : "Mens Sunglass",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800),
                                      )),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            color: Colors.transparent,
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: screenSize.height * 0.05,
                        bottom: screenSize.height * 0.05),
                    child: Text(
                      "CATEGORIES",
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
                      height: screenSize.height * 0.5,
                      width: screenSize.width,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: AnimatedContainer(
                                duration: Duration(seconds: 2),
                                curve: Curves.easeIn,
                                // padding: EdgeInsets.all(15),
                                child: InkWell(
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
                                  onHover: (e) {
                                    update(0);
                                  },
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      catBools[0]
                                          ? Color.fromARGB(0, 0, 0, 0)
                                          : Colors.grey,
                                      BlendMode.saturation,
                                    ),
                                    child: Container(
                                      height: screenSize.height * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/menswatch.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                        height: screenSize.height * 0.4,
                                        child: Center(
                                            child: Text(
                                          catBools[0] ? "" : "Mens Watch",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w800),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: AnimatedContainer(
                                duration: Duration(seconds: 2),
                                curve: Curves.easeIn,
                                // padding: EdgeInsets.all(15),
                                child: InkWell(
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
                                  onHover: (e) {
                                    update(1);
                                  },
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      catBools[1]
                                          ? Color.fromARGB(0, 0, 0, 0)
                                          : Colors.grey,
                                      BlendMode.saturation,
                                    ),
                                    child: Container(
                                      height: screenSize.height * 0.4,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/women.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        catBools[1] ? "" : "Womens Sunglass",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800),
                                      )),
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: AnimatedContainer(
                                height: screenSize.height * 0.4,
                                duration: Duration(seconds: 2),
                                curve: Curves.easeIn,
                                //  padding: EdgeInsets.all(15),
                                child: InkWell(
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
                                  onHover: (e) {
                                    update(2);
                                  },
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      catBools[2]
                                          ? Color.fromARGB(0, 51, 39, 39)
                                          : Colors.grey,
                                      BlendMode.saturation,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/menssunglass.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        catBools[2] ? "" : "Mens Sunglass",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800),
                                      )),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
