import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/localization/AppLocal.dart';
import 'package:explore/main.dart';
import 'package:explore/services/local_storage_service.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/categorieSlider.dart';
import 'package:explore/web/widgets/contact.dart';
import 'package:explore/web/widgets/newProduts.dart';
import 'package:explore/web/widgets/offersImageSlider.dart';
import 'package:explore/web/widgets/offersSlider.dart';
import 'package:explore/web/widgets/web_scrollbar.dart';
import 'package:explore/web/widgets/bottom_bar.dart';
import 'package:explore/web/widgets/carousel.dart';
import 'package:explore/web/widgets/destination_heading.dart';
import 'package:explore/web/widgets/explore_drawer.dart';
import 'package:explore/web/widgets/featured_heading.dart';
import 'package:explore/web/widgets/featured_tiles.dart';
import 'package:explore/web/widgets/floating_quick_access_bar.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/top_bar_contents.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  List images = [];
  List slideImages = [];

  getCart() async {
    if (uid!.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .get()
          .then((myDocuments) {
        setState(() {
          cartC = myDocuments.docs.length;
        });
      });
    }
  }

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
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    getBrands();
    getCart();
    FirebaseFirestore.instance
        .collection('Admin')
        .doc("admindoc")
        .get()
        .then((value) {
      setState(() {
        images = value.get("sliderImages");

        slideImages = value.get("offerImages");
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor: _opacity > 0.6
                  ? Colors.black87
                  : Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
              ],
              title: Image.asset(
                _opacity > 0.6
                    ? 'assets/images/sunpower2.png'
                    : 'assets/images/sunpower.png',
                fit: BoxFit.cover,
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity, _scrollController),
            ),
      drawer: ExploreDrawer(_scrollController),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: _handleKeyEvent,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: SizedBox(
                      height: screenSize.height * 0.55,
                      width: screenSize.width,
                      child: images.isNotEmpty
                          ? Container(
                              child: CarouselSlider(
                              options: CarouselOptions(
                                  autoPlay: true,
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 2)),
                              items: images
                                  .map((item) => Container(
                                        child: Center(
                                            child: Container(
                                          margin: EdgeInsets.all(1.0),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Image.network(
                                                    item,
                                                    fit: BoxFit.fitWidth,
                                                    width: screenSize.width,
                                                  ),
                                                  Positioned(
                                                    top: 0.0,
                                                    left: 0.0,
                                                    right: 0.0,
                                                    child: Container(
                                                      height:
                                                          screenSize.height *
                                                              0.1,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(
                                                                182, 0, 0, 0),
                                                            Color.fromARGB(
                                                                0, 0, 0, 0)
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        )),
                                      ))
                                  .toList(),
                            ))
                          : Image.asset(
                              'assets/images/tools.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Container(
                        child: Column(
                          children: [
                            FeaturedHeading(
                              screenSize: screenSize,
                            ),
                            ResponsiveWidget.isSmallScreen(context)
                                ? SizedBox(height: screenSize.height / 20)
                                : SizedBox(height: screenSize.height / 10),
                            Categories(),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: screenSize.height / 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OffersSlidder(
                    screenSize: screenSize,
                  ),
                  Container(
                    width: ResponsiveWidget.isSmallScreen(context)
                        ? screenSize.width
                        : screenSize.width * 0.9,
                    height: screenSize.height * 0.4,
                    child: OffersImageSlider(
                      screenSize: screenSize,
                      imageSlide: slideImages,
                    ),
                  )
                ],
              ),
              SizedBox(height: screenSize.height / 15),
              Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width / 14,
                  right: screenSize.width / 14,
                ),
                child: Container(
                  width: screenSize.width,
                  child: Text(
                    AppLocalizations.of(context).trans("latestProduct"),
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              ResponsiveWidget.isSmallScreen(context)
                  ? SizedBox(height: screenSize.height / 20)
                  : SizedBox(height: screenSize.height / 10),
              LatestProducts(),
              DestinationHeading(screenSize: screenSize),
              brands.isEmpty
                  ? Container()
                  : DestinationCarousel(_isHovering, _isSelected, brands),
              SizedBox(height: screenSize.height / 10),
              ContactUs(),
              SizedBox(height: screenSize.height / 15),
            ],
          ),
        ),
      ),
    );
  }
}
