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
}