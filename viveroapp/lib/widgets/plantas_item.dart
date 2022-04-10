import 'package:flutter/material.dart';
import 'package:viveroapp/providers/plantas.dart';
import 'package:viveroapp/screens/plantas_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

//todo esto contiene todo lo referente a las plantas y como se ven las imagenes, etc.
class ProductItem extends StatelessWidget {
//aqui es donde le doy el formato a las imagenes
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            //me envia a la pantalla de detalles de las plantas
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product
                  .id, //me redirecciona a la pantalla de la planta segun su id
            );
          },
          //imagenes de las plantas
          child: Image.network(
            product.imageUrl01,
            fit: BoxFit.cover,
          ),
        ),
        footer: Container(
          height: 40,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            //icono de favorito
            leading: Consumer<Products>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoritosStatus();
                },
              ),
            ),
            title: Text(
              product.title,
              style: TextStyle(fontSize: 15),
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
            trailing: Row(
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                ),
                Text(
                  product.precio,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
