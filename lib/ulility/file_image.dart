import 'dart:io';

import 'package:flutter/material.dart';

class FilePhoto extends StatelessWidget {
  final File imagePath;
  final Size size;

  const FilePhoto({
    Key key,
    @required this.imagePath,
    this.size = const Size.fromWidth(120),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.file(
        imagePath,
        width: size.width,
        height: size.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
