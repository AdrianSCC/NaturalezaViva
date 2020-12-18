import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productoProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto').then((value) {  setState(() {      });}),
    );
  }

  _crearListado() {
    return FutureBuilder(
      future: productoProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(productos[i], context),
          );
        }else{
          return Center (child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _crearItem(ProductoModel producto, BuildContext context) {
    return Dismissible(
      key:UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direccion){
        productoProvider.borrarProducto(producto.id);
        
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor}'),
        subtitle: Text('${producto.id}'),
        onTap: () => Navigator.pushNamed(context, 'producto',     arguments: producto    ).then((value) {    setState(() {          });  }),

      ),
    );
  }
}