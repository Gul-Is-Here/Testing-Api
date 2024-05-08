import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:testing_api/model/course_model.dart';
import 'package:http/http.dart' as http;

class NetworkingController extends GetxController {
  final formkey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController designatedController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void validate(BuildContext context) {
    if (formkey.currentState!.validate()) {
      Duration threSecond = Duration(seconds: 2);
      Future.delayed(threSecond, () {
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.text;
    designatedController.text;
    emailController.text;
    jobController.text;
    locationController.text;
    timeController.text;
    ageController.text;
  }

  var url = "https://node-js-api-nine.vercel.app/api/courses/";

// Get Data From Api Method OR GET Method
  Stream<List<Course>> getCourses() async* {
    // Add your URL here
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final courses = data.map((json) => Course.fromJson(json)).toList();
        yield courses;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      // Handle errors gracefully
    }
  }

  void refreshData() {
    getCourses();
  }

  Future<void> postCourse(Course course) async {
    final String apiUrl = url;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: course.toRawJson(),
    );

    if (response.statusCode == 201) {
      print('Course added successfully!');
    } else {
      print('Failed to add course: ${response.body}');
    }
  }

  // Delete Method of Api
  Future<void> deleteCourse(String courseId) async {
    final String apiUrl = '$url$courseId';

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Course deleted successfully!');
      print(courseId);
    } else {
      print('Failed to delete course: ${response.statusCode}');
      throw Exception('Failed to delete course');
    }
  }

  // PATCH/UPDATE/PUT Api Method

  Future<Stream<void>> updateCourse(
      Course updatedCourse, String courseId) async {
    // Construct the API URL based on the course ID

    final String apiUrl =
        'https://node-js-api-nine.vercel.app/api/courses/663bdde28221c4a6cf8e8245';

    try {
      final response = await http.put(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: updatedCourse.toRawJson());
      print(updatedCourse.toRawJson());
      print(courseId);
      if (response.statusCode == 200) {
        print('Course updated successfully!');
      } else {
        print('Failed to update course: ${response.statusCode}');
        throw Exception('Failed to update course');
      }
    } catch (e) {
      print('Failed to update course: $e');
      throw Exception('Failed to update course: $e');
    }
    throw "Failed";
  }
}
