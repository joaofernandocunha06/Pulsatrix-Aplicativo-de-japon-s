import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pulsatrix/custom_widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomePage extends StatefulWidget{ //faltando o parâmetro "key"

  HomePage({
    super.key,
    required this.path,
  });

  final String path;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  List<String> temas = [];
  List<Map<String, dynamic>> myWidgets = [/*Topic(title: "NÃO AUTOMÁTICO", content: Text("TESTE"))*/];
  List<String> temasJapao = [
    // 55 áreas comuns
    "Estações do ano",
    "Flores de cerejeira e hanami",
    "Folhas de outono e kōyō",
    "Neve e esportes de inverno",
    "Montanhas e trilhas",
    "Parques urbanos",
    "Jardins tradicionais",
    "Praias e litorais",
    "Florestas e bosques",
    "Rios e lagos",
    "Transporte público e metrôs",
    "Trens-bala (shinkansen)",
    "Ruas comerciais e shotengai",
    "Shopping centers",
    "Bicicletas e ciclovias",
    "Estações de trem e logística",
    "Conveniências 24h (konbini)",
    "Máquinas automáticas",
    "Casas e apartamentos urbanos",
    "Arquitetura moderna",
    "Ramen e noodles",
    "Sushi e sashimi",
    "Kaiseki ryōri",
    "Bento e marmitas",
    "Street food e yatai",
    "Doces tradicionais japoneses",
    "Cultura do chá",
    "Onigiri e lanches do dia a dia",
    "Izakaya e bares",
    "Mercados de peixe e ingredientes",
    "Cerâmica",
    "Caligrafia",
    "Origami",
    "Ikebana",
    "Teatro nō",
    "Teatro kabuki",
    "Teatro bunraku",
    "Música tradicional",
    "Contos e lendas japonesas",
    "Yokai e folclore",
    "Moda de rua Harajuku",
    "Subcultura visual kei",
    "Anime e mangá",
    "Doramas e séries",
    "Jogos e fliperamas",
    "Pachinko",
    "Música pop japonesa",
    "Festivais tradicionais (matsuri)",
    "Educação e escolas",
    "Etiqueta social e comportamento",
    "História do Período Edo",
    "Samurai e bushidō",
    "Ninjas",
    "Castelos japoneses",
    "Religião e espiritualidade (xintoísmo e budismo)",

    // 15 áreas incomuns / nichos
    "Eki-ben e gastronomia ferroviária",
    "Banho de floresta (shinrin-yoku)",
    "Hotéis cápsula",
    "Mini-casas urbanas (kyōshō jutaku)",
    "Alta tecnologia doméstica",
    "Cultura hikikomori",
    "Coin lockers e armazenamento urbano",
    "Eventos sazonais em shoppings",
    "Ilhas abandonadas e ruínas urbanas",
    "Adoção adulta para sucessão de negócios",
    "Leilões de frutas premium",
    "Cafés temáticos (gato, maid, anime)",
    "Treinamento de sumô infantil",
    "Shokuhin sampuru (réplicas realistas de comida)",
    "Escadas rolantes e regras regionais"
  ];
  /*função já está funcionando quanto à criação de novos tópicos
  falta ainda chamar a API do Gemini e criar arquivos .JSON*/

//--------------------------------CALL GEMINI-----------------------------------
  /*
  Future<void> callGemini() async {
    final random = Random();
    String tema = temasJapao[random.nextInt(temasJapao.length)];
    String prompt = "Crie um texto em japonês, no estilo de mini-guia (Não colocar nada visual, NADA de hashtag ou asterísco. Lembre-se de manter simplificado o japonês, pois sou iniciante, ou seja, o texto do começo dizendo como o tema influencia na vida dos japoneses deverá ser em português. A parte dos kanjis deverá conter apenas os kanjis, no máximo uma transcrição de sua pronúncia para hiragana. Não colocar respostas. coloque o tema no topo do texto antes de começar), sobre o tema $tema. Começe com uma breve introdução explicando o tema de forma simples e natural, incluindo curiosidades ou aspectos culturais relevantes.\n\tListe 1. Frases comuns do cotidiano, LEMBRE-SE DE MANTER SIMPLIFICADO PARA UM INICIANTE NO IDIOMA: 5 frases simples, com japonês, tradução para português e transcrição em hiragana.\n\t2. Frases interessantes: 5 frases que mostram expressões ou situações típicas do tema, também com japonês, tradução e hiragana.\n\t3. Kanjis do tema: 5 kanjis importantes relacionados ao tema, com significado em português e leitura em hiragana.";

    const apiKey = 'insira sua chave de API';
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );

    for (var i = 0; i < 5; i++){
      try {
        final response = await model.generateContent([Content.text(prompt)]);
        if (response.text != null) {
          String content = response.text!;
          setState(() {
            myWidgets.insert(0, {
              'title': "$tema ${myWidgets.length}",
              'content': content,
            });
          });
          saveJson(widget.path, myWidgets);
          break;
        }
      } catch (e) {
        if (e.toString().contains('503')) {
          print('⚠ Modelo sobrecarregado, tente novamente mais tarde.');
        } else {
          print('❌ Erro inesperado: $e');
        }
      }
    }
  }
  */
//-------------------------------LOAD FUNC--------------------------------------
  Future<void> readJson(String path) async {
    final file = File(path);
    if (await file.exists()) {
      final response = await file.readAsString();
      final data = jsonDecode(response);
      setState(() {
        myWidgets = List<Map<String, dynamic>>.from(data['items']);
      });
    } else {
      print("Arquivo não encontrado");
    }
  }
//-------------------------------SAVE FUNC--------------------------------------
  Future<void> saveJson(String path, List<Map<String, dynamic>> data) async {
    final file = File(path);
    await file.writeAsString(jsonEncode({"items": data}));
  }
//-------------------------------DEL ITEM FUNC----------------------------------
  void removeTopic(int index){
    setState(() {
      myWidgets.removeAt(index);
    });
  }
//------------------------------------------------------------------------------
  //não se esqueçer de programar para, caso não haja um .json, criar um novo. Assim o código não quebra

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
//---------------------------BUILD WIDGETS--------------------------------------
        ListView.builder(
        //reverse: true,
        itemCount: myWidgets.length,
            itemBuilder: (context, index) {
              return Topic(title: myWidgets[index]["title"], content: Text(myWidgets[index]["content"]
                  .replaceAll("\\n", "\n")
                  .replaceAll("\\t", "    ")
                  .replaceAll("*", "")
                ),
                onDelete: () => removeTopic(index),
              );
            }
        ),
//----------------------------RELOAD BUTTON-------------------------------------
        //botão reload
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20, bottom: 120),
            child: ElevatedButton( //botão canto inferior direito da tela
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => readJson("assets/items.json"),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: Image.asset("assets/reload.png", height: 30, width: 30,),
                )
            ),
          ),
        ),
//---------------------------CREATE BUTTON--------------------------------------
        //botão create
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton( //botão canto inferior direito da tela
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},//newRoutine,
                child: SizedBox(
                    height: 90,
                    width: 90,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
              ),
          ),
        )
      ]
    );
  }
}