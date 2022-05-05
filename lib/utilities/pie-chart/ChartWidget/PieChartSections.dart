import 'package:fl_chart/fl_chart.dart';
import 'package:haggle/utilities/pie-chart/ChartData/ChartData.dart';
import 'package:flutter/material.dart';

// List<PieChartSectionData> getSections(PieChartSectionData productData) => productData.map<int, PieChartSectionData>((index, data) {
//   // final isTouched = index == touchedIndex;
//   // final double fontSize = isTouched ? 25 : 16;
//   // final double radius = isTouched ? 100 : 80;
//
//   final value = PieChartSectionData(
//     color: data.color,
//     value: data.percent,
//     title: '${data.percent}%',
//     radius: 80.0,
//     titleStyle: const TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.bold,
//       color: Color(0xffffffff),
//     ),
//   );
//
//   return MapEntry(index, value);
// })
//     .values
//     .toList();

List<PieChartSectionData> getSections(productData) => List.generate(productData.length, (index) {
  switch(index){
    case 0:
      return PieChartSectionData(
    color: productData[index].color,
    value: productData[index].percent,
    title: '${productData[index].percent}%',
    radius: 80.0,
    titleStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Color(0xffffffff),
    ),
  );

    case 1:
      return PieChartSectionData(
        color: productData[index].color,
        value: productData[index].percent,
        title: '${productData[index].percent}%',
        radius: 80.0,
        titleStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );

    case 2:
      return PieChartSectionData(
        color: productData[index].color,
        value: productData[index].percent,
        title: '${productData[index].percent}%',
        radius: 80.0,
        titleStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    default:
      return PieChartSectionData(
        color: const Color(0xff13d38e),
        value: 0,
        title: '0',
        radius: 80.0,

        titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
      );

  }
});