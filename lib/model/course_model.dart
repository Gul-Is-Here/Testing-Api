import 'package:meta/meta.dart';
import 'dart:convert';

class Course {
    final OtherProperties otherProperties;
    final String id;
    final String name;
    final String course;
    final String timeSlot;
    final int v;

    Course({
        required this.otherProperties,
        required this.id,
        required this.name,
        required this.course,
        required this.timeSlot,
        required this.v,
    });

    factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        otherProperties: OtherProperties.fromJson(json["other_properties"]),
        id: json["_id"],
        name: json["name"],
        course: json["course"],
        timeSlot: json["time_slot"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "other_properties": otherProperties.toJson(),
        "_id": id,
        "name": name,
        "course": course,
        "time_slot": timeSlot,
        "__v": v,
    };
}

class OtherProperties {
    final int age;
    final String email;
    final String location;

    OtherProperties({
        required this.age,
        required this.email,
        required this.location,
    });

    factory OtherProperties.fromRawJson(String str) => OtherProperties.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OtherProperties.fromJson(Map<String, dynamic> json) => OtherProperties(
        age: json["age"],
        email: json["email"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "age": age,
        "email": email,
        "location": location,
    };
}
