import 'package:flutter/material.dart';
import 'package:naturaleza_viva/src/bloc/provider_bloc.dart';
import 'package:naturaleza_viva/src/utils/utils.dart';

class LoginPage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _logo(),
              _formulario(size, context),
              //_boton('Acceso'),
              //_boton('Registro'),
            ],
          )
        ),
      )
    );
  }

  _logo() {
    return Container(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Image(image: AssetImage('assets/Logo.png'))
        ),
      ),
      color: Colors.white,
    );
  }

  _formulario(Size size, BuildContext context) {

    final bloc = Provider.of(context);

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
          Text('ACCESO', style:estiloTitulo()),
           _crearEmail(bloc),
           _crearPassword(bloc),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _botonAcceso(bloc),),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _boton('Registrarse', context),),
           SizedBox( height: 20),

        ],
      ),
    );
  }

  _crearEmail(LoginBloc bloc) {


    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.green[900]),
              hintText: 'ejemplo@ejemplo.com',
              labelText: 'Correo Electronico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    ); 
  }

  _crearPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.security_rounded, color: Colors.green[900]),
              hintText: '******',
              labelText: 'Password',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  _botonAcceso(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          color: Colors.teal[600],
          child: Container(
            child: Text('Acceder'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          elevation: 0,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(context, bloc) : null,
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) async{

    Navigator.pushReplacementNamed(context, 'home');

    // Map info = await usuarioProvider.login(bloc.email, bloc.password);

    // if(info['ok']){
    //   Navigator.pushReplacementNamed(context, 'home');
    // }else{
    //   mostrarAlerta(context, 'Los datos introducidos son incorrectos');
    // }

  }

  

  _boton(String s, BuildContext context) {

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
          Navigator.pushNamed(context, 'home');
        }else{
          Navigator.pushNamed(context, 'registro');
        }
      },
    );
  }

 

 

  // _crearFondo(BuildContext context) {
  //   return Container(
  //     child: SafeArea(
  //       child: Container(
  //         padding: EdgeInsets.all(20),
  //         child: Image(image: AssetImage('assets/Logo.png'))
  //       ),
  //     ),
  //     color: Colors.white,
  //   );
  // }
}