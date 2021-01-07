// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    UsuarioModel({
        this.id,
        this.nombreUsuario,
        this.correo,
        this.password,
        this.tokenAuth,
    });

    String id;
    String nombreUsuario;
    String correo;
    String password;
    String tokenAuth;

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombreUsuario: json["nombreUsuario"],
        correo: json["correo"],
        password: json["password"],
        tokenAuth: json["tokenAuth"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombreUsuario": nombreUsuario,
        "correo": correo,
        "password": password,
        "tokenAuth": tokenAuth,
    };
}
