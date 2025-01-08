import 'package:flutter/material.dart';
import 'package:jlfastcred_core/src/theme/jlfastcred_theme.dart';

class IconPopupMenuWidget extends StatelessWidget {
  const IconPopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: JlfastcredTheme.blueColor, width: 2),
        ),
        child: const Icon(
          Icons.more_horiz_rounded,
          color: JlfastcredTheme.blueColor,
        ),
      ),
    );
  }
}
