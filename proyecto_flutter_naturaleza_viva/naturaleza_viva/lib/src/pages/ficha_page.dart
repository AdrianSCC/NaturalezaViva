import 'package:flutter/material.dart';
import 'package:naturaleza_viva/src/model/animal_model.dart';
import 'package:naturaleza_viva/src/providers/animales_provider.dart';
import 'package:naturaleza_viva/src/utils/utils.dart';

class FichaPage extends StatefulWidget {

  @override
  _FichaPageState createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  final animalProvider = new AnimalesProvider();
  AnimalModel animal;

  @override
  Widget build(BuildContext context) {

    final String id = ModalRoute.of(context).settings.arguments;

    //AnimalModel ani = AnimalModel.fromJson(animal);
    //_setteoPruebas(animal);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha'),
        actions: [
          IconButton(icon: Icon(Icons.edit, size: 30,), onPressed: (){Navigator.pushNamed(context, 'edicion', arguments: [modoEdicion, animal],);}),
          IconButton(icon: Icon(Icons.delete, size: 30,), onPressed: (){}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: _crearDatos(id),
        ),
      ),
    );
  }

  _crearDatos(String id){
    return FutureBuilder(
      future: animalProvider.buscarAnimal(id),
      builder: (BuildContext context, AsyncSnapshot<AnimalModel> snapshot){
        if(snapshot.hasData){
          animal = snapshot.data;
          //animal2=animal;
          return Column(
            children: [
              _imagen(context),
              _datos(),//animal),
              _botonSituacion(context, 'Situación'),//, animal.liberado),
              _botonLiberar(context, 'Liberar'),//, animal.liberado),
              
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }

  _imagen(BuildContext context) {

    ImageProvider img;

    if(animal.fotoPrincipal == null){
      img = AssetImage('assets/Logo_sinTitulo.png');
    }else{
      img = NetworkImage(animal.fotoPrincipal);
    }

    final size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/Logo_sinTitulo.png'),
            image: img, //AssetImage('assets/Logo_sinTitulo.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            width: size.width*0.5,
            height: size.height*0.2
          ),
        ],
      )
    );
  }

  _datos() {
    return Container(
      child: Column(
          children: [
            SizedBox( height: 20),
            _filaFicha('QR', animal.id),
            _filaFicha('Nombre', animal.nombre),
            _filaFicha('Especie', animal.especie),
            _filaFicha('Raza', animal.raza),
            _filaFicha('Estado', animal.estado),
            _filaFicha('Dieta', animal.dieta),
            _filaFicha('Peso', animal.peso.toString()+'kg'),
            _filaFicha('Habitat', animal.habitat),
            _filaFicha('Anotaciones', animal.anotaciones),
          ],

        ),
    );
  }

  _filaFicha(String titulo, String res) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  style: estiloTitulo(),
                  children:[
                    TextSpan(text: '$titulo: '),
                    TextSpan(text: res, style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox( height: 20)
      ],
    );
  }

  _botonSituacion(BuildContext context, String s) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width*0.85, height: size.height*0.07,
          child: RaisedButton(
            color: Colors.teal[600],
            child: Container(
              child: Text(s, style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold), ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            elevation: 0,
            textColor: Colors.white,
            onPressed: animal.liberado? () => Navigator.pushNamed(context, 'mapa', arguments: [2, animal]) : null,
          ),
        ),
        SizedBox( height: 20)
      ],
    );
  }

  _botonLiberar(BuildContext context, String s) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width*0.85, height: size.height*0.07,
          child: RaisedButton(
            color: Colors.teal[600],
            child: Container(
              child: Text(s),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            elevation: 0,
            textColor: Colors.white,
            onPressed: animal.liberado? null : () => Navigator.pushNamed(context, 'mapa', arguments: [1, animal]) ,
          ),
        ),
        SizedBox( height: 20)
      ],
    );
  }
}

