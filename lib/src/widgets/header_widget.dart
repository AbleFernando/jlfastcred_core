import 'package:flutter/material.dart';
import 'package:jlfastcred_core/jlfastcred_core.dart';

class HeaderWidget extends StatelessWidget {
  final String image;
  final String texto;
  const HeaderWidget({
    Key? key,
    required this.image,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: image != '',
          replacement: Row(
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  texto,
                  style: JlfastcredTheme.titleSmallStyle,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(image),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      texto,
                      style: JlfastcredTheme.titleSmallStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
