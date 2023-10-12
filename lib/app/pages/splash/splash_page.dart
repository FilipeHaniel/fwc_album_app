import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/styles/colors_app.dart';
import 'package:fwc_album_app/app/core/styles/text_styles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash page')),
      body: Container(),
    );
  }
}
