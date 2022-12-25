import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/pdfread.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/filtering.dart';
import 'package:explore/web/widgets/responsive.dart';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class ResponsiveSales extends StatefulWidget {
  const ResponsiveSales({Key? key}) : super(key: key);

  @override
  State<ResponsiveSales> createState() => _ResponsiveSalesState();
}

class _ResponsiveSalesState extends State<ResponsiveSales> {
  String category = '';
  String make = '';
  String model = '';

  List<Map> makes = [];
  List<Map> categories = [];
  List<Map> models = [];

  List images = [];

  bool showDis = false;

  List<Map> products = [];

  getProduct(int index, String sel) {
    FirebaseFirestore.instance.collection('products').get().then((value) {
      if (products.isNotEmpty) {
        products = [];
      }
      value.docs.forEach((element) async {
        setState(() {
          products.add({
            "barCode": element.data()['barCode'],
            'brand': element.data()['brand'],
            "categoryID": element.data()['categoryID'],
            'cost price': element.data()['cost price'],
            "desc": element.data()['desc'],
            'descA': element.data()['descA'],
            "descK": element.data()['descK'],
            'images': element.data()['images'],
            "img": element.data()['img'],
            'modelId': element.data()['modelId'],
            "makeId": element.data()['makeId'],
            'name': element.data()['name'],
            'nameA': element.data()['nameA'],
            "nameK": element.data()['nameK'],
            'oemCode': element.data()['oemCode'],
            'itemCode': element.data()['itemCode'],
            'piecesInBox': element.data()['piecesInBox'],
            'pdfUrl': element.data()['pdfUrl'],
            "quantity": element.data()['quantity'],
            'old price': element.data()['old price'],
            'retail price': element.data()['retail price'],
            "volt": element.data()['volt'],
            'wholesale price': element.data()['wholesale price'],
            'productId': element.id
          });
        });
      });
    }).whenComplete(() {
      if (make == makes[index]['id'] && sel == 'make') {
        setState(() {
          make = "";
        });
      } else if (sel == 'make') {
        setState(() {
          make = makes[index]['id'];

          products.removeWhere((element) => element['makeId'] != make);
          products = products;
        });
      } else if (make != '') {
        setState(() {
          products.removeWhere((element) => element['makeId'] != make);
          products = products;
        });
      }

      if (model == models[index]['id'] && sel == 'model') {
        setState(() {
          model = "";
        });
      } else if (sel == 'model') {
        setState(() {
          model = models[index]['id'];

          products.removeWhere((element) => element['modelId'] != model);
          products = products;
        });
      } else if (model != '') {
        setState(() {
          products.removeWhere((element) => element['modelId'] != model);
          products = products;
        });
      }

      if (category == categories[index]["id"] && sel == 'cat') {
        setState(() {
          category = "";
        });
      } else if (sel == 'cat') {
        setState(() {
          category = categories[index]["id"];

          products.removeWhere((element) => element['categoryID'] != category);
          products = products;
        });
      } else if (category != '') {
        setState(() {
          products.removeWhere((element) => element['categoryID'] != category);
          products = products;
        });
      }
    });
  }

  getData() {
    FirebaseFirestore.instance.collection('make').get().then((value) {
      value.docs.forEach((element) async {
        makes.add({
          "name": element.data()['make'],
          'img': element.data()['img'],
          'id': element.id
        });
      });
    }).whenComplete(() {
      setState(() {
        makes = makes;
      });
    });

    FirebaseFirestore.instance.collection('categories').get().then((value) {
      value.docs.forEach((element) async {
        categories.add({
          "name": element.data()['name'],
          'img': element.data()['img'],
          'id': element.id
        });
      });
    }).whenComplete(() {
      setState(() {
        categories = categories;
      });
    });
  }

