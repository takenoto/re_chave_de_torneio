import 'dart:math';

import 'package:rechavedetorneio/get_data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:rechavedetorneio/models/batalha_model.dart';
import 'package:rechavedetorneio/models/etapa_model.dart';

import 'models/competidor_model.dart';

class Brain {
  //Batalhas da primeira etapa
  //ChaveData.getBatalhas();

  //Gera lista automática apenas para ter o que exibir
  Future<List<EtapaModel>> gerarEtapas() async {
    //#0 lista que será preenchida e retornada:
    List<EtapaModel> etapas = [];

    //#0.1 Batalhas que serão usadas na primeira etapa
    final List<BatalhaModel> batalhasIniciais = ChaveData.getBatalhas();
    List<CompetidorModel> competidores = [];
    for (BatalhaModel batalhaModel in batalhasIniciais) {
      competidores.add(batalhaModel.competidor1);
      competidores.add(batalhaModel.competidor2);
    }

    //--------------------------------------------------------------------------
    //#1 Descobrir quantas etapas teremos de cada lado
    int numeroDeCompetidores = competidores.length;
    //Cada 2 competidores brigam e geram apenas 1 --> são 2^n batalhas --> são n etapas
    int n = (log(numeroDeCompetidores) / log(2)).round();
    //Numero total são as etapas da direita + as da esquerda + a final
    int numeroTotalDeEtapas = n;
    int numeroTotalDeEtapasSemFinal = n - 1;

    //Para debug:
    print('Nº competidores = $numeroDeCompetidores');
    print('Número n = $n');
    print(
        'Número total de Etapas = $numeroTotalDeEtapasSemFinal (sem a etapa final!)');
    print(
        'Número total de Etapas = $numeroTotalDeEtapas (inclui a etapa final!)');

    //--------------------------------------------------------------------------
    //#2 Gerar as etapas da esquerda e da direita:
    //Primeira etapa: as batalhas são simplesmente arranjos 2 a 2 dos competidores na ordem que foram passados
    final EtapaModel etapaInicial =
        EtapaModel(numEtapa: 0, batalhas: batalhasIniciais);
    etapas.add(etapaInicial);
    //Roda o vetor e preenche com as demais etapas
    //O arranjo esquerda/direita é apenas ilustrativo e não faz diferença por enquanto!!!
    ///!\ CUIDADO numeroTotalDeEtapas --> ANTES ERA  numeroTotalDeEtapasSemFinal

    for (int i = 1; i < numeroTotalDeEtapas; i++) {
      final List<BatalhaModel> batalhasDaEtapaAtual = [];
      //Roda a última Batalha e pega vencedores na ordem!

      //Cria a lista de batalhas da etapa atual com os vencedores da última etapa
      //#1 obtém os vencedores
      List<CompetidorModel> vencedores = etapas[i - 1].getVencedoresDaEtapa();

      //Para contar as batalhas em ordem crescente:
      int numBatalha = 0;

      //print('len VENCEDORES = ${vencedores.length}');
      for (int j = 0; j < vencedores.length; j += 2) {
        //Vai de 2 em 2 novamente, porque jogam 1 contra o outro e em seguida já começa do 3º e do 4º, etc
        CompetidorModel competidor = vencedores[j];

        //#2 Cria as batalhas com eles na mesma ordem!
        final BatalhaModel batalhaModel = BatalhaModel(
            competidor1: vencedores[j],
            competidor2: vencedores[j + 1],
            etapaDaBatalha: i,
            numDaBatalha: numBatalha);

        numBatalha == 1
            ? batalhaModel.setWinner(competidorVencedor: 1)
            : batalhaModel.setWinner(competidorVencedor: 2);

        batalhasDaEtapaAtual.add(batalhaModel);

        numBatalha++;
      }

      final EtapaModel etapa =
          EtapaModel(numEtapa: i, batalhas: batalhasDaEtapaAtual);
      etapas.add(etapa);
    }
    //Agora retorna as etapas:
    print('Total de ${etapas.length} etapas');
    return etapas;
  }
}
