import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

const styleUrl =
    "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png";
const apiKey =
    "YOUR-API-KEY"; // TODO: Replace this with your own API key. Sign up for free at https://client.stadiamaps.com/.

class SunMap extends StatefulWidget {
  const SunMap({Key? key}) : super(key: key);

  @override
  State<SunMap> createState() => _SunMapState();
}

class _SunMapState extends State<SunMap> {
  double zoomRange = 15;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      children: [
        TileLayer(
          urlTemplate: styleUrl,
          //change base_snow_map to pistes
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
                point: LatLng(36.222918829222536, 44.05303431285899),
                builder: (context) {
                  return Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          size: 24,
                          color: Colors.red[900],
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ],
      options: MapOptions(
          center: LatLng(36.222918829222536, 44.05303431285899),
          zoom: zoomRange,
          keepAlive: true),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'Sunpower',
          onSourceTapped: () async {
            if (!await launchUrl(
                Uri.parse("https://stadiamaps.com/attribution"))) {
              if (kDebugMode) {
                print('Could not launch url');
              }
            }
          },
        )
      ],
    );
  }
}
