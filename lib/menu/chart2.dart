//
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:charts_flutter/flutter.dart';
// import 'package:charts_flutter/src/text_element.dart';
// import 'package:charts_flutter/src/text_style.dart' as style;
// import 'package:barika/menu/chart.dart';
// class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
//   @override
//   void paint(ChartCanvas canvas, Rectangle bounds,
//       {List dashPattern,
//         Color fillColor,
//         Color strokeColor,
//         double strokeWidthPx}) {
//     super.paint(canvas, bounds,
//         dashPattern: dashPattern,
//         fillColor: fillColor,
//         strokeColor: strokeColor,
//         strokeWidthPx: strokeWidthPx);
//     canvas.drawRect(
//         Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 20,
//             bounds.height + 10),
//         fill: Color.white);
//     var textStyle = style.TextStyle();
//     textStyle.color = Color.black;
//     textStyle.fontSize = 10;
//     canvas.drawText(
//         TextElement(chartState.pointerValue, style: textStyle),
//         (bounds.left).round(),
//         (bounds.top - 28).round());
//   }
// }