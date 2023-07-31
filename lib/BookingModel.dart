import 'dart:convert';
// BookingModel bookingModelFromJson(String str) => BookingModel.fromJson(json.decode(str));
// String bookingModelToJson(BookingModel data) => json.encode(data.toJson());
class BookingModel {
  List<BookingModel>? bookings;
  String? room;
  String? meetingtime;
  String? purpose;
  String? startdate;
  String? enddate;
  String? department;
  int? no_of_participant;

  BookingModel({
    required this.room,
    required this.meetingtime,
    required this.purpose,
    required this.startdate,
    required this.enddate,
    required this.department,
    required this.no_of_participant,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      BookingModel(
        // id: json["id"] ,
        room: json["room"],
        meetingtime: json["meetingtime"],
        purpose: json["Purpose"],
        startdate: json["startDate"],
        enddate: json["enddate"],
        department: json["department"],
        no_of_participant: json["no_of_participant"],);

  Map<String, dynamic> toJson() {
    return {
      "room": room,
      "meetingtime": meetingtime,
      "purpose": purpose,
      "StartDate": startdate,
      "endDate": enddate,
      "department": department,

    };
  }
}
