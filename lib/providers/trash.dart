import 'package:flutter/foundation.dart';

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

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void cleaningTrash() {
    isCleaned = !isCleaned;
    notifyListeners();
  }
}
