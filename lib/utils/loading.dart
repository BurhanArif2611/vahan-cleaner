import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class Utility {
  static Widget loaderWidget(bool _isLoading) {
    return _isLoading == true
        ? const Positioned(
      child: Center(
        child: GMTLoader(),
      ),
    )
        : Container();
  }
}

/// Custom activity indicator component.
class GMTLoader extends StatelessWidget {
  const GMTLoader({Key? key}) : super(key: key);

  /*
  - Method use to build screen and its a screens life cycle method.
  - Parameter -> @BuildContext - Current widget context.
  - Return -> Return a widget.
  */
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.33),
      ),
      child: Center(
        child: Platform.isIOS
            ? CupertinoTheme(
          data: CupertinoTheme.of(context)
              .copyWith(brightness: Brightness.dark),
          child: const CupertinoActivityIndicator(
            animating: true,
            radius: 25,
          ),
        )
            : const CircularProgressIndicator(color: AppColor.green_500),
      ),
    );
  }
}