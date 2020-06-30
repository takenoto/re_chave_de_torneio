import 'package:flutter/material.dart';
import 'package:rechavedetorneio/models/competidor_model.dart';
import 'dimensoes_e_etc.dart' as info;

class CompetidorWidget extends StatelessWidget {
  final CompetidorModel competidorModel;
  bool isLoser = false;
  CompetidorWidget({@required this.competidorModel, this.isLoser});

  @override
  Widget build(BuildContext context) {
    //Se for vencedor usa tudo normal. Se não, usa a cor padrão.
    return Container(
      width: info.competidorWidth,
      height: info.competidorHeight,
      color: !isLoser ? info.competidorWinnerColor : info.competidorLoserColor,
      padding: EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Text(
        competidorModel.name,
        softWrap: false,
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }
}