  @override
  void initState() {
    getData();
    getProduct(0, 'all');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: FilteringDrawer(),
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor: Colors.red[900],
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.close),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/sunpower2.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: Container(),
            ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.white,
        padding: EdgeInsets.all(0),
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                child: Container(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: products.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: ((context, index) {
                          return Container(
                            height: screenSize.height * 0.2,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          child: Container(
                                        child: Image.network(
                                            products[index]['images'][0],
                                            fit: BoxFit.cover),
                                      )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: screenSize.height * 0.1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle:
                                                    StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                    text: products[index]
                                                            ['name']
                                                        .toString()),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text(
                                                    products[index]
                                                                ['retail price']
                                                            .toString() +
                                                        " \$",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    String make = '';
                                                    String model = '';
                                                    int quantity = 1;

                                                    setState(() {
                                                      images = products[index]
                                                          ['images'];
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection('make')
                                                        .doc(products[index]
                                                            ['makeId'])
                                                        .get()
                                                        .then((value) {
                                                      make = value.get("make");

                                                      FirebaseFirestore.instance
                                                          .collection('make')
                                                          .doc(products[index]
                                                              ['makeId'])
                                                          .collection('models')
                                                          .doc(products[index]
                                                              ['modelId'])
                                                          .get()
                                                          .then((value) {
                                                        model =
                                                            value.get("mname");
                                                      }).whenComplete(() {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return Container(
                                                                width:
                                                                    screenSize
                                                                        .width,
                                                                height:
                                                                    screenSize
                                                                        .height,
                                                                child:
                                                                    AlertDialog(
                                                                  title:
                                                                      Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              9,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Flexible(
                                                                                child: RichText(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  strutStyle: StrutStyle(fontSize: 12.0),
                                                                                  text: TextSpan(
                                                                                      style: TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontSize: 12,
                                                                                      ),
                                                                                      text: products[index]['name'].toString()),
                                                                                ),
                                                                              ),
                                                                              FittedBox(
                                                                                fit: BoxFit.cover,
                                                                                child: true
                                                                                    ? Text(
                                                                                        "       " + products[index]['retail price'].toString() + " \$",
                                                                                        style: TextStyle(fontSize: 12),
                                                                                      )
                                                                                    : Text(
                                                                                        products[index]['wholesale price'].toString(),
                                                                                        style: TextStyle(fontSize: 12),
                                                                                      ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                                                            onPressed: () =>
                                                                                Navigator.pop(context, 'Cancel'),
                                                                            child:
                                                                                Icon(
                                                                              Icons.close,
                                                                              color: Colors.red[900],
                                                                              size: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  content:
                                                                      Container(
                                                                    width: screenSize
                                                                        .width,
                                                                    height: screenSize
                                                                        .height,
                                                                    child:
                                                                        Column(
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
                                                                                              margin: EdgeInsets.all(5.0),
                                                                                              child: ClipRRect(
                                                                                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                                                                  child: Stack(
                                                                                                    children: <Widget>[
                                                                                                      Image.network(item, fit: BoxFit.cover, width: screenSize.width * 0.80),
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
                                                                                                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                                                                        Divider(
                                                                            height:
                                                                                15),
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        showDis = false;
                                                                                      });
                                                                                    },
                                                                                    child: Expanded(
                                                                                      flex: 1,
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border(
                                                                                            bottom: BorderSide(
                                                                                              width: 1.5,
                                                                                              color: !showDis ? Colors.red : Colors.grey,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.only(right: screenSize.width * 0.1),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              "Specification",
                                                                                              style: TextStyle(
                                                                                                fontSize: 12,
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        showDis = true;
                                                                                      });
                                                                                    },
                                                                                    child: Expanded(
                                                                                      flex: 1,
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border(
                                                                                            bottom: BorderSide(
                                                                                              width: 1.5,
                                                                                              color: showDis ? Colors.red : Colors.grey,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.only(left: screenSize.width * 0.1),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              "Description",
                                                                                              style: TextStyle(
                                                                                                fontSize: 12,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                decorationColor: showDis ? Colors.red[900] : Colors.grey[900],
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
                                                                                        products[index]['desc'],
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
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                          width: screenSize.width,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Make",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Model",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Brand",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              Text(
                                                                                                products[index]['brand'],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                      Container(
                                                                                          width: screenSize.width,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Item Code",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              Text(
                                                                                                products[index]['itemCode'].toString(),
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                      Container(
                                                                                          width: screenSize.width,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Oem Code",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              Text(
                                                                                                products[index]['oemCode'].toString(),
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                      Container(
                                                                                          width: screenSize.width,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Pieces",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              Text(
                                                                                                products[index]['piecesInBox'].toString(),
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                      Container(
                                                                                          width: screenSize.width,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Volt",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              Text(
                                                                                                products[index]['volt'].toString(),
                                                                                                style: TextStyle(
                                                                                                  fontSize: 12,
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                      Container(
                                                                                          width: screenSize.width,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                "Catalog",
                                                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              GestureDetector(
                                                                                                  onTap: () => Navigator.push(
                                                                                                      context,
                                                                                                      MaterialPageRoute(
                                                                                                          builder: (context) => ReadPDF(
                                                                                                                products[index]['pdfUrl'],
                                                                                                                products[index]['name'],
                                                                                                              ))),
                                                                                                  child: Icon(
                                                                                                    Icons.picture_as_pdf,
                                                                                                    color: Colors.grey[900],
                                                                                                    size: 22,
                                                                                                  )),
                                                                                            ],
                                                                                          )),
                                                                                      Container(
                                                                                        width: screenSize.width,
                                                                                        height: 60,
                                                                                        child: BarcodeWidget(
                                                                                          data: products[index]['barCode'].toString(),
                                                                                          barcode: Barcode.code128(escapes: true),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        if (quantity !=
                                                                            1) {
                                                                          setState(
                                                                              () {
                                                                            quantity =
                                                                                quantity - 1;
                                                                          });
                                                                        }
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            14,
                                                                      ),
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        shape:
                                                                            CircleBorder(),
                                                                        padding:
                                                                            EdgeInsets.all(20),
                                                                        backgroundColor:
                                                                            Colors.red[900], // <-- Splash color
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      quantity
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red[900]),
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          quantity =
                                                                              1 + quantity;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            14,
                                                                      ),
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        shape:
                                                                            CircleBorder(),
                                                                        padding:
                                                                            EdgeInsets.all(20),
                                                                        backgroundColor:
                                                                            Colors.red[900], // <-- Splash color
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      style: ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(Colors.red[900])),
                                                                      onPressed:
                                                                          () {
                                                                        if (1 <=
                                                                            products[index]['quantity']) {
                                                                          FirebaseFirestore
                                                                              .instance
                                                                            ..collection("users").doc(uid).collection('cart').doc(products[index]['productId']).set({
                                                                              'img': products[index]['images'][0],
                                                                              'name': products[index]['name'],
                                                                              'nameK': products[index]['nameK'],
                                                                              'nameA': products[index]['nameA'],
                                                                              'price': true ? products[index]['retail price'] : products[index]['wholesale price'],
                                                                              'productId': products[index]['productId'],
                                                                              'quantity': quantity,
                                                                              'subPrice': true ? products[index]['retail price'] * quantity : products[index]['wholesale price'],
                                                                            }).whenComplete(() {
                                                                              Navigator.pop(context, 'Cancel');
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                                                          Navigator.pop(
                                                                              context,
                                                                              'Cancel');
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            content:
                                                                                Text(
                                                                              ' Quantity  not available ',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 17,
                                                                              ),
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.red[900],
                                                                            duration:
                                                                                Duration(seconds: 3),
                                                                          ));
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          "Add to Cart",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          },
                                                        );
                                                      });
                                                    });
                                                  },
                                                  child: Card(
                                                    color: Colors.red[900],
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        child: FittedBox(
                                                          fit: BoxFit.cover,
                                                          child: Text(
                                                            "Buy",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
