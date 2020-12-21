import 'package:flutter/material.dart';
import 'package:naturaleza_viva/src/model/animal_model.dart';
import 'package:naturaleza_viva/src/providers/animales_provider.dart';

class FichaEdicionPage extends StatefulWidget {

  @override
  _FichaEdicionPageState createState() => _FichaEdicionPageState();
}

class _FichaEdicionPageState extends State<FichaEdicionPage> {
  final animal =new AnimalModel();
  final formKey = GlobalKey<FormState>();
  final animalProvider = new AnimalesProvider();

  @override
  Widget build(BuildContext context) {

    final int modo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha'),
        actions: [
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
      _setteoPruebas(animal);
      return Column(
        children: [
          _imagen(context, NetworkImage(animal.fotoPrincipal)),
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
          _imagen(context, AssetImage('assets/Logo_sinTitulo.png')),
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

  _imagen(BuildContext context, ImageProvider img) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/Logo_sinTitulo.png'),
            image: img,//AssetImage('assets/Logo_sinTitulo.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            width: size.width*0.5,
            height: size.height*0.2
          ),
        ],
      )
    );
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

  _botonGuardar() {
    //Metodo para editar o guardar en la base de datos
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print(animal.estado);
    print(animal.peso);

    animalProvider.crearAnimal(animal);
    
  }

  
}

