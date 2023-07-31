import 'dart:convert';

class DashboardModel {
  String room;
  String meeting_time;
  String purpose;
  String start_date;
  String end_date;
  String department;

  DashboardModel({
    required this.room,
    required this.meeting_time,
    required this.purpose,
    required this.start_date,
    required this.end_date,
    required this.department,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      room: json['room'],
      meeting_time: json['meeting_time'],
      purpose: json['purpose'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room'] = this.room;
    data['meeting_time'] = this.meeting_time;
    data['purpose'] = this.purpose;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['department'] = this.department;
    return data;
  }
}

