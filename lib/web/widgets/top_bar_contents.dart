import 'package:explore/web/screens/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  final ScrollController _scrollController;

  TopBarContents(this.opacity, this._scrollController);

  @override
  _TopBarContentsState createState() =>
      _TopBarContentsState(this.opacity, this._scrollController);
}

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

  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
    if (_scrollPosition > 1) {
      setState(() {
        _animationWidth = 70;
      });
    }
    if (_scrollPosition == 0) {
      setState(() {
        _animationWidth = 0;
      });
    }
  }

  double _animationWidth = 0;

  @override
  void initState() {
    // TODO: implement initState

    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return RawKeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKey: _handleKeyEvent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.0),
          child: Container(
            width: screenSize.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _scrollController.animateTo(screenSize.height * 1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "OFFERS",
                          style: TextStyle(
                              fontSize: 14,
                              color: _animationWidth == 70
                                  ? Colors.black
                                  : Colors.white),
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
                        _scrollController.animateTo(screenSize.height * 2.2,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "CATEGORIES",
                          style: TextStyle(
                              fontSize: 16,
                              color: _animationWidth == 70
                                  ? Colors.black
                                  : Colors.white),
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
                        _scrollController.animateTo(screenSize.height * 0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "HL. SUNGLASSES  ",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF35ddde)),
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
                        _scrollController.animateTo(screenSize.height * 2.9,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "BRAND",
                          style: TextStyle(
                              fontSize: 16,
                              color: _animationWidth == 70
                                  ? Colors.black
                                  : Colors.white),
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
                        _scrollController.animateTo(screenSize.height * 3.4,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease);
                      });
                    },
                    child: Center(
                      child: Text(
                        "FIND US",
                        style: TextStyle(
                            fontSize: 14,
                            color: _animationWidth == 70
                                ? Colors.black
                                : Colors.white),
                      ),
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
              onTap: () {},
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
              onTap: () {},
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
