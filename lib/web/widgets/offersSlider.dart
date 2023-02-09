import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';

class OffersSlidder extends StatelessWidget {
  const OffersSlidder({
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
                Text(
                  AppLocalizations.of(context).trans("offers"),
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).trans("offers"),
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
