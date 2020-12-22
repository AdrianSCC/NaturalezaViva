import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturaleza_viva/src/model/animal_model.dart';
import 'package:naturaleza_viva/src/providers/animales_provider.dart';

class FichaEdicionPage extends StatefulWidget {

  @override
  _FichaEdicionPageState createState() => _FichaEdicionPageState();
}

class _FichaEdicionPageState extends State<FichaEdicionPage> {
  AnimalModel animal;
  final formKey = GlobalKey<FormState>();
  final animalProvider = new AnimalesProvider();
  File foto;

  @override
  Widget build(BuildContext context) {

    final List<dynamic> argumentos = ModalRoute.of(context).settings.arguments;
    final int modo = argumentos[0];
    if(modo == 1){
      animal = argumentos[1];
    }else{
      animal = new AnimalModel();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha'),
        actions: [
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: _selecionarFoto,),
          IconButton(icon: Icon(Icons.camera_alt),onPressed: _tomarFoto,),
          IconButton(icon: Icon(Icons.save, size: 30,), onPressed: (){_botonGuardar();}),
          IconButton(icon: Icon(Icons.cancel, size: 30,), onPressed: (){Navigator.pushNamed(context, 'home');}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: _contenido(modo, context),
          ), 
        ),
      ),
    );
  }

  _contenido(int modo, BuildContext context) {
    if(modo==1){
      //_setteoPruebas(animal);
      return Column(
        children: [
          _mostrarFoto(),
          _formulario('Nombre', animal.nombre),
          _formulario('Especie', animal.especie),
          _formulario('Raza', animal.raza),
          _formulario('Estado', animal.estado),
          _formulario('Dieta', animal.dieta),
          _formPeso('Peso', animal.peso.toString()),//campo nunmerico
          _formulario('Habitat', animal.habitat),
          _formulario('Anotaciones', animal.anotaciones),
        ],
      );
    }else{
      return Column(
        children: [
          _mostrarFoto(),
          _formulario('Nombre', ''),
          _formulario('Especie', ''),
          _formulario('Raza', ''),
          _formulario('Estado', ''),
          _formulario('Dieta', ''),
          _formulario('Peso', ''),//campo nunmerico
          _formulario('Habitat', ''),
          _formulario('Anotaciones', ''),
        ],
      );
    }
  }

  _mostrarFoto(){
    if(animal.fotoPrincipal != null){
      return Image(image: NetworkImage(animal.fotoPrincipal));
    }else{
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/Logo_sinTitulo.png');
    }
  }

  void _setteoPruebas(AnimalModel animal) {
    animal.qr = "codigoqr animal";
    animal.nombre = 'Perro';
    animal.raza = 'lince';
    animal.especie = 'Iberica';
    animal.estado = 'Bueno';
    animal.dieta = 'Vegetariano';
    animal.habitat = 'Bosque español';
    animal.anotaciones = 'Es un cachorro muy bonito pero del to mamamam aasd re toaijsn';
    animal.peso = 14;
    animal.liberado = true;
    animal.fotoPrincipal = 'https://wwfes.awsassets.panda.org/img/id31_cachorros_de_odrina_3__antonio_liebana_104021.jpg';

  }

  _formulario(String titulo, String dato) {

    return TextFormField(
      initialValue: dato,
      textCapitalization: TextCapitalization.sentences,
      readOnly: false,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),

      decoration: InputDecoration(
        labelText: titulo,
        
      ),
      onSaved: (value) => _settearCampos(titulo, value),//(value) => animal.nombre = value,
      validator: (value){
        if(value.length<1){
          return 'Ingrese contenido';
        }else{
          return null;
        }
      },
    );
  }

  _settearCampos(String titulo, String valor) {
    switch (titulo) {
      case 'Nombre':
        animal.nombre = valor;
        break;
      case 'Especie':
        animal.especie = valor;
        break;
      case 'Raza':
        animal.raza = valor;
        break;
      case 'Estado':
        animal.estado = valor;
        break;
      case 'Dieta':
        animal.dieta = valor;
        break;
      case 'Peso':
        animal.peso = double.parse(valor);
        break;
      case 'Habitat':
        animal.habitat = valor;
        break;
      case 'Anotaciones':
        animal.anotaciones = valor;
        break;
      default:
    }
  }

  _formPeso(String titulo, String dato) {

    return TextFormField(
      initialValue: dato,
      textCapitalization: TextCapitalization.sentences,
      readOnly: false,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),

      decoration: InputDecoration(
        labelText: titulo,
        
      ),
      onSaved: (value) => animal.peso = double.parse(value),
      validator: (value){
        if(value.length<3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  _botonGuardar() async{
    //Metodo para editar o guardar en la base de datos
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    if(foto != null){
      var respuesta = await _subirFirebase();
    }

    if(animal.id == ''){
      animalProvider.crearAnimal(animal);
    }else{
      animalProvider.editarAnimal(animal);
    }

    // animalProvider.crearAnimal(animal);
    
  }

  Future<bool> _subirFirebase() async{
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('imagenes');
      var today = DateTime.now();
      firebase_storage.UploadTask uploadTask = ref.child(today.toString()+'.jpg').putFile(foto);
      String url;
      final espera = await uploadTask.whenComplete(() async{
        try{
          url = await ref.child(today.toString()+'.jpg').getDownloadURL();
        }catch(onError){
          print("Error");
        }
      });
      animal.fotoPrincipal = url;
      return true;
  }

  

  void _selecionarFoto() {
    _procesarImagen(ImageSource.gallery);
  }

  void _tomarFoto() {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origin) async {
    final _picker = ImagePicker();
 
    final pickedFile = await _picker.getImage(
      source: origin,
    );
    
    foto = File(pickedFile.path);
 
    if (foto != null) {
      animal.fotoPrincipal = null;
    }
 
    setState(() {});
  }
}

