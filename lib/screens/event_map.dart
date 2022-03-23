import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:provider/provider.dart';
import 'package:reunionou/data/users_collection.dart';

class EventMap extends StatelessWidget {
  EventMap({Key? key}) : super(key: key);
  final latLng = LatLng(51.5, -0.09);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserCollection>(builder: (context, userCollection, child) {
      return Scaffold(
          appBar: AppBar(title: Text(userCollection.title)),
          body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                Expanded(
                    child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(51.5, -0.09),
                    zoom: 13.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
                      additionalOptions: {
                        'subscriptionKey':
                            'NNknHnBvKJ-o0gVn_Dw2O_V39021fJexZyJTJHjZnPM'
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(51.5, -0.09),
                          builder: (ctx) => const Icon(
                            Icons.pin_drop,
                            color: Colors.red,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                Container(
                    alignment: Alignment.center,
                    height: 350,
                    color: Colors.blue,
                    child: Column(children: <Widget>[
                      const Text('\n'),
                      const Text(
                        'Libelle_event \n\n RV le date à Heure \n\n Lieu_event\n',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: const Text('Je viens'),
                      ),
                      const Text('\n'),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: const Text('désolé'),
                      ),
                      const Text('\n'),
                      const Text(
                        'Information présence / absence',
                        style: TextStyle(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      )
                    ]))
              ])));
    });
  }
}
