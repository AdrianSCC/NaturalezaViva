import 'package:flutter/material.dart';
import 'package:naturaleza_viva/src/bloc/provider_bloc.dart';
import 'package:naturaleza_viva/src/providers/usuario_provider.dart';
import 'package:naturaleza_viva/src/utils/utils.dart';

class RegistroPage extends StatefulWidget {

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final usuarioProvider = new UsuarioProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _logo(size),
              _formulario(size, context),
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
          Text('REGISTRO', style:TextStyle(
            fontSize: 25, 
            color: Colors.teal[600],
            fontWeight: FontWeight.bold,
            )),
            _crearNombre(bloc),
           _crearEmail(bloc),
           _crearPassword(bloc),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _botonRegistrar('Registrarse', bloc),),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _boton('Registrarse con Google',2),),
           SizedBox( height: 20),
           Container(width: size.width*0.7, height: size.height*0.07, child: _boton('Registrarse con Twitter',3),),
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
          padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.green[900]),
              hintText: 'ejemplo@ejemplo.com',
              labelText: 'Correo Electronico',
              //counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    ); 

  }

  _crearNombre(LoginBloc bloc) {

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

  _crearPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.green[900]),
              hintText: '******',
              labelText: 'Password',
              //counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
    
  }

  _botonRegistrar(String s, LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
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
          onPressed: snapshot.hasData ? () => _registro(context, bloc) : null,
        );
      },
    );
  }

  _registro(BuildContext context, LoginBloc bloc) async{

    print(bloc.email);
    print(bloc.password);

    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

    if(info['ok']){
      //Navigator.pushReplacementNamed(context, 'login', arguments: 1);
      mostrarBienvenida(context);
    }else{
      mostrarAlerta(context, 'Los datos introducidos son incorrectos');
    }
  }

  _boton(String s,int modo) {
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
      onPressed: _accion(modo),
      // (){
      //   if(s == "Acceder"){
      //     //Navigator.pushReplacementNamed(contextLogin, 'home');
      //   }else{
      //     //Navigator.pushNamed(contextLogin, 'registro');
      //   }
      // },
    );
  }

  _accion(int modo) {

    switch (modo) {
      case 1:
        
        break;
      case 2:
        
        break;
      case 3:
        
        break;
      default:
    }
  }

  void mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500)
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}