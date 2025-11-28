import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pulsatrix/HomePage.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Bem vindo ao Pulsatrix!"),
          ),
          body: Center(
              child: HomePage(path: verificarOuCriarJson().toString()),
          ),
        )
    );
  }
}

Future<String> verificarOuCriarJson() async {
  // Caminho da pasta
  final dir = await getApplicationDocumentsDirectory();
  final arquivo = File('${dir.path}/data.json');

  // Verifica se existe
  if (!await arquivo.exists()) {
    // Cria o arquivo com dados iniciais
    final dadosIniciais = {
      "items": [
        {
          "title": "",
          "content": ""
        }
      ]
    };
    await arquivo.writeAsString(jsonEncode(dadosIniciais));
    return dir.path;
  } else {
    return dir.path;
  }
}