// To parse this JSON data, do
//
//     final mensajeModel = mensajeModelFromJson(jsonString);

import 'dart:convert';

MensajeModel mensajeModelFromJson(String str) => MensajeModel.fromJson(json.decode(str));

String mensajeModelToJson(MensajeModel data) => json.encode(data.toJson());

class MensajeModel {
    MensajeModel({
        this.id,
        this.idUsuarioEmisor,
        this.idUsuarioReceptor,
        this.texto,
    });

    String id;
    String idUsuarioEmisor;
    String idUsuarioReceptor;
    String texto;

    factory MensajeModel.fromJson(Map<String, dynamic> json) => MensajeModel(
        id: json["id"],
        idUsuarioEmisor: json["idUsuarioEmisor"],
        idUsuarioReceptor: json["idUsuarioReceptor"],
        texto: json["texto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idUsuarioEmisor": idUsuarioEmisor,
        "idUsuarioReceptor": idUsuarioReceptor,
        "texto": texto,
    };
}
