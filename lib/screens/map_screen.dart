import 'package:flutter/material.dart';
import 'package:trashClean/screens/trash_detail_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart';
import '../models/place_location.dart';
import '../providers/trash.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  final List<Trash> trashList;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
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
            image: BitmapDescriptor.fromAssetImage(
                'assets/images/location1.png')))));
  }

  List<MapObject> mapObjectCollections = [];

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
                        onTap: (mapObject, point) => Navigator.of(context)
                            .pushNamed(TrashDetailScreen.routeName,
                                arguments: widget.trashList[i].id),
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
            onMapTap: widget.isSelecting ? _selectLocation : null,
            mapObjects: widget.isSelecting
                ? mapObjectCollections
                : mapObjectCollections));
  }
}
