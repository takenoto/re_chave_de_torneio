import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rechavedetorneio/models/batalha_model.dart';
import 'package:rechavedetorneio/models/etapa_model.dart';
import 'package:rechavedetorneio/views/widgets/competidor_widget.dart';
import 'dimensoes_e_etc.dart' as info;

class BatalhaWidget extends StatelessWidget {
  bool isFirstEtapaBatalha = false;
  bool isLeft = true;
  bool isFinal = false;
  final EtapaModel etapaModel; //A etapa da batalha, pra ela saber qual é a dela

  final BatalhaModel batalhaModel;

  int numEtapa = 0;

  BatalhaWidget(
      {@required this.batalhaModel,
      this.isLeft,
      this.isFinal,
      @required this.etapaModel});
  //Se for a batalha da primeira etapa, a organização é padrozinada e não tem a parte de trás
  //Do contrário, é dinâmica e se expande até atingir os anteriores

  @override
  Widget build(BuildContext context) {
    isLeft ??= false;
    isFinal ??= false;

    numEtapa = etapaModel.numEtapa;
    //O numero de batalhas da anterior é 2x o da atual, mas divide por 2 porque as etapas sempre são dividadas meio a meio!
    int numBatalhas = 2 * etapaModel.batalhas.length;
    //int numBatalhasPratico = (numBatalhas / 2).round();
    int numBatalhasPratico = (numBatalhas / 2).round();
    isFirstEtapaBatalha = numEtapa == 0 ? true : false;
    int numBatalhasNaEtapaZero = pow(2, numEtapa) * numBatalhasPratico;
    double heightDaBatalhaPadrao =
        2 * info.competidorHeight + info.defaultSpacing;
    double heightDasBatalhasNaEtapaZero =
        numBatalhasNaEtapaZero * heightDaBatalhaPadrao +
            (numBatalhasNaEtapaZero - 1) * info.defaultLargeSpacing;
    //Divide por dois porque a etapa é partida metade pra esquerda metade pra direita!

    //Primeiro descobrimos se há um vencendor:
    bool isLoser1 = false;
    bool isLoser2 = false;
    if (batalhaModel.battleFinished()) {
      isLoser1 = !batalhaModel.winnerIsOne();
      isLoser2 = batalhaModel.winnerIsOne();
    }
    //Cria os widgets dos competidores
    final CompetidorWidget competidorWidget1 = CompetidorWidget(
      competidorModel: batalhaModel.competidor1,
      isLoser: isLoser1,
    );
    final CompetidorWidget competidorWidget2 = CompetidorWidget(
      competidorModel: batalhaModel.competidor2,
      isLoser: isLoser2,
    );

    //Height da coluna da batalha atual:
    double sizedBoxHeight = 0;
    //Comprimento que separa o traçado que fecha a chave das bordas da chave (funciona como uma margem! ele expande no restante, subtraindo isso aqui)
    double distanciaDoTraco = 0;
    //Quantidade de batalhas da etapa anterior = 2 x a da atual

    //Se for a primeira etapa, faz proporcionalmente ao esperado
    if (isFirstEtapaBatalha) {
      sizedBoxHeight = heightDaBatalhaPadrao;
      distanciaDoTraco = info.competidorHeight / 2 - info.strokeWidth / 2;
    } else {
      //todo FINAL faz por proporcionalidade em relação ao tamanho original
      int multiplicador = 1;
      //------------------------------------------------
      //Fiz esses testes para descobrir algum padrão zzz
      //------------------------------------------------
//      numEtapa == 5 ? multiplicador = 4 : multiplicador = multiplicador;
//      numEtapa == 6 ? multiplicador = 8 : multiplicador = multiplicador;

//      switch (numEtapa) {
//        case 5:
//          multiplicador = 4;
//          break;
//        case 6:
//          multiplicador = 8;
//          break;
//      }

      if (numEtapa >= 5) {
        multiplicador = multiplicador * pow(2, numEtapa - 4);
      }

      double heightPorBatalha =
          heightDasBatalhasNaEtapaZero / (2 * numBatalhasPratico) +
              info.competidorHeight +
              multiplicador * info.strokeWidth;
      sizedBoxHeight = heightPorBatalha;

      distanciaDoTraco = info.competidorHeight / 2 - info.strokeWidth / 2;
    }

    //Margem do topo e margem de baixo são idênticas!
    final Widget marginTopBot = SizedBox(
      height: numEtapa * info.defaultSpacing,
    );

    List<Widget> rowWidgets = <Widget>[
      colunaCompetidores(
          competidorWidget1: competidorWidget1,
          competidorWidget2: competidorWidget2),
      Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: distanciaDoTraco,
          ),
          Expanded(
            //Traçado vertical
            child: Container(
              color: !isLoser1
                  ? info.competidorWinnerColor
                  : info.competidorLoserColor,
              width: info.strokeWidth,
              height: 1,
            ),
          ),
          //Traçado que liga o vencedor à próxima chave
          Container(
            height: info.strokeWidth,
            width: info.strokeWidth,
            color: info.competidorWinnerColor,
          ),
          Expanded(
            //Traçado vertical
            child: Container(
              color: !isLoser2
                  ? info.competidorWinnerColor
                  : info.competidorLoserColor,
              width: info.strokeWidth,
              height: 1,
            ),
          ),
          SizedBox(
            height: distanciaDoTraco,
          ),
        ],
      ),
      tracoPadraoHorizontalWinner,
    ];

    if (isFinal) {
      return Row(
        children: <Widget>[
          competidorWidget1,
          tracoPadraoHorizontal,
          competidorWidget2
        ],
      );
    } else
      return SizedBox(
        height: sizedBoxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: isLeft ? rowWidgets : rowWidgets.reversed.toList(),
        ),
      );
  }

  final Widget tracoPadraoHorizontal = Container(
    color: info.strokeColor,
    height: info.strokeWidth,
    width: info.strokeLineSize,
  );

  final Widget tracoPadraoHorizontalWinner = Container(
    color: info.competidorWinnerColor,
    height: info.strokeWidth,
    width: info.strokeLineSize,
  );

  Widget colunaCompetidores(
      {CompetidorWidget competidorWidget1,
      CompetidorWidget competidorWidget2}) {
    return
        //color: Colors.blue,
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isLeft
              ? <Widget>[
                  competidorWidget1,
                  !competidorWidget1.isLoser
                      ? tracoPadraoHorizontalWinner
                      : tracoPadraoHorizontal
                ]
              : <Widget>[
                  !competidorWidget1.isLoser
                      ? tracoPadraoHorizontalWinner
                      : tracoPadraoHorizontal,
                  competidorWidget1
                ],
        ),
        Expanded(
          child: SizedBox(
            height: 1,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isLeft
              ? <Widget>[
                  competidorWidget2,
                  !competidorWidget2.isLoser
                      ? tracoPadraoHorizontalWinner
                      : tracoPadraoHorizontal
                ]
              : <Widget>[
                  !competidorWidget2.isLoser
                      ? tracoPadraoHorizontalWinner
                      : tracoPadraoHorizontal,
                  competidorWidget2
                ],
        ),
      ],
    );
  }
}

