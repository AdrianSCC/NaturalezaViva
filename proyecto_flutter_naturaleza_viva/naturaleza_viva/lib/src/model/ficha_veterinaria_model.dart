// To parse this JSON data, do
//
//     final fichaVeterinariaModel = fichaVeterinariaModelFromJson(jsonString);

import 'dart:convert';

FichaVeterinariaModel fichaVeterinariaModelFromJson(String str) => FichaVeterinariaModel.fromJson(json.decode(str));

String fichaVeterinariaModelToJson(FichaVeterinariaModel data) => json.encode(data.toJson());

class FichaVeterinariaModel {
    FichaVeterinariaModel({
        this.id,
        this.idAnimal,
        this.problema,
        this.evolucion,
        this.anotaciones,
    });

    String id;
    String idAnimal;
    String problema;
    String evolucion;
    String anotaciones;

    factory FichaVeterinariaModel.fromJson(Map<String, dynamic> json) => FichaVeterinariaModel(
        id: json["id"],
        idAnimal: json["idAnimal"],
        problema: json["problema"],
        evolucion: json["evolucion"],
        anotaciones: json["anotaciones"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idAnimal": idAnimal,
        "problema": problema,
        "evolucion": evolucion,
        "anotaciones": anotaciones,
    };
}
