import 'package:flutter/material.dart';
import '../providers/plantas.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';

//todo esto contiene los detalles despues de haber seleccionado una planta
class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'product-detail-screen';

  @override
  Widget build(BuildContext context) {
    //trabajando ya con la parte de detalle de cada planta
    final productID = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Plantas>(context, listen: false).findByID(productID);

    Widget image_carousel = Container(
      height: 300,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.network(loadedProduct.imageUrl01),
          Image.network(loadedProduct.imageUrl02),
          Image.network(loadedProduct.imageUrl03),
        ],
        autoplay: false,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        dotSize: 4.0,
        dotColor: Colors.red,
        indicatorBgPadding: 4.0,
      ),
    );

    //esa funcion sirve para abrir el whatsapp.
    void WhatsappOpen() async {
      await FlutterLaunch.launchWhatsapp(
          phone: loadedProduct.telefonoWhatsapp.toString(),
          message: "¿Qué tal? me interesa essta planta ${loadedProduct.title}");
    }

    //esta funcion sirve para llamar a al dueño.
    void _launchCaller(String numero) async {
      var url = "teléfono: ${numero.toString()}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "No se pudo realizar la llamada.";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: ListView(
        children: <Widget>[
          image_carousel,
          SizedBox(
            height: 10,
          ),
          //trabajando con todo lo referente a los datos de las plantas
          Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.attach_money), //precio de la planta
                Text(
                  loadedProduct.precio,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              'DESCRIPCION',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            //descripcion de la planta
            color: Colors.yellow,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Text(
              loadedProduct.description,
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ),
          Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              'Mantenimiento',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            //empiezo a trabajar con el mantenimiento de la planta
            color: Colors.yellow,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Text(
              loadedProduct.mantenimiento,
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //empiezo a trabajar con la parte de contacto
            color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              'CONTACTO',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            //empiezo a trabajar con el boton telefono
            child: Row(children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
              ),
              IconButton(
                //icono del telefono
                icon: Icon(Icons.call),
                color: Colors.green,
                onPressed: () {
                  _launchCaller(loadedProduct.telefono);
                },
              ),
              Text('Teléfono: '),
              Text(loadedProduct.telefono),
              Expanded(
                //empiezo a trabajar con el boton de whatsapp
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      WhatsappOpen(); //una funcion creada hace un tiempo atras
                    },
                    child: Container(
                      height: 40,
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
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
