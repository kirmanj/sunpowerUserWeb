import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/homeScreen.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/auth_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  ScrollController _scrollController;

  TopBarContents(this.opacity, this._scrollController);

  @override
  _TopBarContentsState createState() =>
      _TopBarContentsState(this.opacity, this._scrollController);
}

class _TopBarContentsState extends State<TopBarContents> {
  double opacity;

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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return RawKeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKey: _handleKeyEvent,
      child: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Expanded(
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
                    width: 200,
                    child: Image.asset(
                      widget.opacity > 0.6
                          ? 'assets/images/sunpower2.png'
                          : 'assets/images/sunpower.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: screenSize.width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: screenSize.width / 8),
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
                                _scrollController.animateTo(
                                    screenSize.height * 0.9,
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
                          SizedBox(width: screenSize.width / 8),
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
                                  'Products',
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
                          SizedBox(width: screenSize.width / 8),
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
                                _scrollController.animateTo(
                                    screenSize.height * 2.1,
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
                          SizedBox(width: screenSize.width / 8),
                          InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[3] = true
                                    : _isHovering[3] = false;
                              });
                            },
                            onTap: () {
                              setState(() {
                                _scrollController.animateTo(
                                    screenSize.height * 3,
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width / 50,
                  ),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[4] = true : _isHovering[4] = false;
                      });
                    },
                    onTap: userEmail == null
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) => AuthDialog(),
                            );
                          }
                        : null,
                    child: userEmail == null
                        ? Text(
                            'Sign in',
                            style: TextStyle(
                              color: _isHovering[4]
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                          )
                        : Row(
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.blueGrey,
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
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                  ),
                                  child: _isProcessing
                                      ? CircularProgressIndicator()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                fullscreenDialog: true,
                                                builder: (context) =>
                                                    HomeScreen(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Admin Panel',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(width: 10),
                              TextButton(
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
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  IconButton(
                    icon: Icon(Icons.brightness_6),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    color: Colors.white,
                    onPressed: () {
                      EasyDynamicTheme.of(context).changeTheme();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
