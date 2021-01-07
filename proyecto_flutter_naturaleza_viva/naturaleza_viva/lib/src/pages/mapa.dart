import 'dart:async';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:naturaleza_viva/src/model/animal_model.dart';
import 'package:naturaleza_viva/src/model/libertad_model.dart';
import 'package:naturaleza_viva/src/providers/animales_provider.dart';
import 'package:naturaleza_viva/src/providers/liberaciones_provider.dart';


class Mapa extends StatefulWidget {

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  Completer<GoogleMapController> _controller = Completer();
  LiberacionesProvider liberacionProvider = new LiberacionesProvider();
  AnimalesProvider animalProvider = new AnimalesProvider();
  AnimalModel animal = new AnimalModel();

    CameraPosition puntoInicial;
    LatLng posicion;
    LatLng posicionAnimal;
    Location location;
    LocationData currentLocation;
  
  
  @override
  Widget build(BuildContext context) {

    final List<dynamic> argumentos = ModalRoute.of(context).settings.arguments;
    final int modo = argumentos[0];
    animal = argumentos[1];
    if(modo == 2){
      _buscarPosicionAnimal();
    }


    return FutureBuilder(
      future: _obtenerPosicion(),
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot){
        if(snapshot.hasData){
          currentLocation = snapshot.data;
          posicion = new LatLng(currentLocation.latitude, currentLocation.longitude);//pos[0],pos[1]); 
          puntoInicial = CameraPosition(
            target: posicion,
            zoom: 17,
            tilt: 50,
          );
          if(modo==2){
            return FutureBuilder(
              future: _buscarPosicionAnimal(),
              builder: (BuildContext context, AsyncSnapshot<LibertadModel> snap) {
                if(snap.hasData){
                  LibertadModel lib = snap.data;
                  posicionAnimal = new LatLng(double.parse(lib.latitud), double.parse(lib.longitud));
                  return _mapa(modo);
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            );
          }else{
            return _mapa(modo);
          }
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }

  _mapa(int modo){

    FloatingActionButton btnLiberar;
    Set<Marker> markers = new Set<Marker>();
    // markers.add(new Marker(
    //   markerId: MarkerId('localization'),
    //   position: posicion,
    // ));

    if(modo==2){
      markers.add(new Marker(
        markerId: MarkerId('animal'),
        position: posicionAnimal,
      ));
    }else{
      btnLiberar = FloatingActionButton.extended(
        onPressed: (){_liberar();},
        label: Text('Liberar'),
        icon: Icon(Icons.emoji_nature),
      );
    }


    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          markers: markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false ,
          mapType: MapType.hybrid,
          initialCameraPosition: puntoInicial,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: btnLiberar,
    );
  }

  Future<LocationData> _obtenerPosicion()async {
    location = new Location();
    currentLocation = await location.getLocation();
    return currentLocation;
  }

  void _liberar() async {
    LibertadModel libertad = new LibertadModel();
    libertad.idAnimal = animal.id;
    libertad.idUsuario = "nombre de usuario";
    libertad.latitud = currentLocation.latitude.toString();
    libertad.longitud = currentLocation.longitude.toString();
    final crearLiberacion = await liberacionProvider.crearLiberacion(libertad).then((value) => animal.idSeguimiento=value);
    animal.liberado = true;
    final editarAnimal = await animalProvider.editarAnimal(animal);
    Navigator.pushNamed(context, 'ficha', arguments: animal.id);
  }

  Future<LibertadModel>_buscarPosicionAnimal() async {
    LibertadModel libertad = new LibertadModel();
    final resp = await liberacionProvider.buscarLiberacion(animal.idSeguimiento).then((value) => libertad = value);
    return libertad;
    
  }


  // _ponerPosicion(){
  //   if(true){
  //     //List<double> pos = miPosicion(lat, long);//relleno las variables lat,long con mi posicion
  //     posicion = new LatLng(currentLocation.latitude, currentLocation.longitude);//pos[0],pos[1]); 
  //     puntoInicial = CameraPosition(
  //       target: posicion,
  //       zoom: 14.4746,
  //     );
  //   }
  // }

  // List<double> miPosicion(double lat, double long) {
  //   Geolocator.getCurrentPosition(
  //     desiredAccuracy: Geolocator.LocationAccuracy.high,
  //   ).then((value){
  //     lat = value.latitude;
  //     long = value.longitude;
  //     // Geolocator.Position(
  //     //   latitude: value.latitude, 
  //     //   longitude: value.longitude
  //     // );
  //   });

  //   // Geolocator.getPositionStream().listen((Geolocator.Position posicion){
  //   //   print(posicion);
  //   // });
  //   List<double> lista = new List();
  //   lista.add(lat);
  //   lista.add(long);
  //   return lista;
  // }
}