import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trashClean/providers/trash_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart';
import '../models/place_location.dart';
import '../providers/trash.dart';

// typedef TapCallback<T> = void Function(T mapObject, Point point);

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  final List<Trash> trashList;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    // d.latitude = locData.latitude;
  }

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 56.1365, longitude: 40.3965),
      this.isSelecting = false,
      this.trashList});

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
              if (widget.trashList != null) {
                List<MapObject> mapObjectCollectionsTwo = [];
                for (var i = 0; i < widget.trashList.length; i++) {
                  mapObjectCollectionsTwo.add(
                    PlacemarkMapObject(
                        mapId: MapObjectId('${widget.trashList[i].id}'),
                        point: Point(
                            latitude: widget.trashList[i].location.latitude,
                            longitude: widget.trashList[i].location.longitude),
                        icon: PlacemarkIcon.single(
                          PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage(
                                'assets/images/location1.png'),
                          ),
                        )),
                  );
                  setState(() {
                    mapObjectCollections = mapObjectCollectionsTwo;
                  });
                }
                controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: widget.initialLocation.latitude,
                        longitude: widget.initialLocation.longitude,
                      ),
                    ),
                  ),
                );
              } else {
                mapObjectCollections.add(
                  PlacemarkMapObject(
                    mapId: MapObjectId('mapId'),
                    point: Point(
                        latitude: widget.initialLocation.latitude,
                        longitude: widget.initialLocation.longitude),
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                            'assets/images/location1.png'),
                      ),
                    ),
                  ),
                );

                controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: widget.initialLocation.latitude,
                        longitude: widget.initialLocation.longitude,
                      ),
                    ),
                  ),
                );

                setState(() {
                  mapObjectCollections;
                });
              }
            },
            onObjectTap: (geoObject) {
              return geoObject.boundingBox;
            },
            onMapTap: widget.isSelecting ? _selectLocation : null,
            mapObjects: widget.isSelecting
                ? mapObjectCollections
                : mapObjectCollections));
  }
}
