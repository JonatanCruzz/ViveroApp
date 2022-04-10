import 'package:flutter/material.dart';
import '../screens/plantas_overview_screen.dart';
import '../screens/nosotros_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red,
        child: Column(children: <Widget>[
          AppBar(
            title: Text('Menú'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.shop),
              title: Text('Plantas'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductsOverViewScreen.routeName,
                );
              },
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text('Acerca de nosotros'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  NosotrosScreen.routeName,
                );
              },
            ),
          ),
          Divider(),
          Container(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Director de Productos'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  UserProductScreen.routeName,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
