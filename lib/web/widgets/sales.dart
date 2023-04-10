import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  String category = '';
  String brand = '';

  List<Map> brands = [];
  List<Map> categories = [];

  List images = [];

  List<Map> products = [];

  launchWhatsAppUri(String name, String price) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+964-(750)5448229',
      text: "Hello HL SUNGLASS \n I Want this Sunglass \n Product Name: " +
          name +
          "\n Price: " +
          price,
    );

    await launchUrl(link.asUri());
  }

  getProduct(int index, String sel) {
    FirebaseFirestore.instance.collection('products').get().then((value) {
      if (products.isNotEmpty) {
        products = [];
      }
      value.docs.forEach((element) async {
        setState(() {
          products.add({
            'brand': element.data()['BrandID'],
            "categoryID": element.data()['categoryID'],
            'NewArrivals': element.data()['NewArrivals'],
            "desc": element.data()['description'],
            'Time': element.data()['Time'],
            "descK": element.data()['descK'],
            'images': element.data()['images'],
            "img": element.data()['img'],
            "brandId": element.data()['BrandID'],
            'name': element.data()['name'],
            'nameA': element.data()['nameA'],
            "nameK": element.data()['nameK'],
            'price': element.data()['price'],
            'sub_categoryID': element.data()['sub_categoryID'],
            'productId': element.id
          });
        });
      });
    }).whenComplete(() {
      if (brand == brands[index]['id'] && sel == 'brand') {
        setState(() {
          brand = "";
        });
      } else if (sel == 'brand') {
        setState(() {
          brand = brands[index]['id'];

          products.removeWhere((element) => element['brandId'] != brand);
          products = products;
        });
      } else if (brand != '') {
        setState(() {
          products.removeWhere((element) => element['brandId'] != brand);
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
    FirebaseFirestore.instance.collection('Brands').get().then((value) {
      value.docs.forEach((element) async {
        brands.add({
          "name": element.data()['name'],
          'img': element.data()['img'],
          'id': element.id
        });
      });
    }).whenComplete(() {
      setState(() {
        brands = brands;
        print(brands.length);
      });
    });

    FirebaseFirestore.instance.collection('categories').get().then((value) {
      value.docs.forEach((element) async {
        categories.add({
          "name": element.data()['name'],
          "nameA": element.data()['nameA'],
          "nameK": element.data()['nameK'],
          'img': element.data()['img'],
          'id': element.id
        });
      });
    }).whenComplete(() {
      setState(() {
        categories = categories;
        print(categories.length);
      });
      getProduct(0, 'all');
    });
  }

  @override
  void initState() {
    getData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Container(
                width: screenSize.width * 0.2,
                child: Container(
                  child: Center(
                    child: Text("HL SUNGLASS"),
                  ),
                ))),
        backgroundColor: Color(0xFF35ddde),
        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            }),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          color: Colors.white,
          padding: EdgeInsets.all(0),
          child: Center(
            child: Row(
              children: [
                Container(
                  width: screenSize.width * 0.22,
                  height: screenSize.height * 0.95,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF35ddde),
                                  border: Border.all(
                                    color: Color(0xFF35ddde),
                                  )),
                              child: Center(
                                child: Text(
                                  "Filtering".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 9,
                        child: categories.isEmpty || brands.isEmpty
                            ? Container(
                                child: Center(
                                  child: Text("Loading.."),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex: 30,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Color(0xFF35ddde),
                                                )),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        "Categories"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xFF35ddde),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      margin: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: GridView.builder(
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                          ),
                                                          itemCount:
                                                              categories.length,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemBuilder:
                                                              ((context,
                                                                  index) {
                                                            return Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  getProduct(
                                                                      index,
                                                                      'cat');
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: screenSize
                                                                          .width *
                                                                      0.2,
                                                                  height: screenSize
                                                                          .height *
                                                                      0.2,
                                                                  child: Column(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child: Container(
                                                                            width: screenSize.width * 0.1,
                                                                            height: screenSize.height * 0.08,
                                                                            child: Container(
                                                                              child: Image.network(categories[index]['img'], fit: BoxFit.fitWidth),
                                                                            )),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Color(0xFF35ddde),
                                                                              border: Border.all(
                                                                                color: Color(0xFF35ddde),
                                                                              )),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                RichText(
                                                                              textAlign: TextAlign.center,
                                                                              overflow: TextOverflow.visible,
                                                                              strutStyle: StrutStyle(fontSize: 10),
                                                                              text: TextSpan(
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                  text: categories[index]['name'].toString()),
                                                                            ),
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
                                              ],
                                            ),
                                          )),
                                      Expanded(flex: 1, child: Container()),
                                      Expanded(
                                          flex: 30,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Color(0xFF35ddde),
                                                )),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width:
                                                        screenSize.width * 0.05,
                                                    child: Center(
                                                      child: Text(
                                                        "BRANDS".toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xFF35ddde),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      margin: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: GridView.builder(
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                          ),
                                                          itemCount:
                                                              brands.length,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemBuilder:
                                                              ((context,
                                                                  index) {
                                                            return Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  getProduct(
                                                                      index,
                                                                      'brand');
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFF35ddde),
                                                                  ),
                                                                  width: screenSize
                                                                          .width *
                                                                      0.2,
                                                                  height: screenSize
                                                                          .height *
                                                                      0.2,
                                                                  child: Column(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child: Container(
                                                                            width: screenSize.width * 0.1,
                                                                            height: screenSize.height * 0.08,
                                                                            child: Container(
                                                                              child: Image.network(brands[index]['img'], fit: BoxFit.fitWidth),
                                                                            )),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              RichText(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            overflow:
                                                                                TextOverflow.visible,
                                                                            strutStyle:
                                                                                StrutStyle(fontSize: 10),
                                                                            text: TextSpan(
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 14,
                                                                                ),
                                                                                text: brands[index]['name'].toString().toUpperCase()),
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
                                              ],
                                            ),
                                          )),
                                      Expanded(flex: 1, child: Container()),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenSize.width * 0.75,
                      height: screenSize.height * 0.95,
                      child: Container(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                              ),
                              itemCount: products.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: ((context, index) {
                                return Container(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFF35ddde),
                                        border: Border.all(
                                          color: Color(0xFF35ddde),
                                        )),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            color: Colors.white,
                                            width: screenSize.width * 0.2,
                                            child: Image.network(
                                              products[index]["img"][0],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenSize.width * 0.2,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF35ddde),
                                              border: Border.all(
                                                color: Color(0xFF35ddde),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    color: Color(0xFF35ddde),
                                                    child: Text(
                                                      products[index]['name']
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    color: Color(0xFF35ddde),
                                                    child: Text(
                                                      (products[index]['price']
                                                                  .toString() +
                                                              " IQD")
                                                          .replaceAllMapped(
                                                              RegExp(
                                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                              (Match m) =>
                                                                  '${m[1]},'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        launchWhatsAppUri(
                                                            products[index]
                                                                ['name'],
                                                            (products[index][
                                                                            'price']
                                                                        .toString() +
                                                                    " IQD")
                                                                .replaceAllMapped(
                                                                    RegExp(
                                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                    (Match m) =>
                                                                        '${m[1]},'));
                                                      },
                                                      icon: Icon(
                                                        Icons.ios_share_rounded,
                                                        color: Colors.white,
                                                        size: 18,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                              }))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
