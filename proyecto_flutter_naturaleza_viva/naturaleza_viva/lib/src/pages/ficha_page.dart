import 'package:flutter/material.dart';
import 'package:naturaleza_viva/src/model/animal_model.dart';
import 'package:naturaleza_viva/src/utils/utils.dart';

class FichaPage extends StatelessWidget {

  final animal =new AnimalModel();

  @override
  Widget build(BuildContext context) {

    _setteoPruebas(animal);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha'),
        actions: [
          IconButton(icon: Icon(Icons.edit, size: 30,), onPressed: (){Navigator.pushNamed(context, 'edicion', arguments: modoEdicion);}),
          IconButton(icon: Icon(Icons.delete, size: 30,), onPressed: (){}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              _imagen(context),
              _datos(),
              _botonSituacion(context, 'Situación'),
              _botonLiberar(context, 'Liberar'),
            ],
          ),
        ),
      ),
    );
  }

  _imagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/Logo_sinTitulo.png'),
            image: NetworkImage(animal.fotoPrincipal),//AssetImage('assets/Logo_sinTitulo.png'),
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
            _filaFicha('QR', animal.qr),
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
            onPressed: animal.liberado? () => Navigator.pushNamed(context, 'mapa') : null,
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
            onPressed: animal.liberado? null : () => true ,
          ),
        ),
        SizedBox( height: 20)
      ],
    );
  }

  

  



}

