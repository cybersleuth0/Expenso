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
  String filterDropdownValue = "Month";
  List<String> filterDropdownValueList = ["Month", "Year"];

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
    context.read<ExpBloc>().add(GetInitialExpEvent(type: 1));
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
                          if (filterDropdownValue == "Month") {
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
              SizedBox(height: 20), //Expense BreakDown
              BlocBuilder<ExpBloc, ExpState>(builder: (context, state) {
                if (state is ExpSuccessState) {
                  List<FilterExpenseModel> mData = state.allExpenseFromDb;
                  return SizedBox(
                    height: 200,
                    child: BarChart(
                      curve: Curves.linear,
                      duration: Duration(seconds: 3),
                      BarChartData(
                        titlesData: FlTitlesData(
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false))),
                        gridData: FlGridData(
                          show: false,
                        ),
                        barGroups: mData.map((element) {
                          DateTime date =
                              DateFormat("MM,d, yyyy").parse(element.type);
                          xValue = (filterDropdownValue == "Month")
                              ? date.month
                              : date.year;
                          print("xValue : ${xValue}");

                          return BarChartGroupData(
                            x: xValue,
                            barRods: [
                              BarChartRodData(
                                toY: element.totalAmt.toDouble(),
                                width: 25,
                                color: Color(0xff5967cd),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(5),
                                  bottom: Radius.zero,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        maxY: 100,
                      ),
                    ),
                  );
                }
                return Container();
              })
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
}
