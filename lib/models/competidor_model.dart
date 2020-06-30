import 'package:flutter/foundation.dart';

class CompetidorModel {
  CompetidorModel(
      {this.name, @required this.useDefaultCompetidor, this.website});

  //Nome do competidor, será exibido
  String name = 'Não determinado';
  // para adicionar um website do competidor para tornar clicável, qualquer coisa do tipo todo FUTURAMENTE
  String website = '';

  //Se for sim, usaremos para criar um competidor neutro e para o usuário saber que ainda não há vencedor na chave anterior!
  final bool useDefaultCompetidor;
}
