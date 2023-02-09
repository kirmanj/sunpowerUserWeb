import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.01,
        left: screenSize.width / 15,
        right: screenSize.width / 15,
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: screenSize.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: screenSize.height * 0.5,
                        width: screenSize.width * 0.9,
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              child: Text(
                                AppLocalizations.of(context)
                                    .trans("companyName"),
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context).trans("companyDetail"),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 00.0),
                        child: Container(
                          child: SizedBox(
                            height: screenSize.height * 0.3,
                            child: Image.asset(
                              'assets/images/parts.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context).trans("services"),
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
              ],
            )
          : Column(
              children: [
                Container(
                  height: screenSize.height * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: screenSize.height * 0.4,
                        width: screenSize.width * 0.5,
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              child: Text(
                                AppLocalizations.of(context)
                                    .trans("companyName"),
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context).trans("companyDetail"),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: SizedBox(
                            height: screenSize.height * 0.35,
                            child: Image.asset(
                              'assets/images/parts.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).trans("services"),
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
