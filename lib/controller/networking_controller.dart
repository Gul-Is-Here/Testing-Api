import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_api/model/course_model.dart';
import 'package:http/http.dart' as http;

class NetworkingController extends GetxController {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController designatedController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  void validate(BuildContext context) {
    if (formkey.currentState!.validate()) {
      Navigator.pop(context);
    }
  }

  var url = "https://node-js-api-nine.vercel.app/api/courses/";

// Get Data From Api Method OR GET Method
  Future<List<Course>> getCourse() async {
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<Course> courseData =
            data.map((json) => Course.fromJson(json)).toList();
        // print(courseData);
        return courseData;
      } else {
        throw Exception(' Failed to load Data');
      }
    } catch (error) {
      print(error.toString());
      // Handle errors if needed
    }
    throw 'Failed to load';
  }

  // Post Method send Data To server
  Future<List<Course>> postcourse({
    required String name,
    required String course,
    required String timeSlot,
    required String age,
    required String email,
    required String location,
  }) async {
    var requestBody = {
      'name': name,
      'course': course,
      'time_slot': timeSlot,
      'other_properties': {
        'age': age,
        'email': email,
        'location': location,
      },
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body) as List;
      List<Course> courseData =
          responseData.map((json) => Course.fromJson(json)).toList();
      print('Successfully created course');
      print(courseData);
      return courseData;
    } else {
      throw Exception('Failed to create course.');
    }
  }
}
