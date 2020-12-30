import 'package:flutter/material.dart';

class AssetPhoto extends StatelessWidget {
  final String imagePath;
  final Size size;

  const AssetPhoto({
    Key key,
    @required this.imagePath,
    this.size = const Size.fromWidth(120),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: size.width,
        height: size.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
