import 'package:flutter/material.dart';

class BuildRow extends StatelessWidget {
  BuildRow(
      {super.key,
      required this.name,
      required this.id,
      required this.desinatedLabel,
      required this.desinatedValue,
      required this.jobTimeLabel,
      required this.jobtime,
      required this.emailLabel,
      required this.email,
      required this.ageLabel,
      required this.age,
      required this.locationLabel,
      required this.location,
      required this.onTap});
  final String name;
  final String id;
  final String desinatedLabel;
  final String desinatedValue;
  final String jobTimeLabel;
  final String jobtime;
  final String emailLabel;
  final String email;
  final String ageLabel;
  final String age;
  final String locationLabel;
  final String location;
  Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(onPressed: onTap, icon: Icon(Icons.edit))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                desinatedLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(desinatedValue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                jobTimeLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(jobtime),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                emailLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(email),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ageLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(age),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                locationLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(location),
            ],
          ),
        ],
      ),
    );
  }
}
