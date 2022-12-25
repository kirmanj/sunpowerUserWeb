import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/main.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';

import 'auth_dialog.dart';

class ExploreDrawer extends StatefulWidget {
  ScrollController _scrollController;

  ExploreDrawer(this._scrollController);

  @override
  _ExploreDrawerState createState() =>
      _ExploreDrawerState(this._scrollController);
}

class _ExploreDrawerState extends State<ExploreDrawer> {
  ScrollController _scrollController;
  _ExploreDrawerState(this._scrollController);

  int subTotal = 0;
  int deliveryFee = 0;
  int exchangeRate = 0;
  getInfo() {
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

    FirebaseFirestore.instance
      ..collection("users").doc(uid).collection('cart').get().then((value) {
        value.docs.forEach(((element) {
          subTotal = subTotal + int.parse(element['subPrice'].toString());
        }));
      }).whenComplete(() {
        setState(() {
          subTotal = subTotal;
        });
      });
  }

  bool select = true;

  @override
  void initState() {
    getInfo();
    // TODO: implement initState
    super.initState();
  }

  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userEmail == null
                  ? Container(
                      width: double.maxFinite,
                      child: TextButton(
                        // color: Colors.black,
                        // hoverColor: Colors.blueGrey[800],
                        // highlightColor: Colors.blueGrey[700],
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AuthDialog(),
                          );
                        },
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(15),
                        // ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl!) : null,
                          child: imageUrl == null
                              ? Icon(
                                  Icons.account_circle,
                                  size: 40,
                                )
                              : Container(),
                        ),
                        SizedBox(width: 10),
                        Text(
                          name ?? userEmail!,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
              SizedBox(height: 20),
              uid != null
                  ? Container(
                      width: double.maxFinite,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
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
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                }).catchError((error) {
                                  print('Sign Out Error: $error');
                                });
                                setState(() {
                                  _isProcessing = false;
                                });
                              },
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(15),
                        // ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: _isProcessing
                              ? CircularProgressIndicator()
                              : Text(
                                  'Sign out',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    )
                  : Container(),
              userEmail != null ? SizedBox(height: 20) : Container(),
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    _scrollController.animateTo(screenSize.height * 1.5,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Services',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    _scrollController.animateTo(screenSize.height * 1.9,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    _scrollController.animateTo(screenSize.height * 2.5,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Brands',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  if (uid == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AuthDialog(),
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
                          userName = value.get("name");
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
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Deliver to: ",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                phoneNo.isNotEmpty
                                                    ? phoneNo
                                                    : email,
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Location: " + address,
                                                style: TextStyle(fontSize: 12),
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
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(uid)
                                                    .collection('cart')
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                        width: ResponsiveWidget
                                                                .isSmallScreen(
                                                                    context)
                                                            ? screenSize.width *
                                                                0.95
                                                            : screenSize.width *
                                                                0.7,
                                                        height:
                                                            screenSize.height *
                                                                0.7,
                                                        child: ListView.builder(
                                                            itemCount: snapshot
                                                                .data
                                                                .docs
                                                                .length,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemBuilder:
                                                                ((context,
                                                                    index) {
                                                              return Card(
                                                                color: Colors
                                                                    .white,
                                                                child:
                                                                    Container(
                                                                  width: ResponsiveWidget
                                                                          .isSmallScreen(
                                                                              context)
                                                                      ? screenSize
                                                                              .width *
                                                                          0.6
                                                                      : screenSize
                                                                              .width *
                                                                          0.5,
                                                                  height: ResponsiveWidget
                                                                          .isSmallScreen(
                                                                              context)
                                                                      ? screenSize
                                                                              .height *
                                                                          0.2
                                                                      : screenSize
                                                                              .height *
                                                                          0.1,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 6,
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
                                                                              flex: 4,
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
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
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
                                                                                            "subPrice": FieldValue.increment(-int.parse(snapshot.data.docs[index].data()['price'].toString()))
                                                                                          });
                                                                                          setState(() {
                                                                                            subTotal -= int.parse(snapshot.data.docs[index].data()['price'].toString());
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
                                                                                        "subPrice": FieldValue.increment(int.parse(snapshot.data.docs[index].data()['price'].toString()))
                                                                                      });
                                                                                      setState(() {
                                                                                        subTotal += int.parse(snapshot.data.docs[index].data()['price'].toString());
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
                                                                ),
                                                              );
                                                            })));
                                                  } else {
                                                    return Container(
                                                        child: Center(
                                                      child: Text("No data"),
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
                                                          'Sub Total',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        Text(
                                                          subTotal.toString(),
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Dilivery Fee',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          deliveryFee
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Total',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 14),
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
                                                              fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Exchange Rate',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          exchangeRate
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
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
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () {
                                          List productsOrder = [];
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(uid)
                                              .collection("cart")
                                              .get()
                                              .then((value) {
                                            value.docs.forEach((element) {
                                              productsOrder.add({
                                                "img": element["img"],
                                                "price": element['price'],
                                                'quantity': element['quantity'],
                                                'name': element['name']
                                              });
                                            });
                                          }).whenComplete(() {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(uid)
                                                .collection("orders")
                                                .doc()
                                                .set({
                                              "OrderStatus": "Pending",
                                              "deliveryFee": deliveryFee,
                                              "dinnar": exchangeRate / 100,
                                              "subTotal": (subTotal),
                                              "totalPrice": (subTotal *
                                                  exchangeRate /
                                                  100),
                                              "userAddress": address,
                                              "userID": uid,
                                              "userName": userName,
                                              "userPhone": "7505448229",
                                              "productList": productsOrder
                                            });
                                          }).whenComplete(() {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(uid)
                                                .collection("cart")
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(uid)
                                                    .collection("cart")
                                                    .doc(element.id)
                                                    .delete();
                                              });
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      HomePage(),
                                                ),
                                              );
                                            });
                                          });
                                        },
                                        child: Text(
                                          "Send Order",
                                          style:
                                              TextStyle(color: Colors.red[900]),
                                        ),
                                      ),
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
                    );
                  }
                },
                child: Container(
                  height: screenSize.height * 0.05,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          child: Text(
                            'My Cart',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: cartC == null
                            ? Container()
                            : Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    cartC.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  if (uid == null) {
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
                                                MainAxisAlignment.spaceAround,
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
                                                        EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.cover,
                                                        child: Text(
                                                          "Current",
                                                          style: TextStyle(
                                                            color: select
                                                                ? Colors
                                                                    .red[900]
                                                                : Colors.white,
                                                          ),
                                                        ),
                                                      ),
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
                                                        EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.cover,
                                                        child: Text(
                                                          "History",
                                                          style: TextStyle(
                                                              color: select
                                                                  ? Colors.white
                                                                  : Colors.red[
                                                                      900]),
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
                                      width: ResponsiveWidget.isSmallScreen(
                                              context)
                                          ? screenSize.width * 0.95
                                          : screenSize.width * 0.3,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(uid)
                                                    .collection('orders')
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                        width: ResponsiveWidget
                                                                .isSmallScreen(
                                                                    context)
                                                            ? screenSize.width *
                                                                0.95
                                                            : screenSize.width *
                                                                0.7,
                                                        height: ResponsiveWidget
                                                                .isSmallScreen(
                                                                    context)
                                                            ? screenSize.width *
                                                                0.4
                                                            : screenSize
                                                                    .height *
                                                                0.7,
                                                        child: ListView.builder(
                                                            itemCount: snapshot
                                                                .data
                                                                .docs
                                                                .length,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemBuilder:
                                                                ((context,
                                                                    index) {
                                                              return (select &&
                                                                      snapshot.data.docs[index]
                                                                              [
                                                                              'OrderStatus'] !=
                                                                          "Pending")
                                                                  ? Container()
                                                                  : (select &&
                                                                          snapshot.data.docs[index]['OrderStatus'] ==
                                                                              "Pending")
                                                                      ? Card(
                                                                          color:
                                                                              Colors.white,
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
                                                                                                    snapshot.data.docs[index]['OrderStatus'],
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
                                                                                                    "Deliver to: " + snapshot.data.docs[index]['userName'],
                                                                                                    style: TextStyle(fontSize: 12),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Location: " + snapshot.data.docs[index]['userAddress'],
                                                                                                    style: TextStyle(fontSize: 12),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: screenSize.height * 0.005,
                                                                                              ),
                                                                                              Text(
                                                                                                "Items",
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
                                                                                                            text: "Sub Total"),
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
                                                                                                            text: "Delivery Fee"),
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
                                                                                                            text: "Dinnar Exg Rate"),
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
                                                                                                            text: "Total"),
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
                                                                      : Card(
                                                                          color:
                                                                              Colors.white,
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
                                                                                                    snapshot.data.docs[index]['OrderStatus'],
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
                                                                                                    "Deliver to: " + snapshot.data.docs[index]['userName'],
                                                                                                    style: TextStyle(fontSize: 12),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    "Location: " + snapshot.data.docs[index]['userAddress'],
                                                                                                    style: TextStyle(fontSize: 12),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: screenSize.height * 0.005,
                                                                                              ),
                                                                                              Text(
                                                                                                "Items",
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
                                                                                                            text: "Sub Total"),
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
                                                                                                            text: "Delivery Fee"),
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
                                                                                                            text: "Dinnar Exg Rate"),
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
                                                                                                            text: "Total"),
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
                                                                        );
                                                            })));
                                                  } else {
                                                    //<DoretcumentSnapshot> items = snapshot.data;
                                                    return Container(
                                                        child: Text("No data"));
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
                    );
                  }
                },
                child: Column(
                  children: [
                    Text(
                      'Orders',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    _scrollController.animateTo(screenSize.height * 3,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2022 | SUNPOWER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
