// To parse this JSON data, do
//
//     final accionModel = accionModelFromJson(jsonString);

import 'dart:convert';

AccionModel accionModelFromJson(String str) => AccionModel.fromJson(json.decode(str));

String accionModelToJson(AccionModel data) => json.encode(data.toJson());

class AccionModel {
    AccionModel({
        this.id,
        this.idUsuario,
        this.tarea,
        this.estado,
        this.anotaciones,
    });

    String id;
    String idUsuario;
    String tarea;
    String estado;
    String anotaciones;

    factory AccionModel.fromJson(Map<String, dynamic> json) => AccionModel(
        id: json["id"],
        idUsuario: json["idUsuario"],
        tarea: json["tarea"],
        estado: json["estado"],
        anotaciones: json["anotaciones"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idUsuario": idUsuario,
        "tarea": tarea,
        "estado": estado,
        "anotaciones": anotaciones,
    };
}
