import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/localization/AppLocal.dart';
import 'package:explore/main.dart';
import 'package:explore/services/local_storage_service.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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

  double subTotal = 0;
  double deliveryFee = 0;
  double exchangeRate = 0;

  bool select = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Drawer(
      width: screenSize.width * 0.5,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.red,
                    width: screenSize.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _scrollController.animateTo(
                                    screenSize.height * 0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              child: Text(
                                "HL. SUNGLASSES  ",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF35ddde)),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0xFF35ddde),
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _scrollController.animateTo(
                                    screenSize.height * 1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text(
                                "OFFERS",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF35ddde),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0xFF35ddde),
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _scrollController.animateTo(
                                    screenSize.height * 2.5,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text(
                                "CATEGORIES",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF35ddde),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0xFF35ddde),
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _scrollController.animateTo(
                                    screenSize.height * 3.3,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text(
                                "BRAND",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF35ddde),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0xFF35ddde),
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _scrollController.animateTo(
                                    screenSize.height * 3.7,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              "FIND US",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF35ddde),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0xFF35ddde),
                          height: 1,
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '© GUIDEWARE',
                    style: TextStyle(
                      color: Color(0xFF35ddde),
                      fontSize: 12,
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
