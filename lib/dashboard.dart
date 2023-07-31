import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart'as http;

class DashboardModel {
  final String id;
  final String room;
  final String meetingTime;
  final String purpose;
  final String startdate;
  final String enddate;
  final String department;

  DashboardModel({
    required this.id,
    required this.room,
    required this.meetingTime,
    required this.purpose,
    required this.startdate,
    required this.enddate,
    required this.department,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      id: json['id'],
      room: json['room'],
      meetingTime: json['meetingtime'],
      purpose: json['purpose'],
      startdate: json['startdate'],
      enddate: json['enddate'],
      department: json['department'],
    );
  }
}
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<DashboardModel> dashboardModelList = [];

  Future<void> _fetchDashboardModel() async {
    try {
      var response = await Dio().get("http://10.5.0.132/bookings/bookings.php");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.data);
        List<DashboardModel> dashboardModelList = [];
        for (var item in jsonData['data']) {
          DashboardModel dashboardModel = DashboardModel.fromJson(item);
          dashboardModelList.add(dashboardModel);
        }
        // return dashboardModelList;
      } else {
        throw Exception('Failed to load booking details');
      }
    }catch(e) {
      throw Exception('Error fetching Data:$e');
    }
    }

  @override
  void initState() {
    super.initState();
    _fetchDashboardModel().then((value) {
      setState(() {
        dashboardModelList;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text('Welcome'),
                Text('BOOKED ROOMS'),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Id')),
                      DataColumn(label: Text('Room')),
                      DataColumn(label: Text('Meeting Time')),
                      DataColumn(label: Text('Purpose')),
                      DataColumn(label: Text('Start Date')),
                      DataColumn(label: Text('End Date')),
                      DataColumn(label: Text('Department')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: dashboardModelList
                        .map(
                          (dashboardModelList) => DataRow(
                        cells: [
                          DataCell(Text(dashboardModelList.id)),
                          DataCell(Text(dashboardModelList.room)),
                          DataCell(Text(dashboardModelList.meetingTime)),
                          DataCell(Text(dashboardModelList.purpose)),
                          DataCell(Text(dashboardModelList.startdate)),
                          DataCell(Text(dashboardModelList.enddate)),
                          DataCell(Text(dashboardModelList.department)),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                // Perform your action here
                              },
                              child: Text('Action'),
                            ),
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
