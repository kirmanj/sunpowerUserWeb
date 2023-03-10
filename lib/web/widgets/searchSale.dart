import 'package:barcode_widget/barcode_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/main.dart';
import 'package:explore/pdfread.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SearchSales extends StatefulWidget {
  final String productId;
  SearchSales({required this.productId});

  @override
  State<SearchSales> createState() => _SearchSalesState();
}

class _SearchSalesState extends State<SearchSales> {
  Map product = {};
  List images = [];
  String make = "";
  String model = "";
  int quantity = 1;

  bool showDis = false;

  getProduct() {
    FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get()
        .then((value) {
      setState(() {
        product = {
          "brand": value.get("brand"),
          "barCode": value.get("barCode"),
          "categoryID": value.get("categoryID"),
          "desc": value.get("desc"),
          "descA": value.get("descA"),
          "descK": value.get("descK"),
          "images": value.get("images"),
          "itemCode": value.get("itemCode"),
          "makeId": value.get("makeId"),
          "modelId": value.get("modelId"),
          "name": value.get("name"),
          "nameA": value.get("nameA"),
          "nameK": value.get("nameK"),
          "newArrival": value.get("newArrival"),
          "oemCode": value.get("oemCode"),
          "pdfUrl": value.get("pdfUrl"),
          "piecesInBox": value.get("piecesInBox"),
          "productID": value.get("productID"),
          "quantity": value.get("quantity"),
          "retail price": value.get("retail price"),
          "volt": value.get("volt"),
          "wholesale price": value.get("wholesale price")
        };
      });

      value.get("images").forEach((item) async {
        var storage = FirebaseStorage.instance.ref().child(item);
        String url = await storage.getDownloadURL();
        setState(() {
          images.add(url);
        });
      });

      FirebaseFirestore.instance
          .collection('make')
          .doc(value.get("makeId"))
          .get()
          .then((value1) {
        setState(() {
          make = value1.get("make");
        });
      });

      FirebaseFirestore.instance
          .collection('make')
          .doc(value.get("makeId"))
          .collection("models")
          .doc(value.get("modelId"))
          .get()
          .then((value1) {
        setState(() {
          model = value1.get("mname");
        });
      });
    });
  }

