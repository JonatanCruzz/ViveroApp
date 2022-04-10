import 'package:flutter/material.dart';
import 'package:viveroapp/screens/plantas_overview_screen.dart';
import '../screens/plantas_overview_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

//todo esto tiene que ver con el login de la aplicacion
class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  selectProductsOvewview(BuildContext context) {
    Navigator.of(context).pushNamed(ProductsOverViewScreen.routeName);
  }

//este container es el que muestra la imagen de fondo del login
  final background = Container(
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage('images/fondoprincipal.jpg'),
      fit: BoxFit.cover,
    )),
  );

//una opacidad para que no se vea tanto la imagen de fondo
  final whiteOpacity = Container(
    color: Colors.white24,
  );

//logo del vivero
  final logo = Image.asset(
    'images/logovivero.png',
    width: 300,
    height: 300,
  );

//todo esto contiene el formatdo de como se ve el fondo del login y el logo del vivero y el boton de entrar a la app
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          whiteOpacity,
          SingleChildScrollView(
            child: Container(
              height: devicesize.height,
              width: devicesize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SafeArea(
                    child: Column(
                      children: <Widget>[
                        logo,
                      ],
                    ),
                  ),
                  Flexible(
                    flex: devicesize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Clase para la autenticacion y login
class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Ocurrió un error'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        //Login user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        //Sign up user
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      //los posibles errores que pueden ocurrir
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Este correo electrónico ya existe.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Correo electrónico incorrecto.';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Esta contraseña es muy débil.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Este correo electrónico no existe.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Contraseña incorrecta.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'No se pudo autentificar, intente de nuevo más tarde';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: devicesize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            //esto es para que no se desaparezca el teclado virtual
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Correo electrónico invalido.';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  controller: _passwordController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'La contraseña introducida es muy corta.';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration:
                        InputDecoration(labelText: 'Confirmar contraseña'),
                    obscureText: true,
                    // ignore: missing_return
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'La contraseña no coinciden.';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(_authMode == AuthMode.Login
                        ? 'Inicio de Sesión'
                        : 'Crear Cuenta'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 8.0,
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'Crear' : 'Iniciar con una '} cuenta'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 4.0,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
