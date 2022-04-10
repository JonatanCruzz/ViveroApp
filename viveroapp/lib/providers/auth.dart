import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

//esta clase es para la autenticacion de correso y contraseñas de los usuarios
class Auth with ChangeNotifier {
  String _token;
  DateTime _expirydDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expirydDate != null &&
        _expirydDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  //verificar si es un usuario autentico
  Future<void> _authenticate(
      String email, String password, String urlSegmento) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegmento?key=AIzaSyD3O5lDO1Vtm1uj82hzuzAivB-4LVrAcPw';
    try {
      //manejo de errores, por ejemplo, se digito el email mal o la password.
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true},
          ));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expirydDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
