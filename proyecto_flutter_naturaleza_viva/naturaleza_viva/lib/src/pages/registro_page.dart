import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _logo(size),
              _formulario(size),
              //_boton('Acceso'),
              //_boton('Registro'),
            ],
          )
        ),
      )
    );
  }

  _logo(Size size) {
    return Container(
      child: SafeArea(
        child: Center(
          child: Container(
            width: size.height*0.25,
            padding: EdgeInsets.all(20),
            child: Image(
              image: AssetImage('assets/Logo_sinTitulo.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            )
          ),
        ),
      ),
      color: Colors.white,
    );
  }

  _formulario(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical:10),
      width: size.width*0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            spreadRadius: 3.0
          )
        ]
      ),
      child: Column(
        children: [
          SizedBox( height: 20),
          Text('REGISTRO', style:TextStyle(
            fontSize: 25, 
            color: Colors.teal[600],
            fontWeight: FontWeight.bold,
            )),
            _crearNombre(),
           _crearEmail(),
           _crearPassword(),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _boton('Registrarse'),),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _boton('Registrarse con Google'),),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _boton('Registrarse con Twitter'),),
           SizedBox( height: 20),

        ],
      ),
    );
  }

  _crearEmail() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.email, color: Colors.green[900]),
          hintText: 'ejemplo@ejemplo.com',
          labelText: 'Correo Electronico',
        ),
      ),
    );   
  }
  _crearNombre() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.supervised_user_circle, color: Colors.green[900]),
          hintText: 'Nombre',
          labelText: 'Nombre',
        ),
      ),
    );   
  }

  _crearPassword() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.green[900]),
          fillColor: Colors.green[900],
          hintText: '******',
          labelText: 'Password',
        ),
      ),
    );
    
  }

  

  _boton(String s) {

    return RaisedButton(
      color: Colors.teal[600],
      child: Container(
        child: Text(s),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      elevation: 0,
      textColor: Colors.white,
      onPressed: (){
        if(s == "Acceder"){
          //Navigator.pushReplacementNamed(contextLogin, 'home');
        }else{
          //Navigator.pushNamed(contextLogin, 'registro');
        }
      },
    );
  }
}