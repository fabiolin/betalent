import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/views/home_view.dart';

class SplashScreenView extends ConsumerStatefulWidget {
  const SplashScreenView({super.key});

  static const String route = '/';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SplashScreenViewState();
}

void gotoLogin(BuildContext context) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const HomeView()));
}

class _SplashScreenViewState extends ConsumerState<SplashScreenView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        gotoLogin(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: const Color(0xff0500FF),
          child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Center(
                  child: GestureDetector(
                      child: Image.asset('assets/images/logo_white.png'),
                      onTap: () => gotoLogin(context)))));
    });
  }
}
