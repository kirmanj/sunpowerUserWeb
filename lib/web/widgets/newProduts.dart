import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';

class LatestProducts extends StatefulWidget {
  const LatestProducts({Key? key}) : super(key: key);

  @override
  State<LatestProducts> createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      height: ResponsiveWidget.isSmallScreen(context)
          ? screenSize.height * 0.43
          : screenSize.height * 0.4,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width * 0.95
                      : screenSize.width * 0.7,
                  height: screenSize.height * 0.7,
                  child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Container(
                          width: ResponsiveWidget.isSmallScreen(context)
                              ? screenSize.width * 0.6
                              : screenSize.width * 0.25,
                          height: ResponsiveWidget.isSmallScreen(context)
                              ? screenSize.height * 0.2
                              : screenSize.height * 0.3,
                          child: ListTile(
                            title: Card(
                              elevation: snapshot.data.docs.length,
                              color: Colors.white,
                              child: Container(
                                width: ResponsiveWidget.isSmallScreen(context)
                                    ? screenSize.width * 0.6
                                    : screenSize.width * 0.25,
                                height: ResponsiveWidget.isSmallScreen(context)
                                    ? screenSize.height * 0.2
                                    : screenSize.height * 0.3,
                                child: Image.network(
                                    snapshot.data.docs[index].data()['img'],
                                    fit: BoxFit.cover),
                              ),
                            ),
                            subtitle: ResponsiveWidget.isSmallScreen(context)
                                ? Card(
                                    elevation: 4,
                                    color: Colors.white,
                                    child: Container(
                                      height: screenSize.height * 0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text(
                                              snapshot.data.docs[index]
                                                  .data()['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text(
                                              snapshot.data.docs[index]
                                                      .data()['retail price']
                                                      .toString() +
                                                  " \$",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title:
                                                    const Text('Download Now'),
                                                content: const Text(
                                                    'for IOS and Android'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .red)),
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: Card(
                                              color: Colors.green,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      "Order",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          snapshot.data.docs[index]
                                              .data()['name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          snapshot.data.docs[index]
                                                  .data()['retail price']
                                                  .toString() +
                                              " \$",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Download Now'),
                                            content: const Text(
                                                'for IOS and Android'),
                                            actions: <Widget>[
                                              TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red)),
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
                                        ),
                                        child: Card(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text(
                                                  "Order",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        );
                      })));
            } else {
              //<DoretcumentSnapshot> items = snapshot.data;
              return Container(child: Text("No data"));
            }
          }),
    );
    ;
  }
}
