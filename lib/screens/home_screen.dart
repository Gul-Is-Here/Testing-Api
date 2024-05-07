import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_api/controller/networking_controller.dart';
import 'package:testing_api/model/course_model.dart';
import 'package:testing_api/screens/add_user_data.dart';
import 'package:testing_api/widget/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NetworkingController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddUserData();
                }));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: FutureBuilder(
        future: controller.getCourse(),
        builder: (context, AsyncSnapshot<List<Course>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              physics: snapshot.connectionState == ConnectionState.waiting
                  ? NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      buildRow('Designated', snapshot.data![index].course),
                      buildRow('Job Time', snapshot.data![index].timeSlot),
                      buildRow(
                        'Email',
                        snapshot.data![index].otherProperties.email,
                      ),
                      buildRow(
                        'Age',
                        snapshot.data![index].otherProperties.age.toString(),
                      ),
                      buildRow(
                        'Location',
                        snapshot.data![index].otherProperties.location,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
