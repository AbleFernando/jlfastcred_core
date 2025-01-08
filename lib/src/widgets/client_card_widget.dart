import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jlfastcred_core/jlfastcred_core.dart';

class ClientCardWidget extends StatelessWidget {
  const ClientCardWidget({
    super.key,
    required,
    required this.simulation,
  });

  final SimulationModel simulation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: ListTile(
        leading: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
          ),
          width: 4.0,
        ),
        title: Text(
          simulation.name,
          style: JlfastcredTheme.subTitleSmallStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Produto: ${simulation.operationType}',
              style: JlfastcredTheme.subTitleSmallStyle.copyWith(fontSize: 14),
            ),
            // Text(
            //   '${simulation.status} - ${simulation.statusDigitacao}',
            //   style: JlfastcredTheme.subTitleSmallStyle
            //       .copyWith(fontSize: 14, color: JlfastcredTheme.greenColor),
            // ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: JlfastcredTheme.amberColor),
        onTap: () {
          log('Dados da simulação ${simulation.id}');
          // Navigator.of(context).pushReplacementNamed('/viewSimulation',
          //                   arguments: controller.informationForm);

          Navigator.of(context)
              .pushReplacementNamed('/client/register', arguments: simulation);
        },
      ),
    );
  }
}
