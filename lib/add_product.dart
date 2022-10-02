import 'dart:html';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController nameK = TextEditingController();
  TextEditingController nameA = TextEditingController();
  TextEditingController oemCode = TextEditingController();
  TextEditingController itemCode = TextEditingController();
  TextEditingController barCode = TextEditingController();
  String barcodeT = "";
  TextEditingController brand = TextEditingController();
  TextEditingController piecesInBox = TextEditingController();
  TextEditingController volt = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController descE = TextEditingController();
  TextEditingController descK = TextEditingController();
  TextEditingController descA = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  TextEditingController rPrice = TextEditingController();
  TextEditingController wPrice = TextEditingController();
  late String randomNumber;
  var uuid = Uuid();

  List<QueryDocumentSnapshot> categoryList = [];
  String categoryID = '';
  String image = '';
  bool loading = false;
  String selectedCategory = '';

  List<QueryDocumentSnapshot> makeList = [];
  String selectedMake = '';
  String makeID = '';

  List<QueryDocumentSnapshot> modelList = [];
  String selectedModel = '';
  String modelID = '';
  getCategory() {
    FirebaseFirestore.instance.collection('categories').get().then((value) {
      setState(() {
        selectedCategory = value.docs[0].data()['name'];
        categoryID = value.docs[0].id;
        print(categoryID);
      });
      value.docs.forEach((element) {
        setState(() {
          categoryList.add(element);
        });
      });
    });
    FirebaseFirestore.instance.collection('make').get().then((value) {
      setState(() {
        selectedMake = value.docs[0].data()['make'];
        makeID = value.docs[0].id;
        print(makeID);
      });
      FirebaseFirestore.instance
          .collection('make')
          .doc(value.docs[0].id)
          .collection("models")
          .get()
          .then((value) {
        setState(() {
          selectedModel = value.docs[0]["mname"];
          value.docs.forEach((element) {
            modelList.add(element);
          });
        });
      });
      value.docs.forEach((element) {
        setState(() {
          modelID = value.docs[0].id;
          print(modelID);
          makeList.add(element);
        });
      });
    });
  }

  final menuProducts = FirebaseFirestore.instance.collection('products');

  @override
  void initState() {
    // TODO: implement initState
    // FirebaseFirestore.instance
    //     .collection('products')
    //     .doc("1e9f5ca0-3f99-11ed-8c22-7bde08f9388e")
    //     .get()
    //     .then((value) {
    //   print(value.get("name"));
    //   name.text = value.get("name");
    //   nameK.text = value.get("nameK");
    //   nameA.text = value.get("nameA");
    //   descE.text = value.get("desc");
    //   descK.text = value.get("descK");
    //   descA.text = value.get("descA");
    //   cPrice.text = value.get("cost price");
    //   wPrice.text = value.get("wholesale price");
    //   rPrice.text = value.get("retail price");
    //   image = value.get("img");
    // });
    super.initState();
    getCategory();
    randomNumber = uuid.v1();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return Container(
          height: height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: width * 0.1,
                          height: height * 0.1,
                          child: Center(
                              child: Text('Add Product',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )))),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: width * 0.15,
                                  child: InkWell(
                                    onTap: () {
                                      uploadImgToStorage();
                                    },
                                    child: image.isEmpty
                                        ? Container(
                                            height: 250,
                                            child: loading == true
                                                ? Transform.scale(
                                                    scale: 0.2,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 10,
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.add_a_photo_rounded),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      10.0) //                 <--- border radius here
                                                  ),
                                            ),
                                          )
                                        : Container(
                                            height: 160,
                                            width: 160,
                                            child:
                                                Image.network(image.toString()),
                                          ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Select Category'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    DropdownButton<String>(
                                      // focusColor: Theme.of(context).highlightColor,
                                      //value: _chosenValue,
                                      //elevation: 5,
                                      style: TextStyle(color: Colors.black),
                                      value: selectedCategory,
                                      iconEnabledColor:
                                          Theme.of(context).highlightColor,
                                      items: categoryList
                                          .map<DropdownMenuItem<String>>(
                                              (QueryDocumentSnapshot value) {
                                        return DropdownMenuItem<String>(
                                          value: value['name'].toString(),
                                          child: Text(
                                            value['name'],
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text("Choose Category"),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value.toString();
                                        });
                                        FirebaseFirestore.instance
                                            .collection('categories')
                                            .where("name",
                                                isEqualTo: value.toString())
                                            .get()
                                            .then((value) {
                                          categoryID = value.docs[0].id;
                                          print(categoryID);
                                        });
                                      },
                                      // onTap: () {
                                      //   setState(() {
                                      //     saveData(_chosenValue);
                                      //   });
                                      // },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Select Make'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    DropdownButton<String>(
                                      style: TextStyle(color: Colors.black),
                                      value: selectedMake,
                                      iconEnabledColor:
                                          Theme.of(context).highlightColor,
                                      items: makeList
                                          .map<DropdownMenuItem<String>>(
                                              (QueryDocumentSnapshot value) {
                                        return DropdownMenuItem<String>(
                                          value: value['make'].toString(),
                                          child: Text(
                                            value['make'],
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text("Choose Make"),
                                      onTap: () {},

                                      onChanged: (value) {
                                        setState(() {
                                          selectedMake = value.toString();
                                        });

                                        FirebaseFirestore.instance
                                            .collection('make')
                                            .where("make",
                                                isEqualTo: value.toString())
                                            .get()
                                            .then((value) {
                                          makeID = value.docs[0].id;
                                          print(makeID);
                                          FirebaseFirestore.instance
                                              .collection('make')
                                              .doc(value.docs[0].id)
                                              .collection("models")
                                              .get()
                                              .then((value) {
                                            modelList = [];
                                            modelID = value.docs[0].id;
                                            print(modelID);
                                            setState(() {
                                              selectedModel =
                                                  value.docs[0]["mname"];
                                              print(value.docs[0]["mname"]);
                                              value.docs.forEach((element) {
                                                modelList.add(element);
                                              });
                                            });
                                          });
                                        });
                                      },
                                      // onTap: () {
                                      //   setState(() {
                                      //     saveData(_chosenValue);
                                      //   });
                                      // },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Select Model'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    DropdownButton<String>(
                                      style: TextStyle(color: Colors.black),
                                      value: selectedModel,
                                      iconEnabledColor:
                                          Theme.of(context).highlightColor,
                                      items: modelList
                                          .map<DropdownMenuItem<String>>(
                                              (QueryDocumentSnapshot value) {
                                        return DropdownMenuItem<String>(
                                          value: value['mname'].toString(),
                                          child: Text(
                                            value['mname'],
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text("Choose Model"),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedModel = value.toString();
                                        });

                                        FirebaseFirestore.instance
                                            .collection('make')
                                            .doc(makeID)
                                            .collection("models")
                                            .where("mname",
                                                isEqualTo: value.toString())
                                            .get()
                                            .then((value) {
                                          modelID = value.docs[0].id;
                                          print(modelID);
                                        });
                                      },
                                      // onTap: () {
                                      //   setState(() {
                                      //     saveData(_chosenValue);
                                      //   });
                                      // },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                // width:00,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: name,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Enter Product Name";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Name',
                                                labelText: 'Name',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: nameK,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "ناوی کاڵاکە بنووسە";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'ناو',
                                                labelText: 'ناو',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: nameA,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "اكتب اسم البضاعة";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'اسم',
                                                labelText: 'اسم',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //description
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: oemCode,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Enter OEM Code";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'OEM CODE',
                                                labelText: 'OEM CODE',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: itemCode,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Enter Item Code";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Item Code",
                                                labelText: "Item Code",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: barCode,
                                              onChanged: (text) {
                                                setState(() {
                                                  barcodeT = barCode.text;
                                                });
                                              },
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Enter Barcode";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Bar Code",
                                                labelText: "Bar Code",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //description
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: brand,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Enter Brand";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Brand',
                                                labelText: 'Brand',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: piecesInBox,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Enter Pieces In Box";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Pieces In Box",
                                                labelText: "Pieces In Box",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextFormField(
                                              controller: volt,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Enter Volt";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Volt",
                                                labelText: "Volt",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //description
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: descE,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Product Details";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Description',
                                        labelText: 'Description',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: descK,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "وردەکاری کالا";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'وردەکاری',
                                        labelText: 'وردەکاری',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: descA,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "تفاصيل السلع";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'وصف',
                                        labelText: 'وصف',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    //prices
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: width * 0.15,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: cPrice,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return "Enter price";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Cost Price',
                                              labelText: 'Cost Price',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.15,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: rPrice,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return "Enter price";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Retail Price',
                                              labelText: 'Retail Price',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.15,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: wPrice,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return "Enter price";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: ' Wholesale Price ',
                                              labelText: ' Wholesale Price',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.15,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: quantity,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return "Enter Quantity";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: ' Quantity ',
                                              labelText: ' Quantity',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: height * 0.1,
                              width: width * 0.2,
                              child: BarcodeWidget(
                                data: barCode.text,
                                barcode: Barcode.code128(escapes: true),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                  width: width * 0.1,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 0, 178, 169),
                                          Color.fromARGB(255, 0, 106, 101),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(25.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.2),
                                          spreadRadius: 4,
                                          blurRadius: 10,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Center(
                                      child: Container(
                                    child: Text('ADD',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ))),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (categoryID.isEmpty || image.isEmpty) {
                                    Scaffold.of(context)
                                        .showSnackBar(_missingData);
                                  } else {
                                    menuProducts.doc(randomNumber).set({
                                      "categoryID": categoryID,
                                      'productID': randomNumber.toString(),
                                      'makeId': makeID,
                                      'modelId': modelID,
                                      'name': name.text,
                                      'nameK': nameK.text,
                                      'nameA': nameA.text,
                                      'desc': descE.text,
                                      'descK': descK.text,
                                      'descA': descA.text,

                                      'oemCode':
                                          int.parse(oemCode.text.toString()),
                                      'itemCode':
                                          int.parse(itemCode.text.toString()),
                                      'barCode':
                                          int.parse(barCode.text.toString()),
                                      'piecesInBox': int.parse(
                                          piecesInBox.text.toString()),
                                      'brand': brand.text,
                                      'volt': volt.text,
                                      'quantity':
                                          int.parse(quantity.text.toString()),
                                      'cost price': cPrice.text,
                                      'retail price': rPrice.text,
                                      'wholesale price': wPrice.text,
                                      "Time": DateTime.now(),
                                      "img": image,

                                      // "Time": DateTime.now(),// John Doe
                                    });
                                    setState(() {
                                      name.text = '';
                                      nameK.text = '';
                                      nameA.text = '';
                                      descE.text = '';
                                      descK.text = '';
                                      descA.text = '';
                                      cPrice.text = '';
                                      wPrice.text = '';
                                      rPrice.text = '';
                                      image = '';
                                      brand.text = '';
                                      oemCode.text = '';
                                      itemCode.text = '';
                                      barCode.text = '';
                                      quantity.text = '';
                                      volt.text = '';
                                      piecesInBox.text = '';

                                      randomNumber = uuid.v1();
                                    });
                                    Scaffold.of(context).showSnackBar(_success);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    ));
  }

  void selectImage({required Function(File file) onSelected}) {
    var uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
        setState(() {
          loading = true;
        });
      });
    });
  }

  void uploadImgToStorage() {
    final dateTime = DateTime.now();
    final name = 'ProductImg';
    final path = '$name/$dateTime';
    selectImage(onSelected: (file) async {
      fb.StorageReference storageRef = fb
          .storage()
          .refFromURL('gs://resturant-management-f42e5.appspot.com')
          .child(path);
      fb.UploadTaskSnapshot uploadTaskSnapshot =
          await storageRef.put(file).future;
      Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();

      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          image = imageUri.toString();
          loading = false;
        });
      });
    });
  }

  final _success = SnackBar(
    content: Text(
      'Added Successfully',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    ),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
  );

  final _missingData = SnackBar(
    content: Text(
      'Category or Image is empty',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
  );
}
