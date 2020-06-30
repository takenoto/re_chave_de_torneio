import 'package:flutter/material.dart';
import 'package:rechavedetorneio/get_data/data.dart';
import 'package:rechavedetorneio/models/batalha_model.dart';
import 'package:rechavedetorneio/models/etapa_model.dart';
import 'package:rechavedetorneio/views/widgets/batalha_widget.dart';
import 'dimensoes_e_etc.dart' as info;

class MeiaEtapaWidget extends StatelessWidget {
  EtapaModel etapaModel;

  bool isLeft = true;
  bool isFinal = false;

  MeiaEtapaWidget({@required this.etapaModel, this.isLeft, this.isFinal});

  @override
  Widget build(BuildContext context) {
    bool isFirstEtapa = etapaModel.numEtapa == 0 ? true : false;

    Widget batalhaWidgets = !isFinal
        ? obterBatalhaWidgets(isFirstEtapa: isFirstEtapa)
        : obterBatalhaWidgetFinal();

    return Container(
      child: batalhaWidgets,
    );
  }

  //Transforma as batalhas dessa seção em widgets
  Widget obterBatalhaWidgets({bool isFirstEtapa}) {
    final List<Widget> batalhaWidgets = []; //Lista de Widgets de batalha
    final List<BatalhaModel> batalhas =
        etapaModel.batalhas; //Lista das informações das batalhas

    int contadorDeBatalhas = 0;
    for (BatalhaModel batalhaModel in batalhas) {
      //Cria um batalhaWidget usando as informações do batalhaModel
      final BatalhaWidget batalhaWidget = BatalhaWidget(
        batalhaModel: batalhaModel,
        // isLeft: contadorDeBatalhas < (batalhas.length / 2) ? true : false,
        isLeft: isLeft,
        etapaModel: etapaModel,
      );
      //Adiciona a batalha obtida à lista
      batalhaWidgets.add(batalhaWidget);
      //Coloca um sized box em baixo par dar espaço!
      contadorDeBatalhas++;
      if ((etapaModel.numEtapa == 0) && contadorDeBatalhas < batalhas.length) {
        batalhaWidgets.add(SizedBox(
          height: info.defaultLargeSpacing,
        ));
      } else if (etapaModel.numEtapa != 0 &&
          contadorDeBatalhas < batalhas.length) {
        batalhaWidgets.add(SizedBox(height: info.defaultLargeSpacing));
      }
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: batalhaWidgets);
  }

  Widget obterBatalhaWidgetFinal() {
    final List<Widget> batalhaWidgets = []; //Lista de Widgets de batalha
    final List<BatalhaModel> batalhas =
        etapaModel.batalhas; //Lista das informações das batalhas
    final BatalhaWidget batalhaFinal = BatalhaWidget(
      batalhaModel: batalhas[batalhas.length - 1],
      isFinal: true,
      etapaModel: etapaModel,
    );

    return batalhaFinal;
  }
}
