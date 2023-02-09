import 'package:countup/countup.dart';
import 'package:explore/localization/AppLocal.dart';
import 'package:explore/web/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FloatingQuickAccessBar extends StatefulWidget {
  const FloatingQuickAccessBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  _FloatingQuickAccessBarState createState() => _FloatingQuickAccessBarState();
}

class _FloatingQuickAccessBarState extends State<FloatingQuickAccessBar> {
  List _isHovering = [false, false, false, false];
  List<Widget> rowElements = [];

  List<String> items = ['customers', 'Brands', 'products'];
  List<double> itemsC = [4560, 10, 3450];
  List<IconData> icons = [
    Icons.people,
    Icons.branding_watermark,
    Icons.production_quantity_limits
  ];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {},
        child: Row(
          children: [
            Icon(
              icons[i],
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context).trans(items[i]),
              style: TextStyle(
                color: !_isHovering[i]
                    ? Colors.black
                    : Theme.of(context).primaryTextTheme.button!.color,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Countup(
              begin: 0,
              end: itemsC[i],
              duration: Duration(seconds: 3),
              separator: ',',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
      Widget spacer = SizedBox(
        height: widget.screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.screenSize.height * 0.50,
          left: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
          right: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
        ),
        child: ResponsiveWidget.isSmallScreen(context)
            ? Column(
                children: [
                  ...Iterable<int>.generate(items.length).map(
                    (int pageIndex) => Padding(
                      padding:
                          EdgeInsets.only(top: widget.screenSize.height / 80),
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: widget.screenSize.height / 45,
                              bottom: widget.screenSize.height / 45,
                              left: widget.screenSize.width / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                icons[pageIndex],
                                color: Theme.of(context).iconTheme.color,
                              ),
                              SizedBox(width: widget.screenSize.width / 20),
                              InkWell(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                onTap: () {},
                                child: Text(
                                  items[pageIndex],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(width: widget.screenSize.width / 20),
                              Countup(
                                begin: 0,
                                end: itemsC[pageIndex],
                                duration: Duration(seconds: 3),
                                separator: ',',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Card(
                elevation: 5,
                color: Color.fromRGBO(254, 254, 254, 1),
                borderOnForeground: true,
                shadowColor: Color.fromRGBO(254, 254, 254, 1),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.screenSize.height / 50,
                    bottom: widget.screenSize.height / 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: generateRowElements(),
                  ),
                ),
              ),
      ),
    );
  }
}
