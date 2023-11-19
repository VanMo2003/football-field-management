import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../api/model/revenue.dart';
import '../../../api/request/revenue_request.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key, required this.nameFootballField});
  final String nameFootballField;

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  List<RevenueModel> data = [
    RevenueModel('Mon', 0),
    RevenueModel('Tue', 0),
    RevenueModel('Wed', 0),
    RevenueModel('Thu', 0),
    RevenueModel('Fri', 0),
    RevenueModel('Sat', 0),
    RevenueModel('Sun', 0),
  ];
  String reponse = '0-0-0-0-0-0-0';
  @override
  void initState() {
    super.initState();
    RevenueRequest.getRevenueOfWeek(widget.nameFootballField).then((value) {
      reponse = value;
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          List<String> revenue = reponse.split("-");
          for (var i = 0; i < 7; i++) {
            data[i].revenue = double.parse(revenue[i]);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo doanh thu'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          //Initialize the chart widget
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Doanh thu trong tuần'),
            // Enable legend
            legend: const Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<RevenueModel, String>>[
              ColumnSeries<RevenueModel, String>(
                dataSource: data,
                xValueMapper: (RevenueModel revenueModel, _) =>
                    revenueModel.dayOfWeek,
                yValueMapper: (RevenueModel revenueModel, _) =>
                    revenueModel.revenue,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ],
          ),
        ],
      ),
    );
  }
}