///BACKUP
///
/// Eu tinha feito tudo isso rsrsrrssrsr tava horrível dssosadkodpoaadpads
//import 'dart:math';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:rechavedetorneio/models/batalha_model.dart';
//import 'package:rechavedetorneio/models/competidor_model.dart';
//import 'package:rechavedetorneio/models/etapa_model.dart';
//import 'package:rechavedetorneio/views/widgets/competidor_widget.dart';
//import 'dimensoes_e_etc.dart' as info;
//
//class BatalhaWidget extends StatelessWidget {
//  bool isFirstEtapaBatalha = false;
//  bool isLeft = true;
//  bool isFinal = false;
//  final EtapaModel etapaModel; //A etapa da batalha, pra ela saber qual é a dela
//
//  final BatalhaModel batalhaModel;
//
//  int numEtapa = 0;
//
//  BatalhaWidget(
//      {@required this.batalhaModel,
//        this.isLeft,
//        this.isFinal,
//        @required this.etapaModel});
//  //Se for a batalha da primeira etapa, a organização é padrozinada e não tem a parte de trás
//  //Do contrário, é dinâmica e se expande até atingir os anteriores
//
//  @override
//  Widget build(BuildContext context) {
//    isLeft ??= false;
//    isFinal ??= false;
//
//    numEtapa = etapaModel.numEtapa;
//    //O numero de batalhas da anterior é 2x o da atual, mas divide por 2 porque as etapas sempre são dividadas meio a meio!
//    int numBatalhas = 2 * etapaModel.batalhas.length;
//    //int numBatalhasPratico = (numBatalhas / 2).round();
//    int numBatalhasPratico = (numBatalhas / 2).round();
//    isFirstEtapaBatalha = numEtapa == 0 ? true : false;
//    int numBatalhasNaEtapaZero = pow(2, numEtapa) * numBatalhasPratico;
//    double heightDaBatalhaPadrao =
//        2 * info.competidorHeight + info.defaultSpacing;
//    double heightDasBatalhasNaEtapaZero =
//        numBatalhasNaEtapaZero * heightDaBatalhaPadrao +
//            (numBatalhasNaEtapaZero - 1) * info.defaultLargeSpacing;
//    //Divide por dois porque a etapa é partida metade pra esquerda metade pra direita!
//
//    double heightDasBatalhasAnteriores =
//        (numBatalhasPratico * heightDaBatalhaPadrao) +
//            (numBatalhasPratico - 1) * info.defaultLargeSpacing;
//
//    //Primeiro descobrimos se há um vencendor:
//    bool isLoser1 = false;
//    bool isLoser2 = false;
//    if (batalhaModel.battleFinished()) {
//      isLoser1 = !batalhaModel.winnerIsOne();
//      isLoser2 = batalhaModel.winnerIsOne();
//    }
//    //Cria os widgets dos competidores
//    final CompetidorWidget competidorWidget1 = CompetidorWidget(
//      competidorModel: batalhaModel.competidor1,
//      isLoser: isLoser1,
//    );
//    final CompetidorWidget competidorWidget2 = CompetidorWidget(
//      competidorModel: batalhaModel.competidor2,
//      isLoser: isLoser2,
//    );
//
//    //Height da coluna da batalha atual:
//    double sizedBoxHeight = 0;
//    //Comprimento que separa o traçado que fecha a chave das bordas da chave (funciona como uma margem! ele expande no restante, subtraindo isso aqui)
//    double distanciaDoTraco = 0;
//    //Quantidade de batalhas da etapa anterior = 2 x a da atual
//
//    //Se for a primeira etapa, faz proporcionalmente ao esperado
//    if (isFirstEtapaBatalha) {
//      sizedBoxHeight = heightDaBatalhaPadrao;
//      distanciaDoTraco = info.competidorHeight / 2 - info.strokeWidth / 2;
//    } else {
//      //Do contrário, usa os tamanhos dos anteriores para calcular qual seria o tamanho do sized box
//      sizedBoxHeight = 2 * heightDaBatalhaPadrao +
//          2 * numEtapa * info.defaultSpacing -
//          0.5 *
//              numBatalhasPratico *
//              (info.competidorHeight - info.defaultSpacing);
//
//      sizedBoxHeight = pow(2, numEtapa) * heightDaBatalhaPadrao -
//          2 *
//              ((numEtapa + 1 / 2) * info.competidorHeight +
//                  info.defaultSpacing);
//
//      sizedBoxHeight = pow(2, numEtapa) * heightDaBatalhaPadrao;
//
//      //Funciona no 01: OK!
//      sizedBoxHeight = 2 * (heightDaBatalhaPadrao + info.defaultSpacing) -
//          2 * (info.competidorHeight - info.defaultSpacing);
//
//      sizedBoxHeight = info.defaultLargeSpacing +
//          1 * heightDaBatalhaPadrao +
//          //info.strokeWidth +
//          info.competidorHeight;
//
//      //Funciona no 02
//      if (numEtapa == 2) {
//        //O CERTO QUE FUNCIONA 100%
////        sizedBoxHeight = 2 * 2 * (heightDaBatalhaPadrao + info.defaultSpacing) -
////            2 * (info.competidorHeight + info.defaultSpacing) -
////            info.competidorHeight -
////            info.strokeWidth;
//
//        //O sized antigo é o da batalha anterior, ou seja, o 1!
//        sizedBoxHeight = heightDasBatalhasNaEtapaZero / numBatalhasPratico -
//            3 * info.defaultLargeSpacing -
//            3 * info.competidorHeight;
//
//        double heightDisponivel = heightDasBatalhasNaEtapaZero;
//        double heightPorBatalha =
//            heightDasBatalhasNaEtapaZero / numBatalhasPratico;
//        sizedBoxHeight = heightPorBatalha -
//            3 * info.competidorHeight -
//            7 * info.defaultSpacing -
//            info.strokeWidth;
//
//        sizedBoxHeight = heightPorBatalha -
//            (numEtapa - 1) * info.competidorHeight -
//            (numBatalhasPratico) * info.defaultLargeSpacing;
//      }
//
//      //FUNCIONA NO 03: OK!
//      if (numEtapa == 3) {
//        //Conta antiga
//        sizedBoxHeight = 6 * (heightDaBatalhaPadrao + info.defaultSpacing) -
//            3 * (info.competidorHeight - info.defaultSpacing) -
//            info.competidorHeight -
//            info.strokeWidth;
//
//        //Conta nova
//        sizedBoxHeight = 6 * heightDaBatalhaPadrao +
//            9 * info.defaultSpacing -
//            4 * info.competidorHeight -
//            0.5 * info.strokeWidth;
//
//        //Mais recente
//        sizedBoxHeight = heightDasBatalhasNaEtapaZero / numBatalhasPratico -
//            numBatalhasPratico * 8 * info.defaultLargeSpacing -
//            5 * info.competidorHeight;
//
//        double heightPorBatalha =
//            heightDasBatalhasNaEtapaZero / numBatalhasPratico;
//        sizedBoxHeight = heightPorBatalha -
//            9 * info.competidorHeight -
//            16 * info.defaultSpacing -
//            2 * info.strokeWidth;
//      }
//
//      //FUNCIONA NO 04 OK
//      if (numEtapa == 4) {
//        //Conta antiga
//        sizedBoxHeight = 16 * (heightDaBatalhaPadrao + info.defaultSpacing) -
//            4 * numBatalhas * (info.competidorHeight);
//
//        //Conta nova
//        sizedBoxHeight = 12 * heightDaBatalhaPadrao +
//            16 * info.defaultSpacing -
//            8 * info.competidorHeight -
//            4 * info.strokeWidth;
//
//        //Mais recente
//        sizedBoxHeight = heightDasBatalhasNaEtapaZero / numBatalhasPratico -
//            numBatalhasPratico * 8 * info.defaultLargeSpacing -
//            5 * info.competidorHeight;
//
//        double heightDisponivel = heightDasBatalhasNaEtapaZero;
//        double heightPorBatalha =
//            heightDasBatalhasNaEtapaZero / numBatalhasPratico;
//        sizedBoxHeight = heightPorBatalha -
//            19 * info.competidorHeight -
//            32 * info.defaultSpacing -
//            4 * info.strokeWidth;
//      }
//
//      //FUNCIONA NO 05 NÃO OK
//      if (numEtapa == 5) {
//        sizedBoxHeight =
//            2 * (numEtapa) * (heightDaBatalhaPadrao + info.defaultSpacing) -
//                ((numEtapa) / 2) *
//                    numBatalhas *
//                    (info.competidorHeight - info.defaultSpacing) -
//                info.competidorHeight -
//                info.strokeWidth;
//
//        //MAIS NOVO
//        double heightDisponivel = heightDasBatalhasNaEtapaZero;
//        double heightPorBatalha =
//            heightDasBatalhasNaEtapaZero / numBatalhasPratico;
//        sizedBoxHeight = heightPorBatalha -
//            39 * info.competidorHeight -
//            64 * info.defaultSpacing -
//            12 * info.strokeWidth;
//      }
//
//      if (false && numEtapa >= 2) {
//        double heightPorBatalha =
//            heightDasBatalhasNaEtapaZero / numBatalhasPratico;
//        double x = 4, y = 8, z = 1;
//        for (int i = 2; i < numEtapa; i++) {
//          x = x * 2 + 1;
//          y = y * 2;
//        }
//        numEtapa == 3 ? z = 2 : z = z * (numEtapa - 2);
//        numEtapa == 4 ? z = 6 : z = z;
//        numEtapa == 5 ? z = 12 : z = z;
//        sizedBoxHeight = heightPorBatalha -
//            x * info.competidorHeight -
//            y * info.defaultSpacing -
//            z * info.strokeWidth;
//
//        print('ETAPA $numEtapa');
//        print('num batalhas pratico = $numBatalhasPratico');
//        print('SizedBoxHeight = $sizedBoxHeight');
//        print('x = $x');
//        print('y = $y');
//        print('z = $z');
//      }
//
//      //faz por proporcionalidade em relação ao tamanho original
//      double heightPorBatalha =
//          heightDasBatalhasNaEtapaZero / (2 * numBatalhasPratico) +
//              info.competidorHeight +
//              info.strokeWidth;
//      sizedBoxHeight = heightPorBatalha;
//
//      distanciaDoTraco = info.competidorHeight / 2 - info.strokeWidth / 2;
//    }
//
//    //Margem do topo e margem de baixo são idênticas!
//    final Widget marginTopBot = SizedBox(
//      height: numEtapa * info.defaultSpacing,
//    );
//
//    List<Widget> rowWidgets = <Widget>[
//      colunaCompetidores(
//          competidorWidget1: competidorWidget1,
//          competidorWidget2: competidorWidget2),
//      Column(
//        mainAxisSize: MainAxisSize.max,
//        children: <Widget>[
//          SizedBox(
//            height: distanciaDoTraco,
//          ),
//          Expanded(
//            //Traçado vertical
//            child: Container(
//              color: info.strokeColor,
//              width: info.strokeWidth,
//              height: 1,
//            ),
//          ),
//          SizedBox(
//            height: distanciaDoTraco,
//          ),
//        ],
//      ),
//      tracoPadraoHorizontal,
//    ];
//
//    if (isFinal) {
//      return Row(
//        children: <Widget>[
//          competidorWidget1,
//          tracoPadraoHorizontal,
//          competidorWidget2
//        ],
//      );
//    } else
//      return SizedBox(
//        height: sizedBoxHeight,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          //crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: isLeft ? rowWidgets : rowWidgets.reversed.toList(),
//        ),
//      );
//  }
//
//  final Widget tracoPadraoHorizontal = Container(
//    color: info.strokeColor,
//    height: info.strokeWidth,
//    width: info.strokeLineSize,
//  );
//
//  Widget colunaCompetidores(
//      {CompetidorWidget competidorWidget1,
//        CompetidorWidget competidorWidget2}) {
//    return Container(
//      color: Colors.blue,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: isLeft
//                ? <Widget>[competidorWidget1, tracoPadraoHorizontal]
//                : <Widget>[tracoPadraoHorizontal, competidorWidget1],
//          ),
//          Expanded(
//            child: SizedBox(
//              height: 1,
//            ),
//          ),
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: isLeft
//                ? <Widget>[competidorWidget2, tracoPadraoHorizontal]
//                : <Widget>[tracoPadraoHorizontal, competidorWidget2],
//          ),
//        ],
//      ),
//    );
//  }
//}
