import 'dart:convert';
import 'package:naturaleza_viva/src/model/animal_model.dart';
import 'package:http/http.dart' as http;

class AnimalesProvider{

  final String _url = "https://naturalezaviva-2020.firebaseio.com";

  Future<bool> crearAnimal(AnimalModel animal) async{
    final url = '$_url/animales.json';//?auth=${_prefs.token}';
    
    final resp = await http.post(url, body: animalModelToJson(animal));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<AnimalModel> buscarAnimal(String id) async{
    final url = '$_url/animales/$id.json';//?auth=${_prefs.token}';
    AnimalModel animal = new AnimalModel();
    
    final resp = await http.get(url);
    if(resp.body != "null"){
      final deco = json.decode(resp.body);

      animal = AnimalModel.fromJson(deco);
      animal.id = id;
    }else{
      animal.id = '-1';
    }
    return animal;
  }

  Future<List<AnimalModel>> buscarAnimales(String lectura) async{
    final url = '$_url/animales.json';//?auth=${_prefs.token}';
    
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<AnimalModel> animales = new List();
    
    if(decodedData == null) return null;

    decodedData.forEach((id, prod) {

      if(id==lectura){
        final animalTemp = AnimalModel.fromJson(prod);
        animalTemp.id = id;

        animales.add(animalTemp);

      }
    });
    print(decodedData);
    return animales;
  }

  Future<bool> editarAnimal(AnimalModel animal) async{
    final url = '$_url/animales/${animal.id}.json';

    final resp = await http.put(url, body: animalModelToJson(animal));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<int> borrarAnimal(String id) async{
    final url = '$_url/animales/$id.json';

    final resp = await http.delete(url);

    return 1;
  }

}