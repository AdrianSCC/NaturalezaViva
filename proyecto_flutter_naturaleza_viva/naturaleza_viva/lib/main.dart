import 'package:flutter/material.dart';
import 'package:naturaleza_viva/src/bloc/provider_bloc.dart';
import 'package:naturaleza_viva/src/pages/ficha_edicion.dart';
import 'package:naturaleza_viva/src/pages/ficha_page.dart';
import 'package:naturaleza_viva/src/pages/home_page.dart';
import 'package:naturaleza_viva/src/pages/login_page.dart';
import 'package:naturaleza_viva/src/pages/mapa.dart';
import 'package:naturaleza_viva/src/pages/registro_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'ficha',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'registro' : (BuildContext context) => RegistroPage(),
          'ficha' : (BuildContext context) => FichaPage(),
          'edicion' : (BuildContext context) => FichaEdicionPage(),
          'mapa' : (BuildContext context) => Mapa(),
        },
        theme: ThemeData(
          primaryColor: Colors.teal[600]
        ),
      ),
    );
  }
}