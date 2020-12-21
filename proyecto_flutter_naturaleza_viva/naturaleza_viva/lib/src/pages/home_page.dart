import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:naturaleza_viva/src/bloc/provider_bloc.dart';
import 'package:naturaleza_viva/src/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _logo(context),
            _botones(context),
          ],
        ),
      ),
    );
  }

  _logo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.height*0.4,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Image(image: AssetImage('assets/Logo.png'))
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  _botones(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:20),
      child: Table(
        children: [
          TableRow(
            children: [
              _boton(Icons.chat, 'Chat', context, 'login'),
              _boton(Icons.qr_code_scanner, 'Escanear',context, 'qr')
            ]
          ),
          TableRow(
            children: [
              _boton(Icons.calendar_today, 'Agenda',context, 'registro'),
              _boton(Icons.save, 'Crear ficha',context, 'ficha')
            ]
          ),
        ],
      ),
    );
  }

  _boton(IconData icono, String titulo, BuildContext context, String direccion) {

    
    return Container(
      height: 180,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        //color: Colors.brown[100],
        color: Colors.teal[600].withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white.withOpacity(0),
              child: Icon(icono, color: Colors.white, size: 70,),
            ),
            Text(titulo, style: estiloTitulo()),
          ],
        ),
        onTap:()async{
          switch (direccion) {
            case 'qr':
                 String lectura = await FlutterBarcodeScanner.scanBarcode('#2c5243', 'Cancelar', false, ScanMode.QR);
                  // Si hemos leido un codigo qr y no hemos cancelado
                 if(lectura != '-1'){
                    print(lectura);
                    Navigator.pushNamed(context, 'ficha', arguments: ['prueba']);
                 }
              break;
            case 'chat':
                 Navigator.pushNamed(context, direccion);
              break;
            case 'agenda':
                 Navigator.pushNamed(context, direccion);
              break;
            case 'ficha':
                 Navigator.pushNamed(context, 'edicion', arguments: modoNuevo);
              break;
            default:
          }
        },
      ),
    );
  }


  

}