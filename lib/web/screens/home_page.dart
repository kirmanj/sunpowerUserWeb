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
import 'package:explore/web/widgets/searchSale.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      setState(() {
        role = int.parse(value.get("role").toString());
      });
    });
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
    getProduts();
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
              backgroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                ),
              ],
              title: Image.asset(
                'assets/images/sunpower2.png',
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

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    List<int> matchIndex = [];
    int i = 0;
    for (var item in itemCodeL) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
        matchIndex.add(i);
      }
      i++;
    }
    i = 0;
    for (var item in barcodeL) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        if (matchIndex.contains(i)) {
        } else {
          matchQuery.add(item);
          matchIndex.add(i);
        }
      }
      i++;
    }
    i = 0;
    for (var item in searchTerm) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        if (matchIndex.contains(i)) {
        } else {
          matchQuery.add(item);
          matchIndex.add(i);
        }
      }
      i++;
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = products[matchIndex[index]];
          print(result);
          return ListTile(
            title: Container(
              height: 150,
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          result['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text("Name"),
                          subtitle: Text(result['name']),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text("Item Code"),
                          subtitle: Text(result['itemCode']),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text("Price"),
                          subtitle: Text(result['Price'].toString() + " \$"),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text("Bar Code"),
                          subtitle: Text(result['barCode']),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<int> matchIndex = [];
    int i = 0;
    for (var item in itemCodeL) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
        matchIndex.add(i);
      }
      i++;
    }
    i = 0;
    for (var item in barcodeL) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        if (matchIndex.contains(i)) {
        } else {
          matchQuery.add(item);
          matchIndex.add(i);
        }
      }
      i++;
    }
    i = 0;
    for (var item in searchTerm) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        if (matchIndex.contains(i)) {
        } else {
          matchQuery.add(item);
          matchIndex.add(i);
        }
      }
      i++;
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = products[matchIndex[index]];

          return ListTile(
            title: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchSales(
                          productId: products[index]["id"],
                        )));
              },
              child: Container(
                height: 150,
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Image.network(
                            result['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(fontSize: 8),
                                        ),
                                        Text(
                                          result['name'],
                                          style: TextStyle(fontSize: 8),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Item Code",
                                          style: TextStyle(fontSize: 8),
                                        ),
                                        Text(
                                          result['itemCode'],
                                          style: TextStyle(fontSize: 8),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price",
                                          style: TextStyle(fontSize: 8),
                                        ),
                                        Text(
                                          result['Price'].toString() + " \$",
                                          style: TextStyle(fontSize: 8),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Bar Code",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                      Text(
                                        result['barCode'],
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
