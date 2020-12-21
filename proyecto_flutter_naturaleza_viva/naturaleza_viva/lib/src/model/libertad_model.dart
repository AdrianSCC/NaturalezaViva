// To parse this JSON data, do
//
//     final libertadModel = libertadModelFromJson(jsonString);

import 'dart:convert';

LibertadModel libertadModelFromJson(String str) => LibertadModel.fromJson(json.decode(str));

String libertadModelToJson(LibertadModel data) => json.encode(data.toJson());

class LibertadModel {
    LibertadModel({
        this.id,
        this.idAnimal,
        this.idUsuario,
        this.latitud,
        this.longitud,
        this.anotaciones,
    });

    String id;
    String idAnimal;
    String idUsuario;
    String latitud;
    String longitud;
    String anotaciones;

    factory LibertadModel.fromJson(Map<String, dynamic> json) => LibertadModel(
        id: json["id"],
        idAnimal: json["idAnimal"],
        idUsuario: json["idUsuario"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        anotaciones: json["anotaciones"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idAnimal": idAnimal,
        "idUsuario": idUsuario,
        "latitud": latitud,
        "longitud": longitud,
        "anotaciones": anotaciones,
    };
}
