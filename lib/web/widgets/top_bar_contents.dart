import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/localization/AppLocal.dart';
import 'package:explore/main.dart';
import 'package:explore/services/local_storage_service.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/auth_dialog.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/searchSale.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  final ScrollController _scrollController;

  TopBarContents(this.opacity, this._scrollController);

  @override
  _TopBarContentsState createState() =>
      _TopBarContentsState(this.opacity, this._scrollController);
}

List products = [];
List<String> itemCodeL = [];

List<String> barcodeL = [];
List<int> indexs = [];
List<String> searchTerm = [];

class _TopBarContentsState extends State<TopBarContents> {
  double opacity;
  double subTotal = 0;
  double deliveryFee = 0;
  double exchangeRate = 0;

  bool select = true;

  _TopBarContentsState(this.opacity, this._scrollController);

  ScrollController _scrollController;

  final FocusNode _focusNode = FocusNode();
  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _scrollController.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          print(offset);
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

  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  bool _isProcessing = false;

  getInfo() {
    print(subTotal);
    print(subTotal);
    if (uid!.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('cart')
          .get()
          .then((value) {
        print(subTotal);
        value.docs.forEach(((element) {
          print(subTotal);
          print(element);
          subTotal = subTotal + double.parse(element['subPrice'].toString());
          print(subTotal);
        }));
      }).whenComplete(() {
        setState(() {
          subTotal = subTotal;
        });
        print(subTotal);
      });
    }
    FirebaseFirestore.instance
        .collection('Admin')
        .doc("admindoc")
        .get()
        .then((value) {
      setState(() {
        deliveryFee = value.data()?['deliveryfee'];
        exchangeRate = value.data()?['dinnar'] * 100;
      });
    });
  }

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
                'Price': element['retail price'],
                'itemCode': element['itemCode'],
                'barCode': element['barCode'],
                'id': element.id
              });
              itemCodeL.add(element['itemCode']);
              barcodeL.add(element['barCode']);
              indexs.add(i);

              searchTerm.add(element['name']);
            });
            i++;
          })
        });
  }

  @override
  void initState() {
    getProduts();
    getInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return RawKeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKey: _handleKeyEvent,
      child: Container(
        decoration: BoxDecoration(
          image: widget.opacity > 0.6
              ? DecorationImage(
                  image: AssetImage("assets/images/color.jpg"),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.12,
                child: Image.asset(
                  widget.opacity > 0.6
                      ? 'assets/images/sunpower2.png'
                      : 'assets/images/sunpower.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: screenSize.width * 0.72,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[0] = true
                                : _isHovering[0] = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _scrollController.animateTo(screenSize.height * 0.9,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).trans("services"),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[0],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[1] = true
                                : _isHovering[1] = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _scrollController.animateTo(
                                screenSize.height * 1.45,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).trans("products"),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[1],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[2] = true
                                : _isHovering[2] = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _scrollController.animateTo(screenSize.height * 2.1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).trans("Brands"),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[2],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[3] = true
                                : _isHovering[3] = false;
                          });
                        },
                        onTap: () {
                          if (uid!.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AuthDialog(),
                            );
                          } else if (cartC == 0 && uid!.isNotEmpty) {
                            var okButton = TextButton(
                              child: Text(
                                AppLocalizations.of(context).trans("ok"),
                                style: TextStyle(color: Colors.red[900]),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              content: Text(
                                  AppLocalizations.of(context).trans("Empty")),
                              actions: [
                                okButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          } else {
                            String phoneNo = "",
                                email = "",
                                address = "",
                                userName = "";
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .get()
                                .then(
                              (value) {
                                setState(() {
                                  phoneNo = value.get("phone");
                                  email = value.get("email");
                                  userName = value.get("username");
                                  address = value.get("address");
                                  print(phoneNo + email + address);
                                });
                              },
                            ).whenComplete(
                              () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return Container(
                                          child: AlertDialog(
                                            title: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Your Cart",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .trans('Deliverto'),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        phoneNo.isNotEmpty
                                                            ? phoneNo
                                                            : email,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                    context)
                                                                .trans(
                                                                    'address') +
                                                            address,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              width: screenSize.width * 0.3,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "users")
                                                                .doc(uid)
                                                                .collection(
                                                                    'cart')
                                                                .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Container(
                                                                width: ResponsiveWidget
                                                                        .isSmallScreen(
                                                                            context)
                                                                    ? screenSize
                                                                            .width *
                                                                        0.95
                                                                    : screenSize
                                                                            .width *
                                                                        0.7,
                                                                height: screenSize
                                                                        .height *
                                                                    0.7,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: snapshot
                                                                            .data
                                                                            .docs
                                                                            .length,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .vertical,
                                                                        itemBuilder:
                                                                            ((context,
                                                                                index) {
                                                                          return Container(
                                                                            width: ResponsiveWidget.isSmallScreen(context)
                                                                                ? screenSize.width * 0.6
                                                                                : screenSize.width * 0.5,
                                                                            height: ResponsiveWidget.isSmallScreen(context)
                                                                                ? screenSize.height * 0.2
                                                                                : screenSize.height * 0.1,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Card(
                                                                                    elevation: snapshot.data.docs.length,
                                                                                    color: Colors.white,
                                                                                    child: Container(
                                                                                        width: ResponsiveWidget.isSmallScreen(context) ? screenSize.width * 0.6 : screenSize.width * 0.075,
                                                                                        height: ResponsiveWidget.isSmallScreen(context) ? screenSize.height * 0.2 : screenSize.height * 0.1,
                                                                                        child: Container(
                                                                                          child: Image.network(snapshot.data.docs[index].data()['img'], fit: BoxFit.cover),
                                                                                        )),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                snapshot.data.docs[index].data()['name'],
                                                                                                textAlign: TextAlign.left,
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                snapshot.data.docs[index].data()['subPrice'].toString() + " \$",
                                                                                                textAlign: TextAlign.left,
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                setState(() {
                                                                                                  if (snapshot.data.docs[index].data()['quantity'] == 1) {
                                                                                                    showDialog<String>(
                                                                                                      context: context,
                                                                                                      builder: (BuildContext context) => AlertDialog(
                                                                                                        title: const Text('Warning'),
                                                                                                        content: const Text('Do you want to remove this item?'),
                                                                                                        actions: <Widget>[
                                                                                                          TextButton(
                                                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                                                                                            onPressed: () {
                                                                                                              FirebaseFirestore.instance.collection("users").doc(uid).collection("cart").doc(snapshot.data.docs[index].id).delete();
                                                                                                              Navigator.pop(context, 'Yes');
                                                                                                            },
                                                                                                            child: Icon(
                                                                                                              Icons.done,
                                                                                                              color: Colors.red[900],
                                                                                                              size: 14,
                                                                                                            ),
                                                                                                          ),
                                                                                                          TextButton(
                                                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red[900])),
                                                                                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                                            child: Icon(
                                                                                                              Icons.close,
                                                                                                              color: Colors.white,
                                                                                                              size: 14,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    );
                                                                                                  } else {
                                                                                                    FirebaseFirestore.instance.collection("users").doc(uid).collection("cart").doc(snapshot.data.docs[index].id).update({
                                                                                                      "quantity": FieldValue.increment(-1),
                                                                                                      "subPrice": FieldValue.increment(-double.parse(snapshot.data.docs[index].data()['price'].toString()))
                                                                                                    });
                                                                                                    setState(() {
                                                                                                      subTotal -= double.parse(snapshot.data.docs[index].data()['price'].toString());
                                                                                                    });
                                                                                                  }
                                                                                                });
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.remove,
                                                                                                color: Colors.white,
                                                                                                size: 12,
                                                                                              ),
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                shape: CircleBorder(),
                                                                                                padding: EdgeInsets.all(2),
                                                                                                backgroundColor: Colors.red[900], // <-- Splash color
                                                                                              ),
                                                                                            ),
                                                                                            RichText(
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              strutStyle: StrutStyle(fontSize: 11.0),
                                                                                              text: TextSpan(
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 11,
                                                                                                  ),
                                                                                                  text: snapshot.data.docs[index].data()['quantity'].toString()),
                                                                                            ),
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                FirebaseFirestore.instance.collection("users").doc(uid).collection("cart").doc(snapshot.data.docs[index].id).update({
                                                                                                  "quantity": FieldValue.increment(1),
                                                                                                  "subPrice": FieldValue.increment(double.parse(snapshot.data.docs[index].data()['price'].toString()))
                                                                                                });
                                                                                                setState(() {
                                                                                                  subTotal += double.parse(snapshot.data.docs[index].data()['price'].toString());
                                                                                                });
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.add,
                                                                                                color: Colors.white,
                                                                                                size: 12,
                                                                                              ),
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                shape: CircleBorder(),
                                                                                                padding: EdgeInsets.all(2),
                                                                                                backgroundColor: Colors.red[900], // <-- Splash color
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        })));
                                                          } else {
                                                            return Container(
                                                                child: Center(
                                                              child: Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .trans(
                                                                          'Empty')),
                                                            ));
                                                          }
                                                        }),
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .trans(
                                                                          'subtotal'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Text(
                                                                  subTotal
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .trans(
                                                                          'DeliveryFee'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  deliveryFee
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .trans(
                                                                          'total'),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Text(
                                                                  (subTotal *
                                                                          exchangeRate /
                                                                          100)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize:
                                                                          14),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .trans(
                                                                          'Exchangedrate'),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  exchangeRate
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white)),
                                                onPressed: () {
                                                  List productsOrder = [];
                                                  var uuid = Uuid();
                                                  var date = DateTime.now();
                                                  var orderDate = DateFormat(
                                                          'MM-dd-yyyy, hh:mm a')
                                                      .format(date);
                                                  String orderId = uuid.v1();
                                                  FirebaseFirestore.instance
                                                      .collection("users")
                                                      .doc(uid)
                                                      .collection("cart")
                                                      .get()
                                                      .then((value) {
                                                    value.docs
                                                        .forEach((element) {
                                                      productsOrder.add({
                                                        "img": element["img"],
                                                        "itemCode":
                                                            element["itemCode"],
                                                        "price":
                                                            element['price'],
                                                        'quantity':
                                                            element['quantity'],
                                                        'name': element['name']
                                                      });
                                                    });
                                                  }).whenComplete(() {
                                                    FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(uid)
                                                        .collection("orders")
                                                        .doc(orderId)
                                                        .set({
                                                      "OrderStatus": "Pending",
                                                      'timeStamp': DateTime
                                                              .now()
                                                          .microsecondsSinceEpoch,
                                                      'date': orderDate,
                                                      "deliveryFee":
                                                          deliveryFee,
                                                      "dinnar":
                                                          exchangeRate / 100,
                                                      "subTotal": (subTotal),
                                                      "totalPrice": (subTotal *
                                                          exchangeRate /
                                                          100),
                                                      "userAddress": address,
                                                      "userID": uid,
                                                      "userName": userName,
                                                      "userPhone": phoneNo,
                                                      "orderID": orderId,
                                                      "productList":
                                                          productsOrder
                                                    });
                                                  }).whenComplete(() {
                                                    FirebaseFirestore.instance
                                                        .collection("Admin")
                                                        .doc("admindoc")
                                                        .collection("orders")
                                                        .doc(orderId)
                                                        .set({
                                                      "OrderStatus": "Pending",
                                                      'timeStamp': DateTime
                                                              .now()
                                                          .microsecondsSinceEpoch,
                                                      'date': orderDate,
                                                      "deliveryFee":
                                                          deliveryFee,
                                                      "dinnar":
                                                          exchangeRate / 100,
                                                      "subTotal": (subTotal),
                                                      "totalPrice": (subTotal *
                                                          exchangeRate /
                                                          100),
                                                      "userAddress": address,
                                                      "orderID": orderId,
                                                      "userID": uid,
                                                      "userName": userName,
                                                      "userPhone": phoneNo,
                                                      "productList":
                                                          productsOrder
                                                    });

                                                    FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(uid)
                                                        .collection("cart")
                                                        .get()
                                                        .then((value) {
                                                      value.docs
                                                          .forEach((element) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(uid)
                                                            .collection("cart")
                                                            .doc(element.id)
                                                            .delete();
                                                      });

                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          fullscreenDialog:
                                                              true,
                                                          builder: (context) =>
                                                              HomePage(),
                                                        ),
                                                      );
                                                    });
                                                  });
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .trans('Sendorder'),
                                                  style: TextStyle(
                                                      color: Colors.red[900]),
                                                ),
                                              ),
                                              TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .red[900])),
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    });
                              },
                            );
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .trans("Cart"),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: cartC == null
                                      ? Container()
                                      : Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              cartC.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          decoration: new BoxDecoration(
                                            color: Colors.red[900],
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[3],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[4] = true
                                : _isHovering[4] = false;
                          });
                        },
                        onTap: () {
                          if (uid!.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AuthDialog(),
                            );
                          } else {
                            String phoneNo = "", email = "", address = "";
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .get()
                                .then(
                              (value) {
                                setState(() {
                                  phoneNo = value.get("phone");
                                  email = value.get("email");
                                  address = value.get("address");
                                  print(phoneNo + email + address);
                                });
                              },
                            ).whenComplete(
                              () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return Container(
                                          child: AlertDialog(
                                            title: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState((() {
                                                            select = true;
                                                          }));
                                                        },
                                                        child: Card(
                                                          color: select
                                                              ? Colors.white
                                                              : Colors.red[900],
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Container(
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .trans(
                                                                            "currentorder"),
                                                                    style:
                                                                        TextStyle(
                                                                      color: !select
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(
                                                            () {
                                                              select = false;
                                                            },
                                                          );
                                                        },
                                                        child: Card(
                                                          color: select
                                                              ? Colors.red[900]
                                                              : Colors.white,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Container(
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .cover,
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .trans(
                                                                          "orderHistory"),
                                                                  style:
                                                                      TextStyle(
                                                                    color: select
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            content: Container(
                                              width: screenSize.width * 0.3,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 8,
                                                    child: StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "users")
                                                                .doc(uid)
                                                                .collection(
                                                                    'orders')
                                                                .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return Container(
                                                                width: ResponsiveWidget
                                                                        .isSmallScreen(
                                                                            context)
                                                                    ? screenSize.width *
                                                                        0.95
                                                                    : screenSize
                                                                            .width *
                                                                        0.7,
                                                                height: screenSize
                                                                        .height *
                                                                    0.7,
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: snapshot
                                                                            .data
                                                                            .docs
                                                                            .length,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .vertical,
                                                                        itemBuilder:
                                                                            ((context,
                                                                                index) {
                                                                          return (!select && snapshot.data.docs[index]['OrderStatus'] != "Pending")
                                                                              ? Card(
                                                                                  color: Colors.white,
                                                                                  child: Container(
                                                                                      width: ResponsiveWidget.isSmallScreen(context) ? screenSize.width * 0.95 : screenSize.width * 0.6,
                                                                                      height: screenSize.height * 0.4,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Column(
                                                                                          children: [
                                                                                            Expanded(
                                                                                                flex: 3,
                                                                                                child: Container(
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            snapshot.data.docs[index]['date'],
                                                                                                            style: TextStyle(fontSize: 12),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            AppLocalizations.of(context).trans(snapshot.data.docs[index]['OrderStatus']),
                                                                                                            style: TextStyle(fontSize: 12),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "#" + snapshot.data.docs[index].id.toString().substring(0, 7),
                                                                                                            style: TextStyle(fontSize: 12),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            AppLocalizations.of(context).trans('Deliverto') + snapshot.data.docs[index]['userName'],
                                                                                                            style: TextStyle(fontSize: 12),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            AppLocalizations.of(context).trans('address') + snapshot.data.docs[index]['userAddress'],
                                                                                                            style: TextStyle(fontSize: 12),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: screenSize.height * 0.005,
                                                                                                      ),
                                                                                                      Text(
                                                                                                        AppLocalizations.of(context).trans('items'),
                                                                                                        style: TextStyle(
                                                                                                          fontSize: 12,
                                                                                                          color: Colors.black,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                )),
                                                                                            Expanded(
                                                                                              flex: 4,
                                                                                              child: ListView.builder(
                                                                                                  itemCount: snapshot.data.docs[index]['productList'].length,
                                                                                                  scrollDirection: Axis.vertical,
                                                                                                  itemBuilder: ((context, jindex) {
                                                                                                    return Row(
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                            flex: 3,
                                                                                                            child: RichText(
                                                                                                              textAlign: TextAlign.left,
                                                                                                              overflow: TextOverflow.visible,
                                                                                                              strutStyle: StrutStyle(fontSize: 12),
                                                                                                              text: TextSpan(
                                                                                                                  style: TextStyle(
                                                                                                                    color: Colors.black,
                                                                                                                    fontSize: 12,
                                                                                                                  ),
                                                                                                                  text: (jindex + 1).toString() + ". " + snapshot.data.docs[index]['productList'][jindex]['name'].toString().toLowerCase()),
                                                                                                            )),
                                                                                                        Expanded(
                                                                                                            flex: 1,
                                                                                                            child: RichText(
                                                                                                              textAlign: TextAlign.center,
                                                                                                              overflow: TextOverflow.visible,
                                                                                                              strutStyle: StrutStyle(fontSize: 12),
                                                                                                              text: TextSpan(
                                                                                                                  style: TextStyle(
                                                                                                                    color: Colors.black,
                                                                                                                    fontSize: 12,
                                                                                                                  ),
                                                                                                                  text: snapshot.data.docs[index]['productList'][jindex]['quantity'].toString()),
                                                                                                            )),
                                                                                                        Expanded(
                                                                                                            flex: 2,
                                                                                                            child: RichText(
                                                                                                              textAlign: TextAlign.right,
                                                                                                              overflow: TextOverflow.visible,
                                                                                                              strutStyle: StrutStyle(fontSize: 12),
                                                                                                              text: TextSpan(
                                                                                                                  style: TextStyle(
                                                                                                                    color: Colors.black,
                                                                                                                    fontSize: 12,
                                                                                                                  ),
                                                                                                                  text: snapshot.data.docs[index]['productList'][jindex]['price'].toString() + "\$"),
                                                                                                            )),
                                                                                                      ],
                                                                                                    );
                                                                                                  })),
                                                                                            ),
                                                                                            Expanded(
                                                                                                flex: 4,
                                                                                                child: Container(
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Divider(),
                                                                                                      Row(
                                                                                                        children: [
                                                                                                          Expanded(
                                                                                                              flex: 3,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.left,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.black,
                                                                                                                      fontSize: 12,
                                                                                                                    ),
                                                                                                                    text: AppLocalizations.of(context).trans('subtotal')),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 1,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.center,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.black,
                                                                                                                      fontSize: 12,
                                                                                                                    ),
                                                                                                                    text: ""),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 2,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.right,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.black,
                                                                                                                      fontSize: 12,
                                                                                                                    ),
                                                                                                                    text: snapshot.data.docs[index]['subTotal'].toString() + "\$"),
                                                                                                              )),
                                                                                                        ],
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: 6,
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: [
                                                                                                          Expanded(
                                                                                                              flex: 3,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.left,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 10),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.grey[900],
                                                                                                                      fontSize: 10,
                                                                                                                    ),
                                                                                                                    text: AppLocalizations.of(context).trans('DeliveryFee')),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 1,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.center,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(style: TextStyle(fontSize: 12, color: Colors.grey[900]), text: ""),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 2,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.right,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 10),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.grey[900],
                                                                                                                      fontSize: 10,
                                                                                                                    ),
                                                                                                                    text: snapshot.data.docs[index]['deliveryFee'].toString() + "\$"),
                                                                                                              )),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: [
                                                                                                          Expanded(
                                                                                                              flex: 3,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.left,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 10),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.grey[900],
                                                                                                                      fontSize: 10,
                                                                                                                    ),
                                                                                                                    text: AppLocalizations.of(context).trans('Exchangedrate')),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 1,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.center,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      fontSize: 12,
                                                                                                                    ),
                                                                                                                    text: ""),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 2,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.right,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 10),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.grey[900],
                                                                                                                      fontSize: 10,
                                                                                                                    ),
                                                                                                                    text: snapshot.data.docs[index]['dinnar'].toString() + "\$"),
                                                                                                              )),
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: [
                                                                                                          Expanded(
                                                                                                              flex: 3,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.left,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.black,
                                                                                                                      fontSize: 12,
                                                                                                                    ),
                                                                                                                    text: AppLocalizations.of(context).trans('total')),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 1,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.center,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.black,
                                                                                                                      fontSize: 12,
                                                                                                                    ),
                                                                                                                    text: ""),
                                                                                                              )),
                                                                                                          Expanded(
                                                                                                              flex: 2,
                                                                                                              child: RichText(
                                                                                                                textAlign: TextAlign.right,
                                                                                                                overflow: TextOverflow.visible,
                                                                                                                strutStyle: StrutStyle(fontSize: 12),
                                                                                                                text: TextSpan(
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.black,
                                                                                                                      fontSize: 12,
                                                                                                                    ),
                                                                                                                    text: snapshot.data.docs[index]['totalPrice'].toString() + " IQD"),
                                                                                                              )),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                      )),
                                                                                )
                                                                              : (select && snapshot.data.docs[index]['OrderStatus'] == "Pending")
                                                                                  ? Card(
                                                                                      color: Colors.white,
                                                                                      child: Container(
                                                                                          width: ResponsiveWidget.isSmallScreen(context) ? screenSize.width * 0.95 : screenSize.width * 0.6,
                                                                                          height: screenSize.height * 0.4,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Column(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                    flex: 3,
                                                                                                    child: Container(
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                snapshot.data.docs[index]['date'],
                                                                                                                style: TextStyle(fontSize: 12),
                                                                                                              ),
                                                                                                              Text(
                                                                                                                AppLocalizations.of(context).trans(snapshot.data.docs[index]['OrderStatus']),
                                                                                                                style: TextStyle(fontSize: 12),
                                                                                                              ),
                                                                                                              Text(
                                                                                                                "#" + snapshot.data.docs[index].id.toString().substring(0, 7),
                                                                                                                style: TextStyle(fontSize: 12),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          //    krmanj                                                                AppLocalizations.of(context).locale.languageCode.toString()=='ku'?
                                                                                                          // productListSnapShot[i]['nameK'].toString().toUpperCase():
                                                                                                          // AppLocalizations.of(context).locale.languageCode.toString()=='ar'?
                                                                                                          // productListSnapShot[i]['nameA'].toString().toUpperCase():
                                                                                                          // productListSnapShot[i]['name'].toString().toUpperCase(),
                                                                                                          Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                AppLocalizations.of(context).trans('Deliverto') + snapshot.data.docs[index]['userName'],
                                                                                                                style: TextStyle(fontSize: 12),
                                                                                                              ),
                                                                                                              Text(
                                                                                                                AppLocalizations.of(context).trans('address') + snapshot.data.docs[index]['userAddress'],
                                                                                                                style: TextStyle(fontSize: 12),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: screenSize.height * 0.005,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            AppLocalizations.of(context).trans('items'),
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 12,
                                                                                                              color: Colors.black,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    )),
                                                                                                Expanded(
                                                                                                  flex: 4,
                                                                                                  child: ListView.builder(
                                                                                                      itemCount: snapshot.data.docs[index]['productList'].length,
                                                                                                      scrollDirection: Axis.vertical,
                                                                                                      itemBuilder: ((context, jindex) {
                                                                                                        return Row(
                                                                                                          children: [
                                                                                                            Expanded(
                                                                                                                flex: 3,
                                                                                                                child: RichText(
                                                                                                                  textAlign: TextAlign.left,
                                                                                                                  overflow: TextOverflow.visible,
                                                                                                                  strutStyle: StrutStyle(fontSize: 12),
                                                                                                                  text: TextSpan(
                                                                                                                      style: TextStyle(
                                                                                                                        color: Colors.black,
                                                                                                                        fontSize: 12,
                                                                                                                      ),
                                                                                                                      text: (jindex + 1).toString() + ". " + snapshot.data.docs[index]['productList'][jindex]['name'].toString().toLowerCase()),
                                                                                                                )),
                                                                                                            Expanded(
                                                                                                                flex: 1,
                                                                                                                child: RichText(
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  overflow: TextOverflow.visible,
                                                                                                                  strutStyle: StrutStyle(fontSize: 12),
                                                                                                                  text: TextSpan(
                                                                                                                      style: TextStyle(
                                                                                                                        color: Colors.black,
                                                                                                                        fontSize: 12,
                                                                                                                      ),
                                                                                                                      text: snapshot.data.docs[index]['productList'][jindex]['quantity'].toString()),
                                                                                                                )),
                                                                                                            Expanded(
                                                                                                                flex: 2,
                                                                                                                child: RichText(
                                                                                                                  textAlign: TextAlign.right,
                                                                                                                  overflow: TextOverflow.visible,
                                                                                                                  strutStyle: StrutStyle(fontSize: 12),
                                                                                                                  text: TextSpan(
                                                                                                                      style: TextStyle(
                                                                                                                        color: Colors.black,
                                                                                                                        fontSize: 12,
                                                                                                                      ),
                                                                                                                      text: snapshot.data.docs[index]['productList'][jindex]['price'].toString() + "\$"),
                                                                                                                )),
                                                                                                          ],
                                                                                                        );
                                                                                                      })),
                                                                                                ),
                                                                                                Expanded(
                                                                                                    flex: 4,
                                                                                                    child: Container(
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Divider(),
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                  flex: 3,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.left,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.black,
                                                                                                                          fontSize: 12,
                                                                                                                        ),
                                                                                                                        text: AppLocalizations.of(context).trans('subtotal')),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 1,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.black,
                                                                                                                          fontSize: 12,
                                                                                                                        ),
                                                                                                                        text: ""),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 2,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.right,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.black,
                                                                                                                          fontSize: 12,
                                                                                                                        ),
                                                                                                                        text: snapshot.data.docs[index]['subTotal'].toString() + "\$"),
                                                                                                                  )),
                                                                                                            ],
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 6,
                                                                                                          ),
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                  flex: 3,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.left,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 10),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.grey[900],
                                                                                                                          fontSize: 10,
                                                                                                                        ),
                                                                                                                        text: AppLocalizations.of(context).trans('DeliveryFee')),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 1,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(style: TextStyle(fontSize: 12, color: Colors.grey[900]), text: ""),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 2,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.right,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 10),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.grey[900],
                                                                                                                          fontSize: 10,
                                                                                                                        ),
                                                                                                                        text: snapshot.data.docs[index]['deliveryFee'].toString() + "\$"),
                                                                                                                  )),
                                                                                                            ],
                                                                                                          ),
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                  flex: 3,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.left,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 10),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.grey[900],
                                                                                                                          fontSize: 10,
                                                                                                                        ),
                                                                                                                        text: AppLocalizations.of(context).trans("Exchangedrate")),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 1,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          fontSize: 12,
                                                                                                                        ),
                                                                                                                        text: ""),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 2,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.right,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 10),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.grey[900],
                                                                                                                          fontSize: 10,
                                                                                                                        ),
                                                                                                                        text: snapshot.data.docs[index]['dinnar'].toString() + "\$"),
                                                                                                                  )),
                                                                                                            ],
                                                                                                          ),
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                  flex: 3,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.left,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.black,
                                                                                                                          fontSize: 12,
                                                                                                                        ),
                                                                                                                        text: AppLocalizations.of(context).trans('total')),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 1,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.black,
                                                                                                                          fontSize: 12,
                                                                                                                        ),
                                                                                                                        text: ""),
                                                                                                                  )),
                                                                                                              Expanded(
                                                                                                                  flex: 2,
                                                                                                                  child: RichText(
                                                                                                                    textAlign: TextAlign.right,
                                                                                                                    overflow: TextOverflow.visible,
                                                                                                                    strutStyle: StrutStyle(fontSize: 12),
                                                                                                                    text: TextSpan(
                                                                                                                        style: TextStyle(
                                                                                                                          color: Colors.black,
                                                                                                                          fontSize: 12,
                                                                                                                        ),
                                                                                                                        text: snapshot.data.docs[index]['totalPrice'].toString() + " IQD"),
                                                                                                                  )),
                                                                                                            ],
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    )),
                                                                                              ],
                                                                                            ),
                                                                                          )),
                                                                                    )
                                                                                  : Container();
                                                                        })));
                                                          } else {
                                                            //<DoretcumentSnapshot> items = snapshot.data;
                                                            return Container(
                                                                child: Text(AppLocalizations.of(
                                                                        context)
                                                                    .trans(
                                                                        'Empty')));
                                                          }
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .red[900])),
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    });
                              },
                            );
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).trans("orders"),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[4],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[5] = true
                                : _isHovering[5] = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _scrollController.animateTo(screenSize.height * 3,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).trans("contact_us"),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[5],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenSize.width * 0.15,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        color: Colors.white,
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate());
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.language_sharp),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        color: Colors.white,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return Container(
                                    child: AlertDialog(
                                      title: Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .trans("language"),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      content: Container(
                                        width: screenSize.width * 0.3,
                                        height: screenSize.height * 0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  LocalStorageService.instance
                                                      .languageCode = "ku";
                                                });
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyApp()));
                                              },
                                              child: Container(
                                                child: Card(
                                                    color: Colors.white,
                                                    elevation: 5,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text("Kurdish"),
                                                    )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  LocalStorageService.instance
                                                      .languageCode = "en";
                                                });
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyApp()));
                                              },
                                              child: Container(
                                                child: Card(
                                                    color: Colors.white,
                                                    elevation: 5,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text("English"),
                                                    )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  LocalStorageService.instance
                                                      .languageCode = "ar";
                                                });

                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyApp()));
                                              },
                                              child: Container(
                                                child: Card(
                                                    color: Colors.white,
                                                    elevation: 5,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text("Arabic"),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red[900])),
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[6] = true
                                : _isHovering[6] = false;
                          });
                        },
                        onTap: uid!.isEmpty
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AuthDialog(),
                                );
                              }
                            : null,
                        child: uid!.isEmpty
                            ? Icon(
                                Icons.login_rounded,
                                color: Colors.white,
                              )
                            : Container(
                                child: Row(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      onPressed: _isProcessing
                                          ? null
                                          : () async {
                                              setState(() {
                                                _isProcessing = true;
                                              });
                                              await signOut().then((result) {
                                                print(result);
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    fullscreenDialog: true,
                                                    builder: (context) =>
                                                        HomePage(),
                                                  ),
                                                );
                                              }).catchError((error) {
                                                print('Sign Out Error: $error');
                                              });
                                              setState(() {
                                                _isProcessing = false;
                                              });
                                            },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 15.0,
                                          bottom: 15.0,
                                        ),
                                        child: _isProcessing
                                            ? CircularProgressIndicator()
                                            : Icon(
                                                Icons.logout_outlined,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  //List<String> searchTerm = ["Apple", "Bannana", "Orange", "Milk"];
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
                if (uid!.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AuthDialog(),
                  );
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchSales(
                            productId: products[index]["id"],
                          )));
                }
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
            ),
          );
        });
  }
}
