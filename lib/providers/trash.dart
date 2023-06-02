import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:trashClean/models/place_location.dart';

class Trash with ChangeNotifier {
  final String id;
  String title;
  final String description;
  String imageUrl;
  PlaceLocation location;
  bool isFavorite;
  bool isCleaned;

  Trash(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.location,
      this.isFavorite = false,
      this.isCleaned = false});

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://my-project-52730-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      await http.put(
        Uri.parse(url),
        body: json.encode(
          isFavorite,
        ),
      );
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }

  void cleaningTrash() {
    isCleaned = !isCleaned;
    notifyListeners();
  }
}
