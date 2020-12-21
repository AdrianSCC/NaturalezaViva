import 'package:flutter/material.dart';

final int modoEdicion = 1;
final int modoNuevo = 2;

bool isNumeric(String s){
  if(s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n==null) ? false : true;
}

TextStyle estiloTitulo(){
  return TextStyle(
    fontSize: 25, 
    color: Colors.teal[600],
    fontWeight: FontWeight.bold,
    );
}

void mostrarAlerta(BuildContext context, String mensaje){

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('Informacion Incorrecta'),
        content: Text(mensaje),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }
  );
}