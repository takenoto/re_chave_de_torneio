//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//
//final double espessuraPadrao = 5;
//final double espacamentoPadrao = 30;
//final double comprimentoPadraoDoStroke = 15;
//final double alturaPadrao = 60;
//final double larguraPadrao = 120;
//final Color strokeColor = Colors.black;
//
//enum BattleWinner { None, Competidor1, Competidor2 }
//
////Informações importantes para a criação da chave:
//int _etapasPorLado;
//int _totalDeEtapas;
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    //new CompetidorWidget();
//    return Scaffold(
//        appBar: AppBar(title: Text('Chave de torneio')),
//        body: SingleChildScrollView(
//          child: ChaveDeTorneio(listaDeCompetidor: getListaDeCompetidores()),
//        ));
//  }
//}
//
////Daqui pra baixo é o código da lógica
////No finalzinho vou simular que estou pegando os competidores da web zz
////--------------------------------------------------
////--------------------------------------------------
//
////--------------------------------------------------
////------------------COMPETIDORES--------------------
////--------------------------------------------------
////Esse objeto contém as informações dos competidores
//class Competidor {
//  final String name;
//  bool stillInGame =
//  false; //se for falso, ou seja, ele perder 1 partida, fica acizentado!
//  Competidor({@required this.name});
//}
//
////Deveria ser um stateful para atualizar rssrsrs ou usar algum gerenciador de estado (ainda não manjo) mas estou fazendo usando o dartpad então não rola :v
//class CompetidorWidget extends StatelessWidget {
//  //Pega o objeto competidor e transforma ele em um widget
//  final Competidor competidor;
//
//  //Determina no momento da criação como vai ser o layout dos tracinhos
//  bool hasBackStroke = false;
//  bool isEsquerda = true;
//
//  CompetidorWidget(
//      {@required this.competidor,
//        @required this.hasBackStroke,
//        @required this.isEsquerda});
//
//  makeOutOfGame() {
//    competidor.stillInGame = false;
//  }
//
//  List<Widget> widgetsOrdenados = [];
//
//  @override
//  Widget build(BuildContext context) {
//    //Adiciona o traçado atrás caso tenha!
//    if (hasBackStroke) {
//      widgetsOrdenados.add(Container(
//        color: strokeColor,
//        width: comprimentoPadraoDoStroke,
//        height: espessuraPadrao,
//      ));
//    }
//
//    widgetsOrdenados.add(Container(
//      color: Colors.amber,
//      child: Text(
//        competidor.name,
//        overflow: TextOverflow.fade,
//        maxLines: 1,
//        softWrap: false,
//      ),
//      padding: EdgeInsets.all(15.0),
//      height: alturaPadrao,
//      width: larguraPadrao,
//    ));
//
//    return Row(
//      mainAxisSize: MainAxisSize.min,
//      mainAxisAlignment: MainAxisAlignment.start,
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: widgetsOrdenados,
//    );
//  }
//}
//
////--------------------------------------------------
////----------------LÓGICA DA CHAVE-------------------
////--------------------------------------------------
//class ChaveDeTorneio extends StatelessWidget {
//  final List<Competidor> listaDeCompetidor;
//  final List<CompetidorWidget> listaDeCompetidorWidget = [];
//  ChaveDeTorneio({@required this.listaDeCompetidor});
//
//  @override
//  Widget build(BuildContext context) {
//    //Determinando o número de etapas:
//    int numeroDeCompetidores = listaDeCompetidor.length;
//    _etapasPorLado = (numeroDeCompetidores / 4).truncate();
//    _totalDeEtapas = (numeroDeCompetidores / 2).truncate() + 1;
//
//    //Obtendo os competidores de cada lado:
//    List<Competidor> competidoresDaEsquerda =
//    listaDeCompetidor.sublist(0, numeroDeCompetidores);
//    List<Competidor> competidoresDaDireita = listaDeCompetidor.sublist(
//        numeroDeCompetidores, listaDeCompetidor.length);
//    print(
//        "Quantidade de competidores na esquerda = ${competidoresDaEsquerda.length}");
//    print(
//        "Quantidade de competidores na direita = ${competidoresDaDireita.length}");
//
//    //todo cria as etapas
//    //Criando as etapas
//    //Todo criar widget da etapa, que empilha as batalhas (por hora só isso!)
//    List<EtapaWidget> listaWidgetsEtapaDireita = [];
//    List<EtapaWidget> listaWidgetsEtapaEsquerda = [];
//    EtapaWidget widgetEtapaCentro;
//
//    List<EtapaModel> listaEtapaModelEsquerda = [];
//    List<EtapaModel> listaEtapaModelDireita = [];
//    //------------------------------------------------------
//    //-----------------------ETAPAS-------------------------
//    //------------------------------------------------------
//    for (int iEtapa = 0; iEtapa < _etapasPorLado; iEtapa++) {
//      //Tem a etapa[1] da esquerda e a [1] da direita, e assim por diante!
//      final EtapaModel etapaEsquerda = EtapaModel();
//      final EtapaModel etapaDireita = EtapaModel();
//      //todo cria as batalhas de cada etapa rodando os competidores e agrupando 2 a 2!
//      //Por definição, a primeira etapa é sempre a que fica nas pontas
//      //Então a primeira etapa da direita pega dos ultimos itens!
//
//      //Separa dois a dois para as batalhas iniciais, o resto será automatizado!
//
//      //------------------------------------------------------
//      //----------------------BATALHAS------------------------
//      //------------------------------------------------------
//      //todo Cria os competidores APENAS NA 1ª ETAPA! NAS DEMAIS PEGA O VENCEDOR DA ANTERIOR!!!!!
//      //Para a etapa 0 (primeira):
//      List<BatalhaModel> batalhasDaEsquerda = [];
//      List<BatalhaModel> batalhasDaDireita = [];
//      for (int j = 0; j < (competidoresDaEsquerda.length/iEtapa).truncate(); j += 2) {
//        //todo Dependendo se for a primeira etapa da direita ou da esquerda coloca o backStroke
//        //Determina com um bool se deve ter o "backStroke" ou não
//        //Se for a etapa 0, os widgets não tem o backStroke!
//        bool hasBackStroke;
//        iEtapa == 0 ? hasBackStroke = true : hasBackStroke = false;
//        Competidor competidorEsquerda1;
//        Competidor competidorEsquerda2;
//        Competidor competidorDireita1;
//        Competidor competidorDireita2;
//
//        if(iEtapa==0){
//          //Pega os competidores da primeira etapa
//          competidorEsquerda1 = competidoresDaEsquerda[j];
//          competidorEsquerda2 = competidoresDaEsquerda[j+1];
//          competidorDireita1 = competidoresDaDireita[j];
//          competidorDireita2 = competidoresDaDireita[j+1];
//        }else{
//          //Os competidores vão ser simplesmente os vencedores da chave anterior
//          competidorEsquerda1 = competidoresDaEsquerda[j];
//          competidorEsquerda2 = competidoresDaEsquerda[j+1];
//          competidorDireita1 = competidoresDaDireita[j];
//          competidorDireita2 = competidoresDaDireita[j+1];
//        }
//
//        //todo Cria os widgets para a batalha da esquerda e da direita:
//        //Criando os widgets dos competidores
//        final CompetidorWidget competidorWidgetEsquerda1 = CompetidorWidget(
//          competidor: competidorEsquerda1,
//          hasBackStroke: hasBackStroke,
//          isEsquerda: true,
//        );
//        final CompetidorWidget competidorWidgetEsquerda2 = CompetidorWidget(
//          competidor: competidorEsquerda2,
//          hasBackStroke: hasBackStroke,
//          isEsquerda: true,
//        );
//
//        final CompetidorWidget competidorWidgetDireita1 = CompetidorWidget(
//          competidor: competidorDireita1,
//          hasBackStroke: hasBackStroke,
//          isEsquerda: false,
//        );
//        final CompetidorWidget competidorWidgetDireita2 = CompetidorWidget(
//          competidor: competidorDireita2,
//          hasBackStroke: hasBackStroke,
//          isEsquerda: false,
//        );
//
//        final BatalhaModel batalhaEsquerda = BatalhaModel(competidor1: competidorEsquerda1, competidor2: competidorEsquerda2);
//        final BatalhaModel batalhaDireita = BatalhaModel(competidor1: competidorDireita1, competidor2: competidorDireita2);
//
//        final BatalhaWidget batalhaWidget;
//      }
//      listaEtapaModelEsquerda.add(etapaEsquerda);
//      listaEtapaModelDireita.add(etapaDireita);
//
//      //todo cria o widget do centro:
//
//      //todo Roda os competidores e cria os widgets correspondentes?
////    final CompetidorWidget competidorWidget = CompetidorWidget(
////      competidor: competidor,
////      hasBackStroke: true,
////    );
//
//      //todo Cria os da batalha final?
//
//    }
//
//    //todo cria lista de competidor widget
////    for (Competidor competidor in listaDeCompetidor) {
////      final CompetidorWidget competidorWidget = CompetidorWidget(
////        competidor: competidor,
////        hasBackStroke: false,
////      );
////      listaDeCompetidorWidget.add(competidorWidget);
////    }
//
//    return Expanded(
//      child: Container(
//          color: Colors.grey,
//          //child: CompetidorWidget(competidor: Competidor(name: 'nome')));
//          child: Column(children: competidoresDaDireita)),
//    );
//  }
//}
//
////--------------------------------------------------
////------------------WIDGETS-------------------------
////--------------------------------------------------
//
////Traço padrão - para ser usado nas chaves!
//
////Minichave - item da chave de torneio maior!
//class BatalhaWidget extends StatelessWidget {
//  final Competidor competidor1, competidor2;
//  CompetidorWidget competidorWidget1, competidorWidget2;
//
//  //Determina se está vindo da direita p/ esquerda ou do contrário para sabermos como posicionar
//  bool isLeft = true;
//  //Determina se é a primeira batalha (ou seja, não possui traços atrás)
//  bool isFirst = false;
//
//  BatalhaWidget(
//      {@required this.competidor1,
//        @required this.competidor2,
//        this.isLeft,
//        this.isFirst});
//
//  @override
//  Widget build(BuildContext context) {
//    //todo criar os widgets usando as informações dos competidores
//    //tem que mudar eles já tão aí em baixo mas eu não inicializei!!!
//
//    //Vamos usar a mesma coluna independente de qualquer coisa
//    Column colunaDosCompetidores = Column(children: [
//      competidorWidget1,
//      SizedBox(height: espacamentoPadrao),
//      competidorWidget2,
//    ]);
//
//    if (isLeft) {
//      return Row(children: [
//        colunaDosCompetidores,
//        //todo Coloca nessa parte o traço vertical
//        Column(),
//        Column(),
//      ]);
//    } else {
//      print('Parte da direita ainda não construída');
//      return Row(children: [
//        colunaDosCompetidores,
//        Column(),
//        Column(),
//      ]);
//    }
//  }
//}
//
//class EtapaWidget extends StatelessWidget {
//  List<BatalhaModel> listaDeBatalhaModel = [];
//  List<BatalhaWidget> listaDeBatalhaWidget = [];
//
//  EtapaWidget({this.listaDeBatalhaModel});
//
//  @override
//  Widget build(BuildContext context) {
//    //Criar lista de batalha widgets usando os batalhas model
//    for (BatalhaModel batalhaModel in listaDeBatalhaModel) {
//      final BatalhaWidget batalhaWidget = BatalhaWidget(
//          competidor1: batalhaModel.competidor1,
//          competidor2: batalhaModel.competidor1);
//      listaDeBatalhaWidget.add(batalhaWidget);
//    }
//
//    return Container();
//  }
//}
//
////--------------------------------------------------
////-------------OBTENDO OS ELEMENTOS-----------------
////--------------------------------------------------
//List<Competidor> getListaDeCompetidores() {
//  List<Competidor> lista = [];
//  for (int i = 0; i < 4; i++) {
//    final int number = i;
//    final Competidor competidor = Competidor(name: '${number + 1}º competidor');
//    lista.add(competidor);
//  }
//
//  return lista;
//}
//
////--------------------------------------------------
////----------------------MODELS---------------------
////--------------------------------------------------
//
//class BatalhaModel {
//  //Contém 2 a 2 os que irão lutar!
//  final Competidor competidor1;
//  final Competidor competidor2;
//
//  var winner = BattleWinner.None;
//
//  void setWinner(int i){
//    i==1?this.winner=BattleWinner.Competidor1:this.winner=BattleWinner.Competidor2;
//  }
//
//  //Coloca os 2 competidores
//  BatalhaModel(
//      {@required this.competidor1, @required this.competidor2});
//}
//
////Uma etapa é uma "seção vertical" que contém várias batalhas (enfretamentos 1x1)
//class EtapaModel {
//  final List<BatalhaModel> listaDeBatalhas;
//  //Cria as batalhasWidget a partir da lista de batalhas
//  //todo obter lista de batalhas de algum canto para determinada etapa
//  EtapaModel({@required this.listaDeBatalhas});
//}
