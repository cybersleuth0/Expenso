import 'dart:math';

import 'package:expenso/Bloc/ExpBloc/expBloc.dart';
import 'package:expenso/Bloc/ExpBloc/expEvents.dart';
import 'package:expenso/Bloc/ExpBloc/expState.dart';
import 'package:expenso/data/Model/FilterModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatisticPage extends StatefulWidget {
  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  String filterDropdownValue = "Day";
  List<String> filterDropdownValueList = ["Day", "Month", "Year"];

  int xValue = 0;
  DateFormat dateformater = DateFormat();

  // List<Map<String, dynamic>> graphData = [
  //   {"x": 5, "y": 10.toDouble()},
  //   {"x": 10, "y": 20.toDouble()},
  //   {"x": 15, "y": 40.toDouble()},
  //   {"x": 20, "y": 60.toDouble()},
  //   {"x": 25, "y": 80.toDouble()},
  // ];

  @override
  void initState() {
    super.initState();
    context.read<ExpBloc>().add(GetInitialExpEvent(type: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistic",
            style: TextStyle(
                fontSize: 28,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Expense Total box
              Container(
                height: 140,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff5967cd),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Expense Total",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.more_horiz_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "₹ 3,722",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2),
                            customProgressBar(progress: 0.8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text("Expense Breakdown",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins")),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                      child: DropdownMenu(
                        initialSelection: filterDropdownValue,
                        onSelected: (String? newValue) {
                          filterDropdownValue = newValue!;
                          if (filterDropdownValue == "Day") {
                            context
                                .read<ExpBloc>()
                                .add(GetInitialExpEvent(type: 0));
                          } else if (filterDropdownValue == "Month") {
                            context
                                .read<ExpBloc>()
                                .add(GetInitialExpEvent(type: 1));
                          } else {
                            context
                                .read<ExpBloc>()
                                .add(GetInitialExpEvent(type: 2));
                          }
                        },
                        dropdownMenuEntries:
                            filterDropdownValueList.map((newvalue) {
                          return DropdownMenuEntry(
                              value: newvalue, label: newvalue);
                        }).toList(),
                        inputDecorationTheme: InputDecorationTheme(
                            contentPadding: EdgeInsets.only(left: 5),
                            border: InputBorder.none),
                      ))
                ],
              ),
              SizedBox(height: 2), //Expense BreakDown
              Text("Limit: \₹2,000 / Week",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: "Poppins")), //Limit
              //bar chart
              SizedBox(height: 20),
              //Expense BreakDown

              BlocBuilder<ExpBloc, ExpState>(
                builder: (context, state) {
                  // If the state is ExpSuccessState, it means data has been successfully loaded from the database.
                  if (state is ExpSuccessState) {
                    // Extract the list of expense data from the state.
                    List<FilterExpenseModel> mData = state.allExpenseFromDb;

                    // Calculate the maximum Y value to properly scale the chart.
                    double maxY = calculateMaxY(mData);

                    // Show the bar chart in a box of fixed height.
                    return SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                            // Set maximum height for the Y-axis.
                            maxY: maxY,
                            // Spacing between groups (bars) on the X-axis.
                            groupsSpace: 1,
                            // Hide the horizontal grid lines.
                            gridData: FlGridData(show: false),
                            // Hide the border around the chart.
                            borderData: FlBorderData(show: false),
                            // Configure labels for the X and Y axes.
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  // Enable showing labels at the bottom.
                                  reservedSize: 30,
                                  // Space reserved for labels.
                                  getTitlesWidget: (value, _) => getBottomTitle(
                                      value, filterDropdownValue),
                                  // Provide label based on selected filter.
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles:
                                        false), // Hide Y-axis (left) labels.
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles:
                                        false), // Hide right-side labels.
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: false), // Hide top-side labels.
                              ),
                            ),
                            // Configuration for bar touch interaction (tooltip on tap).
                            barTouchData: BarTouchData(
                              enabled: true,
                              // Enable touch interaction on bars.
                              touchTooltipData: BarTouchTooltipData(
                                tooltipRoundedRadius: 8,
                                // Rounded corner for tooltip box.
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  // Show tooltip with amount (₹) when a bar is tapped.
                                  return BarTooltipItem(
                                    '₹${rod.toY.toStringAsFixed(2)}',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Build the bar data for each group using the mData list.
                            barGroups: mData.map((element) {
                              try {
                                switch (filterDropdownValue) {
                                  case "Day":
                                    xValue = DateFormat("MMMM d, y")
                                        .parse(element.type)
                                        .day;
                                    break;
                                  case "Month":
                                    xValue = int.tryParse(element.type) ??
                                        DateFormat.MMMM()
                                            .parse(element.type)
                                            .month;
                                    break;
                                  case "Year":
                                    xValue = int.tryParse(element.type) ?? 0;
                                    break;
                                  default:
                                    xValue = 0;
                                }
                              } catch (_) {
                                xValue = 0;
                              }
                              return BarChartGroupData(
                                x: xValue,
                                barRods: [
                                  BarChartRodData(
                                    toY: element.totalAmt.abs().toDouble(),
                                    backDrawRodData: BackgroundBarChartRodData(
                                      show: true,
                                      color: Colors.grey.shade400,
                                      toY: maxY,
                                    ),
                                    // Height of the bar.
                                    color: Colors.blue,
                                    // Bar color.
                                    width: 16,
                                    // Width of the bar.
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                ],
                              );
                            }).toList()
                            // Convert to list to render the chart.
                            ),
                      ),
                    );
                  }

                  // If the state is loading, show a loading spinner.
                  if (state is ExpLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Center(
                      child: Text(
                    "You Have No Expense\nClick On the + Icon to add...",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: "Poppins"),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //This is for progress bar
  Widget customProgressBar({required double progress}) {
    return SizedBox(
      height: 10,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade200, // background color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          FractionallySizedBox(
            widthFactor: progress, // from 0.0 to 1.0
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orangeAccent, // progress color
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //This will give me value of x date or month or year
  Widget getBottomTitle(double value, String filterDropdownValue) {
    String label = '';
    try {
      switch (filterDropdownValue) {
        case "Day":
          DateTime date = DateTime.now().copyWith(day: value.toInt());
          label = DateFormat.E().format(date); // Mon, Tue, etc.
          break;
        case "Month":
          DateTime monthDate = DateTime(0, value.toInt());
          label = DateFormat.MMM().format(monthDate); // Jan, Feb, etc.
          break;
        case "Year":
          label = value.toInt().toString();
          break;
      }
    } catch (_) {
      label = '';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  double calculateMaxY(List<FilterExpenseModel> mData) {
    final maxExpense = mData.fold<double>(
      0,
      (prev, element) => max(prev, element.totalAmt.abs().toDouble()),
    );
    return maxExpense > 0 ? (maxExpense * 1.2).ceilToDouble() : 100;
  }
}
