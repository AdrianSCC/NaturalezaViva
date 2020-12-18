import 'dart:convert';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider{

  final String _url = 'https://flutter-varios-adrian-default-rtdb.europe-west1.firebasedatabase.app';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async{
    final url = '$_url/productos.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async{
    final url = '$_url/productos/${producto.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async{
    final url = '$_url/productos.json?auth=${_prefs.token}';

    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();

    if(decodedData == null) return [];

    decodedData.forEach((id, prod) {

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });
    return productos;
  }


  Future<int> borrarProducto(String id) async{
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';

    final resp = await http.delete(url);

    return 1;
  }
}