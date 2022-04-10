import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/plantas_overview_screen.dart';
import './screens/plantas_details_screen.dart';
import './providers/plantas.dart';
import 'package:provider/provider.dart';
import './screens/nosotros_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_products_screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Plantas(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ViveroApp',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: auth.isAuth ? ProductsOverViewScreen() : HomeScreen(),
          routes: {
            //donde se colocan las pantallas, es decir, las rutas
            HomeScreen.routeName: (ctx) => HomeScreen(),
            ProductsOverViewScreen.routeName: (ctx) => ProductsOverViewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            NosotrosScreen.routeName: (ctx) => NosotrosScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductsScreen.routeName: (ctx) => EditProductsScreen(),
          },
        ),
      ),
    );
  }
}
