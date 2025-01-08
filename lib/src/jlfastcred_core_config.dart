import 'package:jlfastcred_core/jlfastcred_core.dart';
import 'package:jlfastcred_core/src/loader/jlfastcred_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:asyncstate/asyncstate.dart';

class JlfastcredCoreConfig extends StatelessWidget {
  final ApplicationBindings? bindings;
  final List<FlutterGetItPageRouter>? pages;
  final List<FlutterGetItPageBuilder>? pagesBuilders;
  final List<FlutterGetItModule>? modules;
  final String title;
  final VoidCallback? didStart;

  const JlfastcredCoreConfig({
    super.key,
    this.bindings,
    this.pages,
    this.pagesBuilders,
    this.modules,
    required this.title,
    this.didStart,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      debugMode: kDebugMode,
      bindings: bindings,
      pages: [...pages ?? [], ...pagesBuilders ?? []],
      modules: modules,
      builder: (context, routes, flutterGetItNavObserver) {
        return AsyncStateBuilder(
          loader: JlfastcredLoader(),
          builder: (navigatorObserver) {
            if (didStart != null) {
              didStart!();
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: JlfastcredTheme.lightTheme,
              darkTheme: JlfastcredTheme.darkTheme,
              navigatorObservers: [
                navigatorObserver,
                flutterGetItNavObserver,
              ],
              routes: routes,
              title: title,
            );
          },
        );
      },
    );
  }
}
