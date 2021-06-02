import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///This class used to display SVG Image
class SVGLoader extends StatelessWidget {
  final Size svgSize;
  final Color color;
  final String urlImage;

  SVGLoader(
      {@required this.svgSize, this.color, @required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return _loadIcon();
  }

  //set svg icon
  Widget _loadIcon() {
    return SvgPicture.asset(
      urlImage,
      color: color,
      height: svgSize.height,
      width: svgSize.width,
    );
  }
}
