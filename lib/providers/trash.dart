import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Trash with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  bool isFavorite;
  bool isCleaned;

  Trash(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      this.isFavorite = false,
      this.isCleaned = false});

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://my-project-52730-default-rtdb.firebaseio.com/trash/$id.json';
    try {
      await http.patch(
        Uri.parse(url),
        body: json.encode({
          'isFavorite': isFavorite,
        }),
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
