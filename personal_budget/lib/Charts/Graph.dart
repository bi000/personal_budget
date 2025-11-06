import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_budget/Charts/chart.dart';
import 'package:personal_budget/Charts/lineChart.dart';
import 'package:personal_budget/Titlebar.dart';
import 'package:personal_budget/providerData.dart';
import 'package:provider/provider.dart';
import 'package:personal_budget/Charts/dropdown.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  _myGraph createState() => _myGraph();
}

class _myGraph extends State<Graph> {
  final TextEditingController _chartData = TextEditingController();
  List<Map<String, dynamic>> extractedData = [];
  List<int> percentageCollecion = [];
  List<String> itemNameCollecion = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Graph Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: TITLE(),
      ),
      body: Consumer<dataCalculation>(
        builder: (context, chartcal, child) {
          List<dynamic> months = chartcal.getMonths;
          List<dynamic> Months2 = chartcal.getMonths2;
          List<dynamic> Ydata = chartcal.getAmount;
          List<dynamic> Ydata2 = chartcal.getAmount2;
          Map<String, dynamic> values = chartcal.data2;
          void updateChartData(String selectedMonth) {
            setState(() {
              // 1. Filter the data based on the selected month
              Map<String, dynamic> filteredValues = {};
              values.forEach((key, value) {
                if (value['PAYDATE'] == selectedMonth) {
                  filteredValues[key] = value;
                }
              });

              // 2. Clear existing lists before updating
              extractedData.clear();
              percentageCollecion.clear();
              itemNameCollecion.clear();

              // 3. Calculate total expenditure for the selected month
              int totalAmount = filteredValues.values.fold(
                0,
                (sum, item) => sum + (item['AMOUNT'] as int),
              );

              // 4. Aggregate data by item
              filteredValues.forEach((key, value) {
                String item = value['ITEMS'];
                double amount = value['AMOUNT'].toDouble();

                // Check if item already exists in extractedData
                bool itemExists = false;
                for (var entry in extractedData) {
                  if (entry['item'] == item) {
                    entry['amount'] += amount;
                    itemExists = true;
                    break;
                  }
                }

                if (!itemExists) {
                  extractedData.add({'item': item, 'amount': amount});
                }
              });

              // 5. Calculate percentages for each item
              for (var entry in extractedData) {
                int percent = percentage(entry['amount'].toInt(), totalAmount);
                entry['percentage'] = percent;
                percentageCollecion.add(entry['percentage']);
                itemNameCollecion.add(entry['item']);
              }

              // 6. Generate random colors only once
            });

            print(percentageCollecion);
            print(itemNameCollecion);
          }

          print(percentageCollecion);
          print(itemNameCollecion);
          List<Color> randomColor = generateRandomColor(
            itemNameCollecion.length,
          );
          Set<String> allMonths =
              {}; //set is collection of unique item which removes duplicate element not like list// ex. set a={1,2} a.add(2) //won't be added cause it is already there
          allMonths.addAll(
            months.map((m) => m.toString()),
          ); //both months value are added to set purpose of removing duplicate months
          allMonths.addAll(
            Months2.map((m) => m.toString()),
          ); //this will take single month value from both variable

          Map<String, double> incomeData = {
            for (var m in allMonths) m: 0,
          }; //m carries all key  with 0 as a value {"jan":0}
          Map<String, double> expenditureData = {
            for (var m in allMonths) m: 0,
          }; // same above {"jan":0}

          for (int i = 0; i < months.length; i++) {
            String month =
                months[i]
                    .toString(); //index value of months converted in string ex.months[0]="jan" as first index
            if (Ydata.isNotEmpty && i < Ydata.length && Ydata[i] != null) {
              incomeData[month] =
                  (incomeData[month] ?? 0) +
                  (Ydata[i] as int)
                      .toDouble(); //income data is Map <string,double>
              //add data expenditureData[month] as known key "jan" and 0 known as its value like
              //"jan":0 as initial vlaue when i use +(Ydata[i]as int ) means that sum with that key value
              //like "jan":0+100=100(suppose the value of Ydata is 100) then again if we provide data
              //Ydata value its like "jan":100+100=200(next value of Ydata) this is how it sum
            }
          }

          print(Ydata2);
          for (int j = 0; j < Months2.length; j++) {
            String month2 = Months2[j].toString();
            if (Ydata2.isNotEmpty && j < Ydata2.length && Ydata2[j] != null) {
              expenditureData[month2] =
                  (expenditureData[month2] ?? 0) +
                  (Ydata2[j] as int).toDouble();
              //add data expenditureData[month] as known key "jan" and 0 known as its value like
              //"jan":0 as initial vlaue when i use +(Ydata[i]as int ) means that sum with that key value
              //like "jan":0+100=100(suppose the value of Ydata is 100) then again if we provide data
              //Ydata value its like "jan":100+100=200(next value of Ydata) this is how it sum
            }
          }

          List<String> sortedMonths = allMonths.toList(); //creating list
          List<String> monthOrder = [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ];
          sortedMonths.sort(
            (a, b) => monthOrder.indexOf(a).compareTo(monthOrder.indexOf(b)),
          );
          //sort the names as define in monthOrder sortMonths two value a and b represent two month of list(sortedMonths)
          //compares to monthOrder.indexOf(a) position value with MonthOrder.indexOf(b) position value
          //where a and b represent sortedMonths value comparing vlaue with monthOrder get from allMonths

          List<double> incomeValues =
              sortedMonths.map((m) => incomeData[m] ?? 0).toList();
          List<double> expenditureValues =
              sortedMonths.map((m) => expenditureData[m] ?? 0).toList();
          print("Months: $sortedMonths");
          print("Income: $incomeValues");
          print("Expenditure: $expenditureValues");

          return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Expenditure Data",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ChartMonth(
                              label: 'hello',
                              controller: _chartData,
                              onChanged: (selected) {
                                updateChartData(selected);
                              },
                            ),
                          ],
                        ),
                        PieData(
                          piVal: percentageCollecion,
                          piColor: randomColor,
                          piTitle: List.generate(itemNameCollecion.length, (
                            index,
                          ) {
                            return '${itemNameCollecion[index].length > 10 ? "${itemNameCollecion[index].substring(0, 10)}." : itemNameCollecion[index]} (${percentageCollecion[index]}%)';
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    elevation: 5.0,
                    shadowColor: Colors.grey,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          DoubleBarChart(
                            X: sortedMonths,
                            Y1: incomeValues,
                            Y2: expenditureValues,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int percentage(int amo, int totalEx) {
    if (amo == 0 || totalEx == 0) {
      return 0;
    } else {
      double Percenatage = amo / totalEx * 100;
      int Percent = Percenatage.round();
      return Percent;
    }
  }

  List<Color> generateRandomColor(int count) {
    Random random = Random();
    return List.generate(count, (index) {
      return Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
    });
  }
}
