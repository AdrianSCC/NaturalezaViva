import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:formvalidation/src/utils/utils.dart';

class LoginPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
          
        ],
      )
    );
  }

  _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondo =  Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green[800],
            Colors.greenAccent,
          ]
        )
      ),
    );

    return Stack(
      children: [
        fondo,
        Container(
          padding: EdgeInsets.only(top: (size.height*0.4)*0.25),
          child: Column(
            children: [
              Icon (Icons.emoji_nature, size: 100, color: Colors.white),
              SizedBox(height: 10, width:double.infinity,),
              Text('Naturaleza Viva', style: TextStyle(color: Colors.white, fontSize: 20),)
            ],
          ),
        )
      ]
    );
  }

  _loginForm(BuildContext context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height:size.height*0.3,
            ),
          ),


          Container(
            width: size.width*0.85,
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 3.0,
                ),
              ]
            ),
            child: Column(
              children: [
                Text('Ingreso', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20,),
                _crearEmail(bloc),
                SizedBox(height: 20,),
                _crearPassword(bloc),
                SizedBox(height: 40,),
                _crearBoton(bloc),
                
              ]
            ),

          ),
          SizedBox(height: 50,),
          FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'registro'),
            child: Text('Registrarse')
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }

  _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
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
          padding: EdgeInsets.symmetric(horizontal:20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.security_rounded, color: Colors.deepPurple),
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

  _crearBoton(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:80, vertical:20),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          elevation: 0,
          color: Colors.tealAccent[700],
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {

    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if(info['ok']){
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      mostrarAlerta(context, 'Los datos introducidos son incorrectos');
    }
    
  }
}