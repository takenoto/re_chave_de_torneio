import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rechavedetorneio/models/batalha_model.dart';
import 'package:rechavedetorneio/models/etapa_model.dart';
import 'package:rechavedetorneio/views/widgets/batalha_widget.dart';
import 'package:rechavedetorneio/views/widgets/dimensoes_e_etc.dart' as info;
import 'package:rechavedetorneio/views/widgets/etapa_widget.dart';

class ChaveDeTorneioWidget extends StatelessWidget {
  List<EtapaModel> etapas = [];
  ChaveDeTorneioWidget({this.etapas});

  @override
  Widget build(BuildContext context) {
    final double heightDeUmaBatalha =
        (info.competidorHeight * 2 + info.defaultSpacing);
    final int numeroDeBatalhas = etapas[0].batalhas.length;

    return Container(
      padding: EdgeInsets.all(32),
      child: SizedBox(
        height: (numeroDeBatalhas / 2) * heightDeUmaBatalha +
            ((numeroDeBatalhas) / 2 - 1) * info.defaultLargeSpacing,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getEtapasOrdenadas(),
          ),
        ),
      ),
    );
  }

  //Cria todas as etapas
  List<Widget> getEtapasOrdenadas() {
    List<Widget> etapaWidgets = [];

    //Reorganiza para ficarem na ordem inical ao final, partindo das bordas
    List<Widget> listaOrdenadaDasEtapas = [];
    int qtdeEtapas = etapaWidgets.length;
    List<Widget> etapasDaEsquerda = [];
    List<Widget> etapasDaDireita = [];
    Widget etapaFinalCentro;

    for (EtapaModel etapa in etapas) {
      final batalhasDaVez = etapa.batalhas;
      final int qtdeBatalhas = batalhasDaVez.length;
      final List<BatalhaModel> batalhasDaEsquerda =
          batalhasDaVez.sublist(0, ((qtdeBatalhas) / 2).truncate()).toList();
      final List<BatalhaModel> batalhasDaDireita = batalhasDaVez
          .sublist((qtdeBatalhas / 2).round(), qtdeBatalhas)
          .toList();

      final EtapaModel etapaEsquerda =
          EtapaModel(numEtapa: etapa.numEtapa, batalhas: batalhasDaEsquerda);
      final EtapaModel etapaDireita =
          EtapaModel(numEtapa: etapa.numEtapa, batalhas: batalhasDaDireita);

      MeiaEtapaWidget etapaWidgetEsquerda = MeiaEtapaWidget(
        etapaModel: etapaEsquerda,
        isLeft: true,
        isFinal: false,
      );
      MeiaEtapaWidget etapaWidgetDireita = MeiaEtapaWidget(
        etapaModel: etapaDireita,
        isLeft: false,
        isFinal: false,
      );

      etapasDaEsquerda.add(etapaWidgetEsquerda);
      //etapasDaEsquerda.add(SizedBox(height: info.defaultLargeSpacing));
      etapasDaDireita.add(etapaWidgetDireita);
      //etapasDaDireita.add(SizedBox(height: info.defaultLargeSpacing));
    }

    //Agora organiza dentro do etapasOrdenadas
    //Separa os da direita e da esquerda usando a qtde de etapas:
    listaOrdenadaDasEtapas = etapasDaEsquerda;
    //Etapa final, que fica bem no meio:
    etapaFinalCentro = MeiaEtapaWidget(
      etapaModel: etapas[etapas.length - 1],
      isFinal: true,
    );
    listaOrdenadaDasEtapas.add(etapaFinalCentro);
    //Etapas da direita:
    for (Widget etapaWidgets in etapasDaDireita.reversed.toList()) {
      listaOrdenadaDasEtapas.add(etapaWidgets);
    }

    return listaOrdenadaDasEtapas;
  }
}
