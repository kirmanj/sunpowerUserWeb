import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/bestSales.dart';
import 'package:explore/brands.dart';
import 'package:explore/main.dart';
import 'package:explore/web/widgets/ResponsiveSales.dart';
import 'package:explore/web/widgets/categories.dart';
import 'package:explore/web/widgets/contact.dart';
import 'package:explore/web/widgets/offersSlider.dart';
import 'package:explore/web/widgets/sales.dart';

import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/socialMedia.dart';
import 'package:explore/web/widgets/top_bar_contents.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

List products = [];
List<String> itemCodeL = [];

List<String> barcodeL = [];
List<int> indexs = [];
List<String> searchTerm = [];

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _animationWidth = 0;
  double _opacity = 0;
  getProduts() {
    int i = 0;
    FirebaseFirestore.instance.collection('products').get().then((value) => {
          value.docs.forEach((element) async {
            var storage =
                FirebaseStorage.instance.ref().child(element['images'][0]);
            String url = await storage.getDownloadURL();
            setState(() {
              products.add({
                "image": url,
                'name': element['name'],
                'Price': element['retail price'].toString(),
                'itemCode': element['itemCode'].toString(),
                'barCode': element['barCode'].toString(),
                'id': element.id
              });
              itemCodeL.add(element['itemCode'].toString());
              barcodeL.add(element['barCode'].toString());
              indexs.add(i);

              searchTerm.add(element['name'].toString());
            });
            i++;
          })
        });
  }

  List images = [];
  List slideImages = [];

  List _isHovering = [];
  List _isSelected = [];

  List<Map> brands = [];
  getBrands() {
    FirebaseFirestore.instance.collection('brand').get().then((value) {
      value.docs.forEach((element) async {
        _isHovering.add(false);
        _isSelected.add(false);

        brands.add({
          "name": element.data()['name'],
          'image': element.data()['img'],
          'pdf': element.data()['pdfurl']
        });
      });
      if (_isSelected.length != 0) {
        _isSelected[0] = true;
      }
    }).whenComplete(() {
      setState(() {
        brands = brands;
        _isHovering = _isHovering;
        _isSelected = _isSelected;
      });
    });
  }

  final FocusNode _focusNode = FocusNode();
  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _scrollController.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _scrollController.animateTo(offset - 20,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _scrollController.animateTo(offset - 20,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _scrollController.animateTo(offset + 20,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _scrollController.animateTo(offset + 20,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
      setState(() {
        if (kReleaseMode) {
          _scrollController.animateTo(offset + 250,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        } else {
          _scrollController.animateTo(offset + 250,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
      setState(() {
        if (kReleaseMode) {
          _scrollController.animateTo(offset - 250,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        } else {
          _scrollController.animateTo(offset - 250,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        }
      });
    }
  }

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
    if (_scrollPosition > 1) {
      ResponsiveWidget.isSmallScreen(context)
          ? setState(() {
              _animationWidth = 50;
            })
          : setState(() {
              _animationWidth = 70;
            });
    }
    if (_scrollPosition == 0) {
      setState(() {
        _animationWidth = 0;
      });
    }
  }

  final List<String> imageSlide = [
    'assets/images/offer2.jpg',
    'assets/images/offer1.jpg',
    'assets/images/offer4.jpg',
  ];

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    // FirebaseFirestore.instance.collection('Brands').get().then((value) {
    //   print("hi");
    //   print(value.docs);
    //   value.docs.forEach((element) {
    //     print(element['name']);
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor: Color(0xFF35ddde),
              elevation: 0,
              centerTitle: true,
              title: InkWell(
                onTap: () {
                  ResponsiveWidget.isSmallScreen(context)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResponsiveSales()))
                      : Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Sales()));
                },
                child: Container(
                  child: Center(
                    child: Text("HL SUNGLASS"),
                  ),
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, screenSize.height * 0.06),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: screenSize.width,
                height: screenSize.height * 0.6,
                color: _animationWidth != 70
                    ? Color.fromARGB(0, 244, 67, 54)
                    : Colors.white,
                child: TopBarContents(_opacity, _scrollController),
              ),
            ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: _handleKeyEvent,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ResponsiveWidget.isSmallScreen(context)
              ? Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: SizedBox(
                            height: screenSize.height,
                            width: screenSize.width,
                            child: Image.asset(
                              'assets/images/walpper.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: screenSize.width,
                          height: screenSize.height,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: _animationWidth != 50
                                ? Border(
                                    left: BorderSide(
                                        width: _animationWidth,
                                        color: Color.fromARGB(0, 0, 0, 0)),
                                    top: BorderSide(
                                        width: _animationWidth,
                                        color: Color.fromARGB(0, 1, 88, 155)),
                                    right: BorderSide(
                                        width: _animationWidth,
                                        color: Color.fromARGB(0, 1, 88, 155)),
                                  )
                                : Border(
                                    left: BorderSide(
                                        width: _animationWidth,
                                        color: Colors.white),
                                    top: BorderSide(
                                        width: _animationWidth,
                                        color: Colors.white),
                                    right: BorderSide(
                                        width: _animationWidth,
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: screenSize.height * 0.05,
                          right: screenSize.width * 0.17,
                          child: Center(
                            child: Text(
                              "Style Yourself With \n  Our Sunglasses!",
                              style: TextStyle(
                                fontSize: 32,
                                color: Color(0xFF35ddde),
                                fontFamily: 'Cardo',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Offers(),
                    SizedBox(
                      height: screenSize.height * 0.1,
                    ),
                    Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.65,
                        child: Bsales()),
                    Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.7,
                        child: CategoriesScreen()),
                    Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.4,
                        child: Brands()),
                    SizedBox(
                      height: screenSize.height * 0.1,
                    ),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.7,
                      child: ContactUs(),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                    ),
                    Container(
                      height: screenSize.height * 0.3,
                      child: SocialMedia(screenSize: screenSize),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: SizedBox(
                            height: screenSize.height,
                            width: screenSize.width,
                            child: Image.asset(
                              'assets/images/walpper.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: screenSize.width,
                          height: screenSize.height,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: _animationWidth != 70
                                ? Border(
                                    left: BorderSide(
                                        width: _animationWidth,
                                        color: Color.fromARGB(0, 0, 0, 0)),
                                    top: BorderSide(
                                        width: _animationWidth,
                                        color: Color.fromARGB(0, 1, 88, 155)),
                                    right: BorderSide(
                                        width: _animationWidth,
                                        color: Color.fromARGB(0, 1, 88, 155)),
                                  )
                                : Border(
                                    left: BorderSide(
                                        width: _animationWidth,
                                        color: Colors.white),
                                    top: BorderSide(
                                        width: _animationWidth,
                                        color: Colors.white),
                                    right: BorderSide(
                                        width: _animationWidth,
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: screenSize.height * 0.3,
                          right: screenSize.width * 0.04,
                          child: Center(
                            child: Text(
                              " Style Yourself With \n  Our Sunglasses!",
                              style: TextStyle(
                                fontSize: 56,
                                color: Color(0xFF35ddde),
                                fontFamily: 'Cardo',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Offers(),
                    SizedBox(
                      height: screenSize.height * 0.1,
                    ),
                    Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.5,
                        child: Bsales()),
                    Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.7,
                        child: CategoriesScreen()),
                    Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.4,
                        child: Brands()),
                    SizedBox(
                      height: screenSize.height * 0.1,
                    ),
                    Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.7,
                      child: ContactUs(),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1,
                    ),
                    Container(
                      height: screenSize.height * 0.1,
                      child: SocialMedia(screenSize: screenSize),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
