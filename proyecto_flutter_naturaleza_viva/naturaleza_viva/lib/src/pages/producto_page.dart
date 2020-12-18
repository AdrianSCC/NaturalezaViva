import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = ProductosProvider();
  
  

  ProductoModel producto = new ProductoModel();
  File foto;

  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      producto = prodData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: _selecionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child:Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value){
        if(value.length<3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if(utils.isNumeric(value)){
          return null;
        }else{
          return 'Solo numeros';
        }
      },
    );
  }

  _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color:Colors.green,
      label:Text('Guardar'),
      textColor: Colors.white,
      icon: Icon(Icons.save),
      onPressed: _submit,
      
    );
  }

  void _submit()async {
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if(foto != null){
      var respuesta = await _subirFirebase();
    }

    print(producto.fotoUrl);
    if(producto.id == null){
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.editarProducto(producto);
    }

    mostrarSnackbar('Registro Guardado');
    Navigator.pop(context);
  }

  _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      onChanged: (value) => setState((){
        producto.disponible=value;
      }),
      activeColor: Colors.green,
    );
  }

  void mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500)
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto() {
    if (producto.fotoUrl != null) {
 
      return Image(image: NetworkImage(producto.fotoUrl));
 
    } else {
 
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  void _selecionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origin) async {

    foto = await ImagePicker.pickImage(
      source: origin
    );

    if(foto != null){
      //_subirFirebase();
    }

    setState(() {
      
    });

  }

  //alternativa
  /*_processImage(ImageSource origin) async {
    final _picker = ImagePicker();
 
    final pickedFile = await _picker.getImage(
      source: origin,
    );
    
    foto = File(pickedFile.path);
 
    if (foto != null) {
      producto.fotoUrl = null;
    }
 
    setState(() {});
  }*/

  Future<bool> _subirFirebase() async{
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('imagenes');
      
      var today = DateTime.now();
      
      //firebase_storage.UploadTask subida = 
        //ref.child(today.toString()+'.jpg').putFile(foto);
      firebase_storage.UploadTask uploadTask = ref.child(today.toString()+'.jpg').putFile(foto);

      // var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      // url = dowurl.toString();
      String url;

      final espera = await uploadTask.whenComplete(() async{
        try{
          url = await ref.child(today.toString()+'.jpg').getDownloadURL();
        }catch(onError){
          print("Error");
        }
      });

      producto.fotoUrl = url;

      return true;

      // ignore: deprecated_member_use
      // var star = ref.child(nombre).getName();
      // print(star);
     /* star.getDownloadURL().then((url) {
        print('definitiva -> '+url);
        print('definitiva -> '+url);
      });*/
      

        // Returns a Uri of the form gs:
        //bucket/path that can be used 
        // in future calls to getReferenceFromUrl to perform additional 
        // actions 
        
      // firebase_storage.Reference dateRef = ref.child(nombre); 
      // String url = dateRef.toString();
      // print(" Esta es la url -> "+url);
      
      //var imagenUrl = await ref.getDownloadURL();

      //String url = imagenUrl.toString();
      //producto.fotoUrl = url;
  }
}


// _mostrarFoto() {
 
//     if (producto.fotoUrl != null) {
 
//       return Container();
 
//     } else {
 
//       if( foto != null ){
//         return Image.file(
//           foto,
//           fit: BoxFit.cover,
//           height: 300.0,
//         );
//       }
//       return Image.asset('assets/no-image.png');
//     }
//   }