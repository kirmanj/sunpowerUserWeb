// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:explore/main.dart';
// import 'package:explore/web/screens/home_page.dart';
// import 'package:explore/web/utils/authentication.dart';
// import 'package:explore/web/widgets/responsive.dart';
// import 'package:flutter/material.dart';

// import 'auth_dialog.dart';

// class FilteringDrawer extends StatefulWidget {
//   @override
//   _FilteringDrawerState createState() => _FilteringDrawerState();
// }

// class _FilteringDrawerState extends State<FilteringDrawer> {
//   String category = '';
//   String make = '';
//   String model = '';

//   List<Map> makes = [];
//   List<Map> categories = [];
//   List<Map> models = [];

//   List images = [];

//   List<Map> products = [];

//   getProduct(int index, String sel) {
//     FirebaseFirestore.instance.collection('products').get().then((value) {
//       if (products.isNotEmpty) {
//         products = [];
//       }
//       value.docs.forEach((element) async {
//         setState(() {
//           products.add({
//             "barCode": element.data()['barCode'],
//             'brand': element.data()['brand'],
//             "categoryID": element.data()['categoryID'],
//             'cost price': element.data()['cost price'],
//             "desc": element.data()['desc'],
//             'descA': element.data()['descA'],
//             "descK": element.data()['descK'],
//             'images': element.data()['images'],
//             "img": element.data()['img'],
//             'modelId': element.data()['modelId'],
//             "makeId": element.data()['makeId'],
//             'name': element.data()['name'],
//             'nameA': element.data()['nameA'],
//             "nameK": element.data()['nameK'],
//             'oemCode': element.data()['oemCode'],
//             'itemCode': element.data()['itemCode'],
//             'piecesInBox': element.data()['piecesInBox'],
//             'pdfUrl': element.data()['pdfUrl'],
//             "quantity": element.data()['quantity'],
//             'old price': element.data()['old price'],
//             'retail price': element.data()['retail price'],
//             "volt": element.data()['volt'],
//             'wholesale price': element.data()['wholesale price'],
//             'productId': element.id
//           });
//         });
//       });
//     }).whenComplete(() {
//       if (make == makes[index]['id'] && sel == 'make') {
//         setState(() {
//           make = "";
//         });
//       } else if (sel == 'make') {
//         setState(() {
//           make = makes[index]['id'];

//           products.removeWhere((element) => element['makeId'] != make);
//           products = products;
//         });
//       } else if (make != '') {
//         setState(() {
//           products.removeWhere((element) => element['makeId'] != make);
//           products = products;
//         });
//       }

//       if (model == models[index]['id'] && sel == 'model') {
//         setState(() {
//           model = "";
//         });
//       } else if (sel == 'model') {
//         setState(() {
//           model = models[index]['id'];

//           products.removeWhere((element) => element['modelId'] != model);
//           products = products;
//         });
//       } else if (model != '') {
//         setState(() {
//           products.removeWhere((element) => element['modelId'] != model);
//           products = products;
//         });
//       }

//       if (category == categories[index]["id"] && sel == 'cat') {
//         setState(() {
//           category = "";
//         });
//       } else if (sel == 'cat') {
//         setState(() {
//           category = categories[index]["id"];

//           products.removeWhere((element) => element['categoryID'] != category);
//           products = products;
//         });
//       } else if (category != '') {
//         setState(() {
//           products.removeWhere((element) => element['categoryID'] != category);
//           products = products;
//         });
//       }
//     });
//   }

//   getData() {
//     FirebaseFirestore.instance.collection('make').get().then((value) {
//       value.docs.forEach((element) async {
//         makes.add({
//           "name": element.data()['make'],
//           'img': element.data()['img'],
//           'id': element.id
//         });
//       });
//     }).whenComplete(() {
//       setState(() {
//         makes = makes;
//       });
//     });

//     FirebaseFirestore.instance.collection('categories').get().then((value) {
//       value.docs.forEach((element) async {
//         categories.add({
//           "name": element.data()['name'],
//           'img': element.data()['img'],
//           'id': element.id
//         });
//       });
//     }).whenComplete(() {
//       setState(() {
//         categories = categories;
//       });
//     });
//   }

