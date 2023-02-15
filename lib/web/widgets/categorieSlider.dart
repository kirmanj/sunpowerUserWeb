import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/ResponsiveSales.dart';
import 'package:explore/web/widgets/auth_dialog.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:explore/web/widgets/sales.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<bool> isHover = [false];
  getCats() {
    FirebaseFirestore.instance.collection('categories').get().then((value) {
      isHover = [];
      value.docs.forEach((element) {
        setState(() {
          isHover.add(false);
        });
      });
    });
  }

  @override
  void initState() {
    getCats();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      height: ResponsiveWidget.isSmallScreen(context)
          ? screenSize.height * 0.3
          : screenSize.height * 0.4,
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width * 0.95
                      : screenSize.width * 0.7,
                  height: screenSize.height * 0.7,
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Card(
                          elevation: 5,
                          color:
                              isHover[index] ? Colors.white : Colors.red[900],
                          child: InkWell(
                            onTap: () {
                              if (uid!.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AuthDialog(),
                                );
                              } else {
                                ResponsiveWidget.isSmallScreen(context)
                                    ? Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResponsiveSales()))
                                    : Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Sales()));
                              }
                            },
                            onHover: (value) {
                              setState(() {
                                isHover[index] = !isHover[index];
                              });
                            },
                            child: Container(
                              color: isHover[index]
                                  ? Colors.white
                                  : Colors.red[900],
                              width: ResponsiveWidget.isSmallScreen(context)
                                  ? screenSize.width * 0.4
                                  : screenSize.width * 0.1,
                              height: ResponsiveWidget.isSmallScreen(context)
                                  ? screenSize.height * 0.2
                                  : screenSize.height * 0.2,
                              child: ListTile(
                                title: Container(
                                    width:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? screenSize.width * 0.4
                                            : screenSize.width * 0.1,
                                    height:
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? screenSize.height * 0.2
                                            : screenSize.height * 0.3,
                                    child: Container(
                                      child: Image.network(
                                          snapshot.data.docs[index]
                                              .data()['img'],
                                          fit: BoxFit.fitWidth),
                                    )),
                                subtitle: ResponsiveWidget.isSmallScreen(
                                        context)
                                    ? Container(
                                        height: screenSize.height * 0.1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.cover,
                                              child: Text(
                                                AppLocalizations.of(context)
                                                            .locale
                                                            .languageCode
                                                            .toString() ==
                                                        'ku'
                                                    ? snapshot.data.docs[index]
                                                        .data()['nameK']
                                                        .toString()
                                                        .toUpperCase()
                                                    : AppLocalizations.of(
                                                                    context)
                                                                .locale
                                                                .languageCode
                                                                .toString() ==
                                                            'ar'
                                                        ? snapshot
                                                            .data.docs[index]
                                                            .data()['nameA']
                                                            .toString()
                                                            .toUpperCase()
                                                        : snapshot
                                                            .data.docs[index]
                                                            .data()['name']
                                                            .toString()
                                                            .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: isHover[index]
                                                        ? Colors.red[900]
                                                        : Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: StrutStyle(
                                              fontSize: 12.0,
                                            ),
                                            text: TextSpan(
                                              style: TextStyle(
                                                  color: isHover[index]
                                                      ? Colors.red[900]
                                                      : Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              text: AppLocalizations.of(context)
                                                          .locale
                                                          .languageCode
                                                          .toString() ==
                                                      'ku'
                                                  ? snapshot.data.docs[index]
                                                      .data()['nameK']
                                                      .toString()
                                                      .toUpperCase()
                                                  : AppLocalizations.of(context)
                                                              .locale
                                                              .languageCode
                                                              .toString() ==
                                                          'ar'
                                                      ? snapshot
                                                          .data.docs[index]
                                                          .data()['nameA']
                                                          .toString()
                                                          .toUpperCase()
                                                      : snapshot
                                                          .data.docs[index]
                                                          .data()['name']
                                                          .toString()
                                                          .toUpperCase(),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        );
                      })));
            } else {
              //<DoretcumentSnapshot> items = snapshot.data;
              return Container(
                  child: Text(
                AppLocalizations.of(context).trans("Empty"),
              ));
            }
          }),
    );
  }
}
