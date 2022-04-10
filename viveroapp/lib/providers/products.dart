import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//todo esto es la descripcion y todo lo que tendran las plantas, variables que identificaran a las plantas, de forma resumida
class Products with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String precio;
  final String mantenimiento;
  final String imageUrl01;
  final String imageUrl02;
  final String imageUrl03;
  final String telefono;
  final int telefonoWhatsapp;
  bool isFavorite;

  Products(
      {@required this.id = "",
      @required this.title = "",
      @required this.description = "",
      @required this.precio = "",
      @required this.mantenimiento = "",
      @required this.imageUrl01 = "",
      @required this.imageUrl02 = "",
      @required this.imageUrl03 = "",
      @required this.telefono = "",
      @required this.telefonoWhatsapp = 0,
      this.isFavorite = false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoritosStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://viveroapp-d0c52-default-rtdb.firebaseio.com/product/$id.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
