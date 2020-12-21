// To parse this JSON data, do
//
//     final animalModel = animalModelFromJson(jsonString);

import 'dart:convert';

AnimalModel animalModelFromJson(String str) => AnimalModel.fromJson(json.decode(str));

String animalModelToJson(AnimalModel data) => json.encode(data.toJson());

class AnimalModel {
    AnimalModel({
        this.id,
        this.idSeguimiento,
        this.qr,
        this.especie,
        this.raza,
        this.nombre,
        this.estado,
        this.dieta,
        this.anotaciones,
        this.habitat,
        this.peso,
        this.liberado,
        this.fotoPrincipal,
        this.fotografias,
        this.historialVeterinario,
    });

    String id;
    String idSeguimiento;
    String qr;
    String especie;
    String raza;
    String nombre;
    String estado;
    String dieta;
    String anotaciones;
    String habitat;
    int peso;
    bool liberado;
    String fotoPrincipal;
    List<String> fotografias;
    List<String> historialVeterinario;

    factory AnimalModel.fromJson(Map<String, dynamic> json) => AnimalModel(
        id: json["id"],
        idSeguimiento: json["idSeguimiento"],
        qr: json["qr"],
        especie: json["especie"],
        raza: json["raza"],
        nombre: json["nombre"],
        estado: json["estado"],
        dieta: json["dieta"],
        anotaciones: json["anotaciones"],
        habitat: json["habitat"],
        peso: json["peso"],
        liberado: json["liberado"],
        fotoPrincipal: json["fotoPrincipal"],
        fotografias: List<String>.from(json["fotografias"].map((x) => x)),
        historialVeterinario: List<String>.from(json["historialVeterinario"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idSeguimiento": idSeguimiento,
        "qr": qr,
        "especie": especie,
        "raza": raza,
        "nombre": nombre,
        "estado": estado,
        "dieta": dieta,
        "anotaciones": anotaciones,
        "habitat": habitat,
        "peso": peso,
        "liberado": liberado,
        "fotoPrincipal": fotoPrincipal,
        "fotografias": List<dynamic>.from(fotografias.map((x) => x)),
        "historialVeterinario": List<dynamic>.from(historialVeterinario.map((x) => x)),
    };
}
