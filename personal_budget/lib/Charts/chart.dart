import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieData extends StatelessWidget {
  final List<int> piVal;
  final List<Color> piColor;
  final List<String> piTitle;

  PieData({required this.piVal, required this.piColor, required this.piTitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.4,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 40,
              borderData: FlBorderData(show: false),
              sections: List.generate(piVal.length, (index) {
                return PieChartSectionData(
                  color: piColor[index],
                  value: piVal[index].toDouble(),
                  title: piTitle[index],
                  radius: 80,
                  titleStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: List.generate(piTitle.length, (index) {
            return GestureDetector(
              onTap: () {
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 16, height: 16, color: piColor[index]),
                  SizedBox(width: 4),
                  Text(piTitle[index], style: TextStyle(fontSize: 14)),
                ],
              ),
            );
          }),
        ), 
      ],
    );
  }
}