//   @override
//   void initState() {
//     getData();
//     getProduct(0, 'all');
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     return Drawer(
//       child: Container(
//         width: screenSize.width * 0.22,
//         height: screenSize.height * 0.95,
//         child: Column(
//           children: [
//             Expanded(
//                 flex: 1,
//                 child: Card(
//                     color: Colors.red[900],
//                     child: Center(
//                       child: Text(
//                         "Filtering",
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ))),
//             Expanded(
//               flex: 9,
//               child: Card(
//                 color: Colors.white,
//                 child: Column(
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: ListTile(
//                           subtitle: Container(
//                               width: screenSize.width * 0.05,
//                               height: screenSize.height * 0.25,
//                               child: Container(
//                                   child: GridView.builder(
//                                       gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 3,
//                                       ),
//                                       itemCount: categories.length,
//                                       scrollDirection: Axis.vertical,
//                                       itemBuilder: ((context, index) {
//                                         return Container(
//                                           child: InkWell(
//                                             onTap: () {
//                                               getProduct(index, 'cat');
//                                             },
//                                             child: Card(
//                                               shadowColor: category !=
//                                                       categories[index]["id"]
//                                                   ? Colors.grey[800]
//                                                   : Colors.red,
//                                               elevation: category !=
//                                                       categories[index]["id"]
//                                                   ? 2
//                                                   : 5,
//                                               color: Colors.white,
//                                               child: Container(
//                                                 width: screenSize.width * 0.2,
//                                                 height: screenSize.height * 0.2,
//                                                 child: Column(
//                                                   children: [
//                                                     Container(
//                                                         width:
//                                                             screenSize.width *
//                                                                 0.1,
//                                                         height:
//                                                             screenSize.height *
//                                                                 0.08,
//                                                         child: Container(
//                                                           child: Image.network(
//                                                               categories[index]
//                                                                   ['img'],
//                                                               fit: BoxFit
//                                                                   .fitWidth),
//                                                         )),
//                                                     Container(
//                                                       height:
//                                                           screenSize.height *
//                                                               0.02,
//                                                       child: Flexible(
//                                                         child: RichText(
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                           overflow: TextOverflow
//                                                               .visible,
//                                                           strutStyle:
//                                                               StrutStyle(
//                                                                   fontSize: 10),
//                                                           text: TextSpan(
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontSize: 10,
//                                                               ),
//                                                               text: categories[
//                                                                           index]
//                                                                       ['name']
//                                                                   .toString()),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       })))),
//                           title: Text(
//                             "Category",
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey[700]),
//                           ),
//                         )),
//                     Expanded(
//                         flex: 1,
//                         child: ListTile(
//                           subtitle: Container(
//                             width: screenSize.width * 0.05,
//                             height: screenSize.height * 0.25,
//                             child: Container(
//                                 child: GridView.builder(
//                                     gridDelegate:
//                                         SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 3,
//                                     ),
//                                     itemCount: makes.length,
//                                     scrollDirection: Axis.vertical,
//                                     itemBuilder: ((context, index) {
//                                       return Container(
//                                         child: InkWell(
//                                           onTap: () {
//                                             if (make != makes[index]['id']) {
//                                               models = [];
//                                               FirebaseFirestore.instance
//                                                   .collection('make')
//                                                   .doc(makes[index]['id'])
//                                                   .collection("models")
//                                                   .get()
//                                                   .then((value) {
//                                                 value.docs
//                                                     .forEach((element) async {
//                                                   models.add({
//                                                     "mname":
//                                                         element.data()['mname'],
//                                                     "mnameA": element
//                                                         .data()['mnameA'],
//                                                     "mnameK": element
//                                                         .data()['mnameK'],
//                                                     'id': element.id
//                                                   });
//                                                 });
//                                               }).whenComplete(() {
//                                                 setState(() {
//                                                   models = models;
//                                                 });
//                                               });
//                                             } else {
//                                               setState(() {
//                                                 models = [];
//                                               });
//                                             }

//                                             getProduct(index, "make");
//                                           },
//                                           child: Card(
//                                             shadowColor:
//                                                 make != makes[index]['id']
//                                                     ? Colors.grey[800]
//                                                     : Colors.red,
//                                             elevation:
//                                                 make != makes[index]['id']
//                                                     ? 2
//                                                     : 5,
//                                             color: Colors.white,
//                                             child: Container(
//                                               width: screenSize.width * 0.2,
//                                               height: screenSize.height * 0.2,
//                                               child: ListTile(
//                                                 title: Container(
//                                                     width:
//                                                         screenSize.width * 0.1,
//                                                     height: screenSize.height *
//                                                         0.08,
//                                                     child: Container(
//                                                       child: Image.network(
//                                                           makes[index]['img'],
//                                                           fit: BoxFit.fitWidth),
//                                                     )),
//                                                 subtitle: Container(
//                                                   height:
//                                                       screenSize.height * 0.02,
//                                                   child: Flexible(
//                                                     child: RichText(
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       overflow:
//                                                           TextOverflow.visible,
//                                                       strutStyle: StrutStyle(
//                                                           fontSize: 10),
//                                                       text: TextSpan(
//                                                           style: TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 10,
//                                                           ),
//                                                           text: makes[index]
//                                                                   ['name']
//                                                               .toString()),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }))),
//                           ),
//                           title: Text(
//                             "Make",
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey[700]),
//                           ),
//                         )),
//                     Expanded(
//                         flex: 1,
//                         child: ListTile(
//                           subtitle: Container(
//                             width: screenSize.width * 0.05,
//                             height: screenSize.height * 0.2,
//                             child: models.isEmpty
//                                 ? Container(
//                                     child: Center(
//                                       child: Text("Choose a Make"),
//                                     ),
//                                   )
//                                 : Container(
//                                     child: GridView.builder(
//                                         gridDelegate:
//                                             SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 4,
//                                         ),
//                                         itemCount: models.length,
//                                         scrollDirection: Axis.vertical,
//                                         itemBuilder: ((context, index) {
//                                           return Container(
//                                             height: screenSize.height * 0.01,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 getProduct(index, 'model');
//                                               },
//                                               child: Card(
//                                                 shadowColor:
//                                                     model != models[index]['id']
//                                                         ? Colors.grey[800]
//                                                         : Colors.red,
//                                                 elevation:
//                                                     model != models[index]['id']
//                                                         ? 2
//                                                         : 5,
//                                                 color: Colors.white,
//                                                 child: Container(
//                                                   height:
//                                                       screenSize.height * 0.01,
//                                                   child: Center(
//                                                     child: Container(
//                                                       child: Flexible(
//                                                         child: RichText(
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                           overflow: TextOverflow
//                                                               .visible,
//                                                           strutStyle:
//                                                               StrutStyle(
//                                                                   fontSize: 12),
//                                                           text: TextSpan(
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontSize: 12,
//                                                               ),
//                                                               text: models[
//                                                                           index]
//                                                                       ['mname']
//                                                                   .toString()),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         }))),
//                           ),
//                           title: Text(
//                             "Model",
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey[700]),
//                           ),
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
