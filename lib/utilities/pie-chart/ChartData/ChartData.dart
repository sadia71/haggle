import 'package:flutter/material.dart';

class ChartData {
  static List<Data> data = [
    Data(name: 'Ongoing', percent: 40, color: const Color(0xff0293ee)),
    Data(name: 'Not Completed', percent: 30, color: Colors.red),
    Data(name: 'Completed', percent: 0, color: const Color(0xff13d38e)),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}