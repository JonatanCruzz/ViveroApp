import 'package:flutter/material.dart';
import 'package:viveroapp/widgets/plantas_item.dart';
import 'products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Plantas with ChangeNotifier {
  List<Products> _items = [
    Products(
      id: 'a1',
      title: 'Helecho de arroz',
      description:
          'Muy conocida como Helecho arroz o falso helecho de arroz, la Pilea microphylla es una hierba perenne, perteneciente a la familia de las Urticaceae o Urticáceas. Entre sus otros nombres comunes podemos destacar: Lentejita y Planta de artillería o Artillery plant.',
      precio: '100.00',
      mantenimiento: 'Regar cada 7 días. Fertilizar cada 30 días',
      imageUrl01: 'https://static.inaturalist.org/photos/9057734/large.jpg',
      imageUrl02:
          'https://static.wixstatic.com/media/e5082c_04edbfe9bfbf41d49e33115d1152ba54~mv2.jpg/v1/fill/w_720,h_366,al_c,lg_1,q_85/e5082c_04edbfe9bfbf41d49e33115d1152ba54~mv2.jpg',
      imageUrl03:
          'https://enciclovida.mx/fotoweb/cache/5023/Plantas/ME010%20KV%2001538%20_Pilea%20microphylla%20(L.)%20Liebm.%2C%201851_.t60bac296.m2400.wConabioCornerCopy.jpg.xVrjUxnx9X5_jxQ8PzVpB9cnD1FeYn9HlGe4bdQ3J-Wo.JPG',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
    Products(
      id: 'a2',
      title: 'Sunrise',
      description:
          'Son una planta muy demandada, fáciles de cuidar, de especies muy variadas, multitud de tamaños que se ajustan a cualquier espacio y, además, están de moda. Cada vez cuentan con más adeptos y se han convertido en una de las tendencias deco con más permanencia en los primeros puestos.',
      precio: '150.00',
      mantenimiento:
          'Regar cada 14 días y fertilizar cada 90 días. Se necsita luz solar completa parcialmente.',
      imageUrl01:
          'https://paramijardin.s3.fr-par.scw.cloud/2018/09/DSCN8773-001-e1523471873601-770x6001-e1536153552840.jpg',
      imageUrl02:
          'https://paramijardin.s3.fr-par.scw.cloud/2017/11/DSCN8765-001-e1523471480310-800x488.jpg',
      imageUrl03:
          'https://www.panoramaweb.com.mx/u/fotografias/m/2022/1/12/f768x1-19030_19157_66.jpg',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
    Products(
      id: 'a3',
      title: 'Coralillo',
      description:
          'Crece en diversos tipos de selva como selva baja caducifolia, selva mediana sub-perennifolia, selva alta así como en áreas perturbados por ejemplo zonas agrícolas, potreros, acahuales etc. La flor tiene forma de tubo y es de color anaranjada a roja. Estas características de color y forma indican que la flor atrae y es polinizada por colibríes.  El fruto tiene un refrescante sabor ácido, además de ser muy apreciado por algunos pájaros, también son comestibles para los seres humanos, en México se utiliza en una bebida fermentada.',
      precio: '150.00',
      mantenimiento:
          'son bastante sencillos ya que es una planta bastante resistente. Sin embargo, si lo que queremos es que la flor de ixora crezca fuerte y luzca lo más bonita posible, lo mejor será seguir una serie de consejos para mejorar lo más posible todas sus condiciones.',
      imageUrl01:
          'https://www.aboutespanol.com/thmb/N3m752Xaeq47FXV0y1yw0rY47sM=/2102x2102/smart/filters:no_upscale()/606379551-570583525f9b581408c9f26d.jpg',
      imageUrl02:
          'https://upload.wikimedia.org/wikipedia/commons/9/9d/Ixora_coccinea_%28Rubiaceae%29.jpg',
      imageUrl03:
          'https://t2.ev.ltmcdn.com/es/posts/3/4/8/planta_ixora_cuidados_1843_orig.jpg',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
    Products(
      id: 'a4',
      title: 'Croton Petra',
      description:
          'El Crotón Petra es una planta de interior, que presenta diversas formas realmente llamativas.La variedad Codiaeum Variegatum Pictum es el ejemplar más representativo. Sus hojas son rígidas, ovales y de color verde oscuro con nervios de color amarillo y rosa. Necesita por lo general luz brillante. Pero también calor y humedad para desarrollarse.',
      precio: '150.00',
      mantenimiento:
          'Luz: Es una planta que necesita luminosidad, pero puede llegar a afectarle un exceso de sol. La mejor ubicación es cerca de una ventana. Temperatura: No exponer a una temperatura inferior a 16 º C. Riego: Hay que regar la planta con regularidad pero a dosis pequeñas.',
      imageUrl01:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Colpfl05.jpg/1200px-Colpfl05.jpg',
      imageUrl02:
          'https://lahuertoteca.es/wp-content/uploads/2021/01/codiaeum-petra-713.jpg',
      imageUrl03:
          'https://www.infojardineria.es/wp-content/uploads/2020/01/croton-petra.jpg',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
    Products(
      id: 'a5',
      title: 'Croton Mammey',
      description:
          'El Crotón Mammey es un magnífico arbusto de hoja perenne con hojas grandes, de cuero y multicolor. El follaje tiene un borde rizado y forma alargada en comparación con el Croton Petra de hoja ancha y plana.',
      precio: '150.00',
      mantenimiento:
          'Riego abundante cada 3-4 días en verano y semanal en invierno. Importante un buen drenaje. La humedad ambiental tiene que ser muy elevada, por lo que se recomienda vaporizar con regularidad las hojas. Luz garantizada.',
      imageUrl01:
          'https://www.guiadejardineria.com/wp-content/uploads/2019/03/Diferentes-tipos-de-croton-mammy.jpg',
      imageUrl02:
          'https://plantcaretoday.com/wp-content/uploads/croton-mammy-1200-630-FB-06302019-min.jpg',
      imageUrl03:
          'https://guiadejardin.com/wp-content/uploads/2020/10/croton-colores-683x1024.jpg',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
    Products(
      id: 'a6',
      title: 'Mesen rojo',
      description:
          'Es una crasa o suculenta no cactácea de muy rápido crecimiento que se utiliza sobretodo como tapizante, aunque al tener un carácter invasor es más recomendable tenerla en maceta o en una jardinera.',
      precio: '150.00',
      mantenimiento:
          'Regar cada 14 días y fertilizar cada 90 días. Necesita luz solar parcialmente.',
      imageUrl01:
          'https://www.jardineriaon.com/wp-content/uploads/2018/05/Lampranthus_sp.-1024x768.jpg.webp',
      imageUrl02:
          'https://www.guiadejardineria.com/wp-content/uploads/2017/08/cultivo-y-cuidado-del-lamprantus-01.jpg',
      imageUrl03:
          'https://static.wixstatic.com/media/6d019d_c6c4f2765b424e8395a62bba9f55e0d0~mv2.png/v1/fit/w_500,h_500,q_90/file.png',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
    Products(
      id: 'a7',
      title: 'Bejequillo tinerfeño',
      description:
          'Un planta perteneciente a la gran familia de las suculentas, el género aeonium y nativa de las Islas Canarias en Tenerife, fueron introducidas poco a poco en el sur de California y en EEUU por la similitud de climas. Muy demandada para la creación de terrarios, para la creación de alfombras de flores y para decorar jardines de rocallas. Una excelente planta perfecta para decorar y ornamentar cualquier lugar.',
      precio: '150.00',
      mantenimiento:
          'Regar cada 14 días y fertilizar cada 90 días. Necesita luz solar parcialmente.',
      imageUrl01:
          'http://www.consultaplantas.com/images/iconos/plantas_crasas/aeonium_haworthii.jpg',
      imageUrl02:
          'http://www.consultaplantas.com/images/phocagallery/aeonium_haworthii/thumbs/phoca_thumb_l_aeonium_haworthii_2.JPG',
      imageUrl03:
          'http://4.bp.blogspot.com/-zJx1tLU0iF4/TjK7JO2XdVI/AAAAAAAABbM/jBdjly9kFuE/s320/aeonium2.jpg',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
    Products(
      id: 'a8',
      title: 'Planta Antorcha',
      description:
          'Son pequeñas plantas suculentas de porte cubridor que no superan los 20-30 cm de altura. Las hojas son de color verde oscuro, surgen en roseta y miden hasta unos 15 cm de longitud; presentan espinas, tubérculos blancos y cerdas en el ápice. Producen flores tubulares y de color naranja que atraen a las abejas por su néctar. Florecen a principios de verano. Se pueden emplear en rocallas, como cubridoras en zonas secas del jardín, en invernaderos o como planta de interior en macetas poco profundas.',
      precio: '150.00',
      mantenimiento:
          'Regar cada 14 días y fertilizar cada 90 días. Necesita luz solar parcialmente.',
      imageUrl01:
          'https://clubsuculentas.com/wp-content/uploads/2019/09/aloe-aristata-860x538.jpg',
      imageUrl02:
          'https://cibercactus.com/wp-content/uploads/2018/03/aloe-aristata.jpg',
      imageUrl03:
          'https://theoriginalgarden.com/Argazkiak/Fotos/20211128144553.jpg',
      telefono: '+1 809-848-3736',
      telefonoWhatsapp: 18098483736,
    ),
  ];

  List<Products> get items {
    return [..._items];
  }

  List<Products> get favoriteItems {
    return _items.where((prodtItem) => prodtItem.isFavorite).toList();
  }

  Products findByID(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://viveroapp-d0c52-default-rtdb.firebaseio.com/product.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Products> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.insert(
            (0),
            Products(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              precio: prodData['precio'],
              mantenimiento: prodData['mantenimiento'],
              imageUrl01: prodData['imageUrl01'],
              imageUrl02: prodData['imageUrl02'],
              imageUrl03: prodData['imageUrl03'],
              telefono: prodData['telefono'],
              telefonoWhatsapp: prodData['telefonoWhatsapp'],
              isFavorite: prodData['isFavorite'],
            ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Products products) async {
    const url =
        'https://viveroapp-d0c52-default-rtdb.firebaseio.com/product.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'title': products.title,
            'description': products.description,
            'precio': products.precio,
            'mantenimiento': products.mantenimiento,
            'telefono': products.telefono,
            'telefonoWhatsapp': products.telefonoWhatsapp,
            'imageUrl01': products.imageUrl01,
            'imageUrl02': products.imageUrl02,
            'imageUrl03': products.imageUrl03,
            'isFavorite': products.isFavorite,
          }));
      final newProduct = Products(
        title: products.title,
        description: products.description,
        precio: products.precio,
        mantenimiento: products.mantenimiento,
        telefono: products.telefono,
        telefonoWhatsapp: products.telefonoWhatsapp,
        imageUrl01: products.imageUrl01,
        imageUrl02: products.imageUrl02,
        imageUrl03: products.imageUrl03,
        isFavorite: products.isFavorite,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      //_items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Products newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://viveroapp-d0c52-default-rtdb.firebaseio.com/product/$id.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'precio': newProduct.precio,
            'mantenimiento': newProduct.mantenimiento,
            'telefono': newProduct.telefono,
            'telefonoWhatsapp': newProduct.telefonoWhatsapp,
            'imageUrl01': newProduct.imageUrl01,
            'imageUrl02': newProduct.imageUrl02,
            'imageUrl03': newProduct.imageUrl03,
            'isFavorite': newProduct.isFavorite,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProducts(String id) async {
    final url =
        'https://viveroapp-d0c52-default-rtdb.firebaseio.com/product/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var ExistingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, ExistingProduct);
      notifyListeners();
      throw HttpException('No se borro el producto');
    }
    ExistingProduct = null;
  }
}
