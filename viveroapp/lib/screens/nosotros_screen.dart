import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';

class NosotrosScreen extends StatelessWidget {
  static const routeName = "nosotros-screen";

  @override
  Widget build(BuildContext context) {
    Widget buildTitleText(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget buildBodyText(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    void whatsappOpen() async {
      await FlutterLaunch.launchWhatsapp(
          phone: '8098483736', message: 'Quiero ver que tal todo.');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de nosotros'),
      ),
      body: SingleChildScrollView(
        //aqui empiezo a trabajar ya con la parte estetica de acerca de nosotros y tambien con los datos
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                'images/logovivero.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              //empiezo a trabajar con la parte del contacto por email
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTitleText('Contacto'),
                buildBodyText(
                    'Cualquier pregunta o duda, puede enviarnos un mail a: '),
                InkWell(
                  onTap: () {
                    launch(
                        "mailto:<cruzjonatan437@gmail.com>?subject=Quiero comprar una planta");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'cruzjonatan437@gmail.com',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                buildBodyText('o un Whatapp: '),
                GestureDetector(
                  onTap: () {
                    whatsappOpen(); //una funcion creada hace un tiempo atras
                  },
                  child: Container(
                    height: 40,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Whatsapp',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                buildBodyText(''),
                buildTitleText('Ubicación:'),
                buildBodyText('Navarrete/Villa Tabacalera/Calle #7'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
