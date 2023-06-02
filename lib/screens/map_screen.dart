import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart';
import '../models/place_location.dart';

// typedef TapCallback<T> = void Function(T mapObject, Point point);

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    // d.latitude = locData.latitude;
  }

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 56.1365, longitude: 40.3965),
    this.isSelecting = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Point _pickedLocation;

  void _selectLocation(Point point) async {
    setState(() {
      _pickedLocation = point;
    });
    mapObjectCollections.add(PlacemarkMapObject(
        mapId: MapObjectId('mapId'),
        point: _pickedLocation,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image:
                BitmapDescriptor.fromAssetImage('assets/images/location1.png')))
        // icon: PlacemarkIcon.single(PlacemarkIconStyle(image: Image.asset('name')))
        ));
    // print(_pickedLocation);
  }

  // void setCameraPos() async {
  //   final yaMapCon = await YandexMapController().getCameraPosition();
  // }

  List<MapObject> mapObjectCollections = [];

  // void _addPlaceMarkOnMap() {
  //   // mapObjectCollections.add(
  //   //   PlacemarkMapObject(
  //   //     mapId: MapObjectId('dasdadasdsa'),
  //   //     point: Point(latitude: point.latitude, longitude: point.longitude),
  //   //   ),
  //   // );
  //   var myMap = YandexMap();
  //   myMap.onMapTap(Location().)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: YandexMap(
        onMapCreated: (controller) {
          return controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: Point(
                  latitude: widget.initialLocation.latitude,
                  longitude: widget.initialLocation.longitude,
                ),
              ),
            ),
          );
        },
        // onCameraPositionChanged: (cameraPosition, reason, finished) {
        //   CameraPosition(
        //     target: Point(
        //         latitude: widget.initialLocation.latitude,
        //         longitude: widget.initialLocation.longitude),
        //     zoom: 16,
        //   );
        // },
        onMapTap: widget.isSelecting ? _selectLocation : null,
        mapObjects: mapObjectCollections,
      ),
    );
  }
}
