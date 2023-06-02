import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yandex_geocoder/yandex_geocoder.dart';

const YANDEX_API_KEY = '8ae45a93-87d0-40bc-a656-66c22681c5fb';
final YandexGeocoder geocoder =
    YandexGeocoder(apiKey: "fa3f82e4-ca72-4231-b677-3f2bb06d434f");

class LocationHelper {
  static String generateLocationPrewiewImage(
      {double latitude, double longitude}) {
    return 'https://static-maps.yandex.ru/1.x/?ll=$longitude,$latitude&spn=0.002,0.002&size=450,450&z=17&l=sat,skl&pt=$longitude,$latitude,pm2bll';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final url =
        'https://geocode-maps.yandex.ru/1.x/?format=json&apikey=c8c98cb8-fd60-4f6d-a945-89f780af5a7d&geocode=$long,$lat';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['response']['GeoObjectCollection']
            ['featureMember'][0]['GeoObject']['metaDataProperty']
        ['GeocoderMetaData']['Address']['formatted'];
  }

// static final YandexGeocoder geocoder = YandexGeocoder(apiKey: '8ae45a93-87d0-40bc-a656-66c22681c5fb');
  // Future getPlaceAddress(double lat, double long) async {

  // return json.decode(geocodeFromPoint.response);
  // }
}
