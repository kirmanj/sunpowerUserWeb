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
                                "Sunpower Company",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "Sunpower is located in Erbil fastest growing sub-region, Lower Silesia, and specialises in manufacturing lamps and retro-reflectors used in the automotive industry. We have been on the market since 1979, constantly developing our manufacturing processes and products we offer. We use the latest state-of-the-art technology in the industry so that we can provide innovative solutions for automotive lighting. We combine innovation with environmental awareness, attention to new trends and a thorough analysis of our customers' needs.",
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
                  "Services",
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
                                "Sunpower Company",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "Sunpower is located in Erbil fastest growing sub-region, Lower Silesia, and specialises in manufacturing lamps and retro-reflectors used in the automotive industry. We have been on the market since 1979, constantly developing our manufacturing processes and products we offer. We use the latest state-of-the-art technology in the industry so that we can provide innovative solutions for automotive lighting. We combine innovation with environmental awareness, attention to new trends and a thorough analysis of our customers' needs.",
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
                      'Services',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
