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

    return Container(
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
                                    image:
                                        AssetImage('assets/images/women.jpg'),
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
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    //paint.color = Color(0xFF35ddde);
    paint.color = Colors.white;
    path = Path();
    path.lineTo(size.width * 0.22, size.height * 1.22);
    path.cubicTo(size.width * 0.15, size.height * 1.2, size.width * 0.1,
        size.height * 1.11, size.width * 0.07, size.height * 0.96);
    path.cubicTo(size.width * 0.06, size.height * 0.91, size.width * 0.06,
        size.height * 0.88, size.width * 0.05, size.height * 0.75);
    path.cubicTo(size.width * 0.03, size.height * 0.58, size.width * 0.03,
        size.height * 0.55, size.width * 0.01, size.height * 0.51);
    path.cubicTo(size.width * 0.01, size.height / 2, 0, size.height * 0.49, 0,
        size.height * 0.49);
    path.cubicTo(
        0, size.height * 0.46, 0, size.height * 0.34, 0, size.height / 3);
    path.cubicTo(0, size.height * 0.32, size.width * 0.01, size.height * 0.32,
        size.width * 0.02, size.height * 0.31);
    path.cubicTo(size.width * 0.03, size.height * 0.3, size.width * 0.05,
        size.height * 0.29, size.width * 0.06, size.height * 0.28);
    path.cubicTo(size.width * 0.11, size.height * 0.24, size.width * 0.16,
        size.height * 0.22, size.width / 5, size.height * 0.22);
    path.cubicTo(size.width / 4, size.height * 0.22, size.width * 0.27,
        size.height * 0.23, size.width * 0.35, size.height * 0.28);
    path.cubicTo(size.width * 0.43, size.height * 0.32, size.width * 0.46,
        size.height / 3, size.width / 2, size.height / 3);
    path.cubicTo(size.width * 0.54, size.height / 3, size.width * 0.55,
        size.height / 3, size.width * 0.63, size.height * 0.28);
    path.cubicTo(size.width * 0.65, size.height * 0.27, size.width * 0.67,
        size.height / 4, size.width * 0.68, size.height / 4);
    path.cubicTo(size.width * 0.74, size.height * 0.23, size.width * 0.75,
        size.height * 0.22, size.width * 0.79, size.height * 0.22);
    path.cubicTo(size.width * 0.85, size.height * 0.22, size.width * 0.85,
        size.height * 0.22, size.width * 0.97, size.height * 0.3);
    path.cubicTo(size.width * 0.97, size.height * 0.3, size.width,
        size.height * 0.32, size.width, size.height * 0.32);
    path.cubicTo(size.width, size.height * 0.32, size.width, size.height * 0.39,
        size.width, size.height * 0.39);
    path.cubicTo(size.width, size.height * 0.47, size.width, size.height * 0.48,
        size.width * 0.98, size.height * 0.53);
    path.cubicTo(size.width * 0.97, size.height * 0.57, size.width * 0.96,
        size.height * 0.6, size.width * 0.96, size.height * 0.63);
    path.cubicTo(size.width * 0.95, size.height * 0.76, size.width * 0.92,
        size.height * 0.97, size.width * 0.91, size.height * 1.04);
    path.cubicTo(size.width * 0.9, size.height * 1.12, size.width * 0.86,
        size.height * 1.18, size.width * 0.81, size.height * 1.21);
    path.cubicTo(size.width * 0.79, size.height * 1.22, size.width * 0.79,
        size.height * 1.22, size.width * 0.75, size.height * 1.22);
    path.cubicTo(size.width * 0.71, size.height * 1.22, size.width * 0.7,
        size.height * 1.22, size.width * 0.68, size.height * 1.19);
    path.cubicTo(size.width * 0.63, size.height * 1.15, size.width * 0.6,
        size.height * 1.05, size.width * 0.56, size.height * 0.87);
    path.cubicTo(size.width * 0.55, size.height * 0.81, size.width * 0.55,
        size.height * 0.8, size.width * 0.54, size.height * 0.71);
    path.cubicTo(size.width * 0.53, size.height * 0.61, size.width * 0.53,
        size.height * 0.58, size.width * 0.51, size.height * 0.57);
    path.cubicTo(size.width * 0.51, size.height * 0.56, size.width * 0.48,
        size.height * 0.57, size.width * 0.47, size.height * 0.58);
    path.cubicTo(size.width * 0.46, size.height * 0.59, size.width * 0.46,
        size.height * 0.63, size.width * 0.45, size.height * 0.72);
    path.cubicTo(size.width * 0.42, size.height * 0.93, size.width * 0.4,
        size.height * 1.05, size.width * 0.35, size.height * 1.13);
    path.cubicTo(size.width * 0.32, size.height * 1.19, size.width * 0.26,
        size.height * 1.23, size.width * 0.22, size.height * 1.22);
    path.cubicTo(size.width * 0.22, size.height * 1.22, size.width * 0.22,
        size.height * 1.22, size.width * 0.22, size.height * 1.22);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
