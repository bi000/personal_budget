import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DoubleBarChart extends StatelessWidget {
  final List<String> X;
  final List<double> Y1;
  final List<double> Y2;

  const DoubleBarChart({super.key, required this.X, required this.Y1, required this.Y2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Indicator Row (Legend)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.green, size: 10), // Saving
              SizedBox(width: 4),
              Text('Income', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

              SizedBox(width: 12), // Space between indicators

              Icon(Icons.circle, color: Colors.red, size: 10), // Expenditure
              SizedBox(width: 4),
              Text('Expenditure', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        // Scrollable Bar Chart
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enables horizontal scrolling
          padding: EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.4, // Adjust width for scroll
              height: MediaQuery.of(context).size.height * 0.4, // Adjust height for scroll
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    handleBuiltInTouches: true,
                  ),
                  gridData: FlGridData(show: false), // Hiding the box
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true, // Showing Y-axis value
                        getTitlesWidget: (value, meta) => Text('${value.toInt()}'),
                        reservedSize: 50, // Increased the space to create a gap between chart and Y data
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5.0,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < X.length) {
                            return Text(X[index], style: TextStyle(fontSize: 10));
                          }
                          return const Text('');
                        },
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hiding top titles
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hiding right titles
                  ),
                  borderData: FlBorderData(show: false), // Hiding border
                  barGroups: List.generate(X.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(toY: Y1[index], color: Colors.green, width: 8), // Saving
                        BarChartRodData(toY: Y2[index], color: Colors.red, width: 8), // Expenditure
                      ],
                      barsSpace: 4,
                    );
                  }),
                  alignment: BarChartAlignment.start,
                ),
                // Adding animation
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