  @override
  void initState() {
    getProduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: product.isEmpty
            ? Container()
            : ResponsiveWidget.isSmallScreen(context)
                ? Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.87,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.red[900],
                                      size: 18,
                                    ),
                                  ),
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle: StrutStyle(fontSize: 12.0),
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          text: product['name'].toString()),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child: role == 0
                                        ? Text(
                                            "       " +
                                                product['retail price']
                                                    .toString() +
                                                " \$",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        : Text(
                                            product['wholesale price']
                                                .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenSize.width,
                              height: screenSize.height * 0.68,
                              child: Column(
                                children: [
                                  images.isEmpty
                                      ? Expanded(
                                          flex: 3,
                                          child: Container(
                                            child:
                                                Center(child: Text("No Data")),
                                          ),
                                        )
                                      : Expanded(
                                          flex: 3,
                                          child: CarouselSlider(
                                            options: CarouselOptions(),
                                            items: images
                                                .map((item) => Container(
                                                      child: Center(
                                                          child: Container(
                                                        margin:
                                                            EdgeInsets.all(5.0),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Image.network(
                                                                    item,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: screenSize
                                                                            .width *
                                                                        0.80),
                                                                Positioned(
                                                                  bottom: 0.0,
                                                                  left: 0.0,
                                                                  right: 0.0,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color.fromARGB(
                                                                              100,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          Color.fromARGB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0)
                                                                        ],
                                                                        begin: Alignment
                                                                            .bottomCenter,
                                                                        end: Alignment
                                                                            .topCenter,
                                                                      ),
                                                                    ),
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.0,
                                                                        horizontal:
                                                                            20.0),
                                                                    child: Text(
                                                                      'No. ${images.indexOf(item) + 1}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.0,
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
                                  Divider(height: 15),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showDis = false;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1.5,
                                                        color: !showDis
                                                            ? Colors.red
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            screenSize.width *
                                                                0.1),
                                                    child: Center(
                                                      child: Text(
                                                        "Specification",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showDis = true;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1.5,
                                                        color: showDis
                                                            ? Colors.red
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: screenSize.width *
                                                            0.1),
                                                    child: Center(
                                                      child: Text(
                                                        "Description",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decorationColor:
                                                              showDis
                                                                  ? Colors
                                                                      .red[900]
                                                                  : Colors.grey[
                                                                      900],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  showDis
                                      ? Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: screenSize.width,
                                              height: screenSize.height * 0.15,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Text(
                                                  product['desc'],
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          flex: 4,
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Make",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          make.toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Model",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          model,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Brand",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          product['brand'],
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Item Code",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          product['itemCode']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Oem Code",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          product['oemCode']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Pieces",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          product['piecesInBox']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Volt",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          product['volt']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Container(
                                                    width: screenSize.width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Catalog",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        GestureDetector(
                                                            onTap: () =>
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            ReadPDF(
                                                                              product['pdfUrl'],
                                                                              product['name'],
                                                                            ))),
                                                            child: Icon(
                                                              Icons
                                                                  .picture_as_pdf,
                                                              color: Colors
                                                                  .grey[900],
                                                              size: 22,
                                                            )),
                                                      ],
                                                    )),
                                                Container(
                                                  width: screenSize.width,
                                                  height: 60,
                                                  child: BarcodeWidget(
                                                    data: product['barCode']
                                                        .toString(),
                                                    barcode: Barcode.code128(
                                                        escapes: true),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (quantity != 1) {
                                        setState(() {
                                          quantity = quantity - 1;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.red[900], // <-- Splash color
                                    ),
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(color: Colors.red[900]),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity = 1 + quantity;
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.red[900], // <-- Splash color
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[900])),
                                    onPressed: () {
                                      if (1 <= product['quantity']) {
                                        FirebaseFirestore.instance
                                          ..collection("users")
                                              .doc(uid)
                                              .collection('cart')
                                              .doc(product['productId'])
                                              .set({
                                            'img': product['images'][0],
                                            'name': product['name'],
                                            'nameK': product['nameK'],
                                            'nameA': product['nameA'],
                                            'price': role == 0
                                                ? product['retail price']
                                                : product['wholesale price'],
                                            'productId': product['productId'],
                                            'quantity': quantity,
                                            'subPrice': role == 0
                                                ? product['retail price'] *
                                                    quantity
                                                : product['wholesale price'] *
                                                    quantity,
                                          }).whenComplete(() {
                                            Navigator.pop(context, 'Cancel');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                ' Product has added to your cart ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              backgroundColor: Colors.red[900],
                                              duration: Duration(seconds: 3),
                                            ));
                                          });
                                      } else {
                                        Navigator.pop(context, 'Cancel');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            ' Quantity  not available ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          backgroundColor: Colors.red[900],
                                          duration: Duration(seconds: 3),
                                        ));
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.9,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: Row(
                                        children: [
                                          Text(
                                            product['name'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          role == 0
                                              ? Text("       " +
                                                  product['retail price']
                                                      .toString() +
                                                  " \$")
                                              : Text(product['wholesale price']
                                                  .toString()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ReadPDF(
                                                      product['pdfUrl'],
                                                      product['name'],
                                                    ))),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Download Catalog  ",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Icon(
                                              Icons
                                                  .download_for_offline_rounded,
                                              color: Colors.red[900],
                                              size: 22,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red[900],
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: screenSize.width * 0.55,
                              height: screenSize.height * 0.8,
                              child: Column(
                                children: [
                                  images.isEmpty
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
                                                        margin:
                                                            EdgeInsets.all(5.0),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Image.network(
                                                                    item,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: screenSize
                                                                            .height *
                                                                        0.35,
                                                                    width: screenSize
                                                                            .width *
                                                                        0.25),
                                                                Positioned(
                                                                  bottom: 0.0,
                                                                  left: 0.0,
                                                                  right: 0.0,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color.fromARGB(
                                                                              100,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          Color.fromARGB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0)
                                                                        ],
                                                                        begin: Alignment
                                                                            .bottomCenter,
                                                                        end: Alignment
                                                                            .topCenter,
                                                                      ),
                                                                    ),
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.0,
                                                                        horizontal:
                                                                            20.0),
                                                                    child: Text(
                                                                      'No. ${images.indexOf(item) + 1}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.0,
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
                                  Divider(height: 15),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              width: screenSize.width * 0.1,
                                              child: ListTile(
                                                trailing: Text(
                                                  make.toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                title: Text(
                                                  "Make",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Divider(),
                                          Container(
                                              width: screenSize.width * 0.1,
                                              child: ListTile(
                                                title: Text(
                                                  "Model",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: Text(
                                                  model,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                          Divider(),
                                          Container(
                                              width: screenSize.width * 0.1,
                                              child: ListTile(
                                                title: Text(
                                                  "Brand",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: Text(
                                                  product['brand'],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                          Container(
                                            height: screenSize.height * 0.05,
                                            width: screenSize.width * 0.075,
                                            child: BarcodeWidget(
                                              data:
                                                  product['barCode'].toString(),
                                              barcode: Barcode.code128(
                                                  escapes: true),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              width: screenSize.width * 0.1,
                                              child: ListTile(
                                                trailing: Text(
                                                  product['itemCode']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                title: Text(
                                                  "Item Code",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Divider(),
                                          Container(
                                              width: screenSize.width * 0.1,
                                              child: ListTile(
                                                title: Text(
                                                  "Oem Code",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: Text(
                                                  product['oemCode'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                          Divider(),
                                          Container(
                                              width: screenSize.width * 0.1,
                                              child: ListTile(
                                                title: Text(
                                                  "Pieces",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: Text(
                                                  product['piecesInBox']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                          Divider(),
                                          Container(
                                              width: screenSize.width * 0.1,
                                              child: ListTile(
                                                title: Text(
                                                  "Volt",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: Text(
                                                  product['volt'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: ListTile(
                                        title: Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: screenSize.width * 0.45,
                                            height: screenSize.height * 0.15,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Text(
                                                product['desc'],
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (quantity != 1) {
                                        setState(() {
                                          quantity = quantity - 1;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.red[900], // <-- Splash color
                                    ),
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(color: Colors.red[900]),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity = 1 + quantity;
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.red[900], // <-- Splash color
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[900])),
                                    onPressed: () {
                                      if (1 <= product['quantity']) {
                                        FirebaseFirestore.instance
                                          ..collection("users")
                                              .doc(uid)
                                              .collection('cart')
                                              .doc(product['productId'])
                                              .set({
                                            'img': product['images'][0],
                                            'name': product['name'],
                                            'nameK': product['nameK'],
                                            'nameA': product['nameA'],
                                            'price': role == 0
                                                ? product['retail price']
                                                : product['wholesale price'],
                                            'productId': product['productId'],
                                            'quantity': quantity,
                                            'subPrice': role == 0
                                                ? product['retail price'] *
                                                    quantity
                                                : product['wholesale price'] *
                                                    quantity,
                                          }).whenComplete(() {
                                            Navigator.pop(context, 'Cancel');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                ' Product has added to your cart ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              backgroundColor: Colors.red[900],
                                              duration: Duration(seconds: 3),
                                            ));
                                          });
                                      } else {
                                        Navigator.pop(context, 'Cancel');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            ' Quantity  not available ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          backgroundColor: Colors.red[900],
                                          duration: Duration(seconds: 3),
                                        ));
                                      }
                                    },
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
