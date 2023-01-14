import 'dart:convert';

List<Booking> bookingFromMap(String str) => List<Booking>.from(json.decode(str).map((x) => Booking.fromMap(x)));

String bookingToMap(List<Booking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Booking {
  Booking({
    required this.Staff_id,

  });

  String Staff_id;

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        Staff_id: json["staff_id"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "staff_id": Staff_id,
      };
}
