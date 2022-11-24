import 'package:flutter/material.dart';

import '../../../common/route.dart';

class EPCVideos extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/EPC Videos',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _EPCVideos(),
    );
  }
}

class _EPCVideos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
