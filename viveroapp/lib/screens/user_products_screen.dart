import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plantas.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_products_screen.dart';

/*Todo esto tiene que ver con la ceracion del Directivo de productos para que asi no sea necesario estar copiando y pegando codigo
sino que se pueda edita y agregar desde la misma aplicacion cualquier producto*/
class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-products-screen';

  @override
  Widget build(BuildContext context) {
    final produdctsData = Provider.of<Plantas>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Director de productos'),
        actions: <Widget>[
          IconButton(
            //icono para añadir un nuevo producto
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: produdctsData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      produdctsData.items[i].id,
                      produdctsData.items[i].title,
                      produdctsData.items[i].imageUrl01,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                )),
      ),
    );
  }
}
