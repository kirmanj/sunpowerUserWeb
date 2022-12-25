import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'google_sign_in_button.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  late TextEditingController textControllerEmail;
  late FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

  late TextEditingController textControllerPassword;
  late FocusNode textFocusNodePassword;
  bool _isEditingPassword = false;
  bool _isRegistering = false;
  bool _isLoggingIn = false;

  late TextEditingController textControllerName;
  late TextEditingController textControllerAddress;

  String? loginStatus;
  Color loginStringColor = Colors.green;

  late TextEditingController textControllerPhone;

  bool _isEditingPhone = false;
  bool _isEditingName = false;
  bool _isEditingAddress = false;

  late TextEditingController otp;
  String? _validateEmail(String value) {
    value = value.trim();

    if (textControllerEmail.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  String? _validateName(String value) {
    value = value.trim();

    if (textControllerName.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Username can\'t be empty';
      }
    }

    return null;
  }

  String? _validateAddress(String value) {
    value = value.trim();

    if (textControllerAddress.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Address can\'t be empty';
      }
    }

    return null;
  }

  String? _validatePassword(String value) {
    value = value.trim();

    if (textControllerEmail.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      } else if (value.length < 6) {
        return 'Length of password should be greater than 6';
      }
    }

    return null;
  }

  bool isPhone = false;
  bool canShow = false;
  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textControllerPassword = TextEditingController();
    textControllerPhone = TextEditingController();
    textControllerAddress = TextEditingController();
    textControllerName = TextEditingController();
    textControllerEmail.text = '';
    textControllerPassword.text = '';
    textControllerAddress.text = '';
    textControllerName.text = '';
    textFocusNodeEmail = FocusNode();

    textFocusNodePassword = FocusNode();
    super.initState();
  }

  bool isNew = false;

  String phoneNumber = "";
  sendOTP(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      '+964 $phoneNumber',
    );
    print("OTP Sent to +964 $phoneNumber");
    return confirmationResult;
  }

  late UserCredential userCredential;

  authenticateMe(ConfirmationResult confirmationResult, String otp) async {
    userCredential = await confirmationResult.confirm(otp);
    userCredential.additionalUserInfo!.isNewUser
        ? print("Successful Authentication")
        : print("User already exists");

    if (userCredential.additionalUserInfo!.isNewUser) {
      setState(() {
        isNew = true;
      });
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userCredential.user!.uid.toString())
      //     .set({
      //   "username": " ",
      //   'phone': textControllerPhone.text,
      //   'address': " ",
      //   "email": " ",
      //   'password': " ",
      //   "role": 1
      // });
      // setState(() {
      //   loginStatus = 'You have successfully signed up';
      //   loginStringColor = Colors.green;
      // });
      // Future.delayed(Duration(milliseconds: 500), () {
      //   Navigator.of(context).pop();
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     fullscreenDialog: true,
      //     builder: (context) => HomeScreen(),
      //   ));
      // });
    } else {
      setState(() {
        loginStatus = 'You have successfully logged in';
        loginStringColor = Colors.green;
        uid = userCredential.user?.uid;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => HomePage(),
        ));
      });
    }
  }

  var temp;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset('assets/images/sunpower.png'),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isPhone = false;
                            canShow = false;
                          });
                        },
                        child: Flexible(
                          child: RichText(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                            strutStyle: StrutStyle(
                              fontSize: ResponsiveWidget.isSmallScreen(context)
                                  ? 12
                                  : 18,
                            ),
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isPhone
                                    ? Colors.grey[400]
                                    : Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .color,
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 12
                                        : 18,
                              ),
                              text: 'Email address',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              isPhone = true;
                              canShow = false;
                            });
                          },
                          child: Flexible(
                            child: RichText(
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.visible,
                              strutStyle: StrutStyle(
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 12
                                        : 18,
                              ),
                              text: TextSpan(
                                style: TextStyle(
                                  color: !isPhone
                                      ? Colors.grey[400]
                                      : Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .color,
                                  fontSize:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 12
                                          : 18,
                                ),
                                text: 'Phone Number',
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                isNew && isPhone
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: Text(
                          'User Name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.subtitle2!.color,
                            fontSize: 18,
                            // fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            // letterSpacing: 3,
                          ),
                        ),
                      )
                    : Container(),
                isNew && isPhone
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerName,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              _isEditingName = true;
                            });
                          },
                          onSubmitted: (value) {},
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Username",
                            fillColor: Colors.white,
                            errorText: _isEditingName
                                ? _validateName(textControllerName.text)
                                : null,
                            errorStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                isNew && isPhone
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: Text(
                          'Address',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.subtitle2!.color,
                            fontSize: 18,
                            // fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            // letterSpacing: 3,
                          ),
                        ),
                      )
                    : Container(),
                isNew && isPhone
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.streetAddress,
                          textInputAction: TextInputAction.next,
                          controller: textControllerAddress,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              _isEditingAddress = true;
                            });
                          },
                          onSubmitted: (value) {},
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Address...",
                            fillColor: Colors.white,
                            errorText: _isEditingAddress
                                ? _validateName(textControllerAddress.text)
                                : null,
                            errorStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                isPhone && !isNew
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          controller: textControllerPhone,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              _isEditingEmail = true;
                            });
                          },
                          onSubmitted: (value) {},
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "ex: 750 *** ****",
                            fillColor: Colors.white,
                            errorText: _isEditingPhone
                                ? _validateEmail(textControllerPhone.text)
                                : null,
                            errorStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      )
                    : isPhone && isNew
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20,
                            ),
                            child: TextField(
                              focusNode: textFocusNodeEmail,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: textControllerEmail,
                              autofocus: false,
                              onChanged: (value) {
                                setState(() {
                                  _isEditingEmail = true;
                                });
                              },
                              onSubmitted: (value) {
                                textFocusNodeEmail.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(textFocusNodePassword);
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blueGrey[800]!,
                                    width: 3,
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(
                                  color: Colors.blueGrey[300],
                                ),
                                hintText: "Email",
                                fillColor: Colors.white,
                                errorText: _isEditingEmail
                                    ? _validateEmail(textControllerEmail.text)
                                    : null,
                                errorStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                SizedBox(height: 20),
                (!canShow && isPhone) || (isNew)
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 8,
                        ),
                        child: Flexible(
                          child: RichText(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                            strutStyle: StrutStyle(
                              fontSize: ResponsiveWidget.isSmallScreen(context)
                                  ? 12
                                  : 18,
                            ),
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .color,
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 12
                                        : 18,
                              ),
                              text: isPhone ? "OTP" : "Password",
                            ),
                          ),
                        ),
                      ),
                (!canShow && isPhone) || (isNew)
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: TextField(
                          focusNode: textFocusNodePassword,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: textControllerPassword,
                          obscureText: !isPhone,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              _isEditingPassword = true;
                            });
                          },
                          onSubmitted: (value) {
                            textFocusNodePassword.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodePassword);
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: isPhone ? "OTP" : "Password",
                            fillColor: Colors.white,
                            errorText: _isEditingPassword
                                ? _validatePassword(textControllerPassword.text)
                                : null,
                            errorStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isPhone && !isNew
                          ? Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () async {
                                  print(canShow);
                                  print(textControllerPhone.text.length);

                                  if (!canShow &&
                                      (textControllerPhone.text.length == 10)) {
                                    setState(() {
                                      canShow = !canShow;
                                    });
                                    temp =
                                        await sendOTP(textControllerPhone.text);
                                  } else {
                                    authenticateMe(
                                        temp, textControllerPassword.text);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromARGB(254, 246, 238, 50),
                                        Color.fromARGB(254, 211, 160, 38),
                                        Color.fromARGB(254, 246, 238, 50),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 15.0,
                                      bottom: 15.0,
                                    ),
                                    child: _isLoggingIn
                                        ? SizedBox(
                                            height: 16,
                                            width: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: 50.0,
                                                right: 50.0,
                                                bottom: 1.0,
                                                top: 1.0),
                                            child: Text(
                                              canShow ? "Submit" : 'Send Otp',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          : Flexible(
                              flex: 1,
                              child: isNew
                                  ? SizedBox.shrink()
                                  : InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _isLoggingIn = true;
                                          textFocusNodeEmail.unfocus();
                                          textFocusNodePassword.unfocus();
                                        });
                                        if (_validateEmail(
                                                    textControllerEmail.text) ==
                                                null &&
                                            _validatePassword(
                                                    textControllerPassword
                                                        .text) ==
                                                null) {
                                          await signInWithEmailPassword(
                                                  textControllerEmail.text,
                                                  textControllerPassword.text,
                                                  context)
                                              .then((result) {
                                            if (result != null) {
                                              print(result);
                                              setState(() {
                                                loginStatus =
                                                    'You have successfully logged in';
                                                loginStringColor = Colors.green;
                                              });
                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                  () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      HomePage(),
                                                ));
                                              });
                                            }
                                          }).catchError((error) {
                                            print('Login Error: $error');
                                            setState(() {
                                              loginStatus =
                                                  'Error occured while logging in';
                                              loginStringColor = Colors.red;
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            loginStatus =
                                                'Please enter email & password';
                                            loginStringColor = Colors.red;
                                          });
                                        }
                                        setState(() {
                                          _isLoggingIn = false;
                                          textControllerEmail.text = '';
                                          textControllerPassword.text = '';
                                          _isEditingEmail = false;
                                          _isEditingPassword = false;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color.fromARGB(254, 246, 238, 50),
                                              Color.fromARGB(254, 211, 160, 38),
                                              Color.fromARGB(254, 246, 238, 50),
                                            ],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 15.0,
                                            bottom: 15.0,
                                          ),
                                          child: _isLoggingIn
                                              ? SizedBox(
                                                  height: 16,
                                                  width: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        new AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.white,
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 50.0,
                                                      right: 50.0,
                                                      bottom: 1.0,
                                                      top: 1.0),
                                                  child: Text(
                                                    'Log in',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                            ),
                      isPhone && isNew
                          ? InkWell(
                              onTap: () async {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user!.uid.toString())
                                    .set({
                                  "username": textControllerName.text,
                                  'phone': textControllerPhone.text,
                                  'address': textControllerAddress.text,
                                  "email": "",
                                  'password': " ",
                                  "role": 1
                                });
                                setState(() {
                                  loginStatus =
                                      'You have successfully signed up';
                                  loginStringColor = Colors.green;
                                });
                                Future.delayed(Duration(milliseconds: 500), () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => HomePage(),
                                  ));
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromARGB(254, 246, 238, 50),
                                      Color.fromARGB(254, 211, 160, 38),
                                      Color.fromARGB(254, 246, 238, 50),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 15.0,
                                    bottom: 15.0,
                                  ),
                                  child: _isLoggingIn
                                      ? SizedBox.shrink()
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: 50.0,
                                              right: 50.0,
                                              bottom: 1.0,
                                              top: 1.0),
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                ),
                loginStatus != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: Text(
                            loginStatus!,
                            style: TextStyle(
                              color: loginStringColor,
                              fontSize: 14,
                              // letterSpacing: 3,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                  ),
                  child: Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.blueGrey[200],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sunpower',
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle2!.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      // letterSpacing: 3,
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
