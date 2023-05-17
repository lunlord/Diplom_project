import 'package:flutter/material.dart';
import './trash.dart';

class TrashProvider with ChangeNotifier {
  List<Trash> _items = [
    Trash(
      id: '1',
      title: 'большая куча',
      description:
          'находится в Ленинском р-неaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      imageUrl:
          'https://avatars.mds.yandex.net/i?id=2a00000188114365d2e08740aaf5ee7df41e-1633790-fast-images&n=13',
    ),
    Trash(
      id: '2',
      title: 'небольшая куча',
      description: 'находится в Фрунзенском р-не',
      imageUrl:
          'https://mkset.ru/attachments/0a1b2084d5e8c1fef9fef0ec9eef5754c5177617/store/crop/0/120/1280/720/1280/720/0/02b86ce4bea0b19bef62e389628e4c642184ee1f03674238e8280efdc715/1683806505088.jpg',
    ),
    Trash(
      id: '3',
      title: 'небольшая, около Киномакса',
      description: 'находится в Ленинском р-не',
      imageUrl: 'https://images.kinomax.ru/800/news/2018/05/290510_845951.jpg',
    ),
  ];
  var _showFavoritesOnly = false;

  List<Trash> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items.where((element) => element.isCleaned != true).toList()];
  }

  List<Trash> get favoritesTrash {
    return _items.where((element) => element.isFavorite).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addTrash(Trash trash) {
    final newTrash = Trash(
        id: DateTime.now().toString(),
        title: trash.title,
        description: trash.description,
        imageUrl: trash.imageUrl);
    _items.add(newTrash);
    notifyListeners();
  }

  Trash getTrashById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void removeSingleFavorite(String id) {
    Trash one_trash = getTrashById(id);
    if (one_trash.isFavorite) {
      one_trash.isFavorite = false;
    } else
      return;
    notifyListeners();
  }

  Trash findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void updateTrash(String id, Trash newTrash) {
    final trashIndex = _items.indexWhere((element) => element.id == id);
    if (trashIndex >= 0) {
      _items[trashIndex] = newTrash;
      notifyListeners();
    }
  }

  void deleteTrash(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
