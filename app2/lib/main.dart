import 'dart:convert';

import 'package:app2/models/Api.dart';
import 'package:app2/pages/pagina02.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() => runApp(MiApp());

class MiApp extends StatefulWidget {
  const MiApp({super.key});

  @override
  State<MiApp> createState() => _MiAppState();
}

class _MiAppState extends State<MiApp> {
  late Future<List<Api>> _listadoApis;

  Future<List<Api>> _getApis() async {
    final response = await http
        .get(Uri.parse("https://api.sebastian.cl/UtemAuth/v3/api-docs"));

    List<Api> apis = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      print(jsonData["paths"]["/v1/tokens/validate"]);
    } else {
      throw Exception("Conexion fallida...");
    }
    return apis;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listadoApis = _getApis();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Mi App",
        home: Scaffold(
          //Inicio(),
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: FutureBuilder(
            future: _listadoApis,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(_listApis(snapshot.data as Api) as String);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return const Text("Error");
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }

  List<Widget> _listApis(Api data) {
    List<Widget> apis = [];

    apis.add(Text(data.path));

    return apis;
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi App"),
      ),
      body: Center(
        child: ElevatedButton(
            child: Text("Hola"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => pagina02()));
            }),
        //mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.max,
        //children: <Widget>[
        // Container(
        //width: MediaQuery.of(context).size.width,
        // child: Text(
        //"Hola 01",
        //textAlign: TextAlign.center,
      ),
    );
    //    Text("Hola02")
    //  ],
    // ));
  }
}
