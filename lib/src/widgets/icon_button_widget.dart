import 'package:flutter/material.dart';

import '../../jlfastcred_core.dart';

class IconButtonWidget extends StatelessWidget {
  final String texto;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isClick;

  const IconButtonWidget({
    super.key,
    required this.texto,
    required this.icon,
    required this.onPressed,
    this.isClick = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(10.0),
            elevation: 5.0,
          ),
          child: Icon(
            icon,
            size: 40.0,
          ),
        ),
        Text(
          texto,
          style: isClick
              ? JlfastcredTheme.subTitleSmallStyleGreen
              : JlfastcredTheme.subTitleSmallStyle,
        )
      ],
    );
  }
}
