import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/plantas.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = 'edit-products-screen';

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  /*esto es para que cuando estemos escribiendo en TextField y querramos pasar al siguiente campo cuando pulsemos el boton 
  de "enviar" salte a la siguiente linea*/

  final _priceFocusNode = FocusNode(); //precio
  final _descripcionFocusNode = FocusNode(); //descripcion
  final _mantenimientoFocusNode = FocusNode(); //mantenimiento
  final _telefonoFocusNode = FocusNode(); //telefono
  final _whatsappFocusNode = FocusNode(); //whatsapp
  final _imageUrl01Controller = TextEditingController(); //imagen1
  final _imageUrl02Controller = TextEditingController(); //imagen2
  final _imageUrl03Controller = TextEditingController(); //imagen3
  final _imageUrl01FocusNode = FocusNode(); //imagen1 saltar de linea
  final _imageUrl02FocusNode = FocusNode(); //imagen2 saltar de linea
  final _imageUrl03FocusNode = FocusNode(); //imagen3 saltar de linea
  final _form = GlobalKey<FormState>();

  var _editedProduct = Products(
    id: null,
    title: '',
    description: '',
    precio: '',
    mantenimiento: '',
    telefono: '',
    telefonoWhatsapp: 0,
    imageUrl01: '',
    imageUrl02: '',
    imageUrl03: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'precio': '',
    'mantenimiento': '',
    'telefono': '',
    'telefonoWhatsapp': '',
    'imageUrl01': '',
    'imageUrl02': '',
    'imageUrl03': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrl01FocusNode.addListener(_updateImageUrl01);
    _imageUrl02FocusNode.addListener(_updateImageUrl02);
    _imageUrl03FocusNode.addListener(_updateImageUrl03);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //para saber a que producto es deseamos editar
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Plantas>(context, listen: false).findByID(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'precio': _editedProduct.precio,
          'mantenimiento': _editedProduct.mantenimiento,
          'telefono': _editedProduct.telefono,
          'telefonoWhatsapp': _editedProduct.telefonoWhatsapp.toString(),
        };
        _imageUrl01Controller.text = _editedProduct.imageUrl01;
        _imageUrl02Controller.text = _editedProduct.imageUrl02;
        _imageUrl03Controller.text = _editedProduct.imageUrl03;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl01() {
    if (!_imageUrl01FocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _updateImageUrl02() {
    if (!_imageUrl02FocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _updateImageUrl03() {
    if (!_imageUrl03FocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _safeForm() async {
    _form.currentState.save(); //salvar los datos de las plantas
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Plantas>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Plantas>(context, listen: false)
            .addProduct(_editedProduct); //añadir el producto
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Ocurrio un error'),
                  content: Text('Algo esta mal'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okey'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    )
                  ],
                ));
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
        actions: <Widget>[
          IconButton(
            //boton de salvado (temporalmente)
            icon: Icon(Icons.save),
            onPressed: _safeForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form, //key del form que creé
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Título de la planta',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                            _descripcionFocusNode); //esto es para saltar a la siguiente linea
                      },
                      onSaved: (value) {
                        //salvado
                        _editedProduct = Products(
                          id: _editedProduct.id,
                          title: value,
                          description: _editedProduct.description,
                          precio: _editedProduct.precio,
                          mantenimiento: _editedProduct.mantenimiento,
                          telefono: _editedProduct.telefono,
                          telefonoWhatsapp: _editedProduct.telefonoWhatsapp,
                          imageUrl01: _editedProduct.imageUrl01,
                          imageUrl02: _editedProduct.imageUrl02,
                          imageUrl03: _editedProduct.imageUrl03,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Descripción de la planta',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      maxLines: 3,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      focusNode:
                          _descripcionFocusNode, //esto es para saltar a la siguiente linea
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                            _priceFocusNode); //esto es para saltar a la siguiente linea
                      },
                      onSaved: (value) {
                        //salvado
                        _editedProduct = Products(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value,
                          precio: _editedProduct.precio,
                          mantenimiento: _editedProduct.mantenimiento,
                          telefono: _editedProduct.telefono,
                          telefonoWhatsapp: _editedProduct.telefonoWhatsapp,
                          imageUrl01: _editedProduct.imageUrl01,
                          imageUrl02: _editedProduct.imageUrl02,
                          imageUrl03: _editedProduct.imageUrl03,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['precio'],
                      decoration: InputDecoration(
                        labelText: 'Precio de la planta',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      focusNode:
                          _priceFocusNode, //esto es para saltar a la siguiente linea
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                            _mantenimientoFocusNode); //esto es para saltar a la siguiente linea
                      },
                      onSaved: (value) {
                        //salvado
                        _editedProduct = Products(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          precio: value,
                          mantenimiento: _editedProduct.mantenimiento,
                          telefono: _editedProduct.telefono,
                          telefonoWhatsapp: _editedProduct.telefonoWhatsapp,
                          imageUrl01: _editedProduct.imageUrl01,
                          imageUrl02: _editedProduct.imageUrl02,
                          imageUrl03: _editedProduct.imageUrl03,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['mantenimiento'],
                      decoration: InputDecoration(
                        labelText: 'Mantenimiento de la planta',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      maxLines: 3,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      focusNode:
                          _mantenimientoFocusNode, //esto es para saltar a la siguiente linea
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_telefonoFocusNode);
                      },
                      onSaved: (value) {
                        //salvado
                        _editedProduct = Products(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          precio: _editedProduct.precio,
                          mantenimiento: value,
                          telefono: _editedProduct.telefono,
                          telefonoWhatsapp: _editedProduct.telefonoWhatsapp,
                          imageUrl01: _editedProduct.imageUrl01,
                          imageUrl02: _editedProduct.imageUrl02,
                          imageUrl03: _editedProduct.imageUrl03,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['telefono'],
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      focusNode:
                          _telefonoFocusNode, //esto es para saltar a la siguiente linea
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_whatsappFocusNode);
                      },
                      onSaved: (value) {
                        //salvado
                        _editedProduct = Products(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          precio: _editedProduct.precio,
                          mantenimiento: _editedProduct.mantenimiento,
                          telefono: value,
                          telefonoWhatsapp: _editedProduct.telefonoWhatsapp,
                          imageUrl01: _editedProduct.imageUrl01,
                          imageUrl02: _editedProduct.imageUrl02,
                          imageUrl03: _editedProduct.imageUrl03,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['telefonoWhatsapp'],
                      decoration: InputDecoration(
                        labelText: 'Whatsapp',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      focusNode:
                          _whatsappFocusNode, //esto es para saltar a la siguiente linea
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_imageUrl01FocusNode);
                      },
                      onSaved: (value) {
                        //salvado
                        _editedProduct = Products(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          precio: _editedProduct.precio,
                          mantenimiento: _editedProduct.mantenimiento,
                          telefono: _editedProduct.telefono,
                          telefonoWhatsapp: int.parse(value),
                          imageUrl01: _editedProduct.imageUrl01,
                          imageUrl02: _editedProduct.imageUrl02,
                          imageUrl03: _editedProduct.imageUrl03,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    //aqui empiezo a trabajar para la parte de las imagenes
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.yellowAccent,
                            ),
                          ),
                          child: _imageUrl01Controller.text.isEmpty
                              ? Text('Ingrese un Url')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrl01Controller.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Image01 Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrl01Controller,
                            focusNode: _imageUrl01FocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_imageUrl02FocusNode);
                            },
                            onSaved: (value) {
                              //salvado
                              _editedProduct = Products(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                precio: _editedProduct.precio,
                                mantenimiento: _editedProduct.mantenimiento,
                                telefono: _editedProduct.telefono,
                                telefonoWhatsapp:
                                    _editedProduct.telefonoWhatsapp,
                                imageUrl01: value,
                                imageUrl02: _editedProduct.imageUrl02,
                                imageUrl03: _editedProduct.imageUrl03,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.yellowAccent,
                            ),
                          ),
                          child: _imageUrl02Controller.text.isEmpty
                              ? Text('Ingrese un Url')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrl02Controller.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Image02 Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrl02Controller,
                            focusNode: _imageUrl02FocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_imageUrl03FocusNode);
                            },
                            onSaved: (value) {
                              //salvado
                              _editedProduct = Products(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                precio: _editedProduct.precio,
                                mantenimiento: _editedProduct.mantenimiento,
                                telefono: _editedProduct.telefono,
                                telefonoWhatsapp:
                                    _editedProduct.telefonoWhatsapp,
                                imageUrl01: _editedProduct.imageUrl01,
                                imageUrl02: value,
                                imageUrl03: _editedProduct.imageUrl03,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.yellowAccent,
                            ),
                          ),
                          child: _imageUrl03Controller.text.isEmpty
                              ? Text('Ingrese un Url')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrl03Controller.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Image03 Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrl03Controller,
                            focusNode: _imageUrl03FocusNode,
                            onFieldSubmitted: (_) {
                              _safeForm(); //llamado de la funcion de guardado
                            },
                            onSaved: (value) {
                              //salvado
                              _editedProduct = Products(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                precio: _editedProduct.precio,
                                mantenimiento: _editedProduct.mantenimiento,
                                telefono: _editedProduct.telefono,
                                telefonoWhatsapp:
                                    _editedProduct.telefonoWhatsapp,
                                imageUrl01: _editedProduct.imageUrl01,
                                imageUrl02: _editedProduct.imageUrl02,
                                imageUrl03: value,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
