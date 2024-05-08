import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_api/controller/networking_controller.dart';
import 'package:testing_api/model/course_model.dart';
import 'package:testing_api/screens/add_user_data.dart';
import 'package:testing_api/screens/edit_user.dart';
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
            onPressed: () async {
              // Navigate to add user data screen
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return AddUserData();
              }));
              // After adding user data, trigger data refresh
              controller.refreshData();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: controller.getCourses(),
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
                      return Dismissible(
                        key: Key(snapshot.data![index].id
                            .toString()), // Provide a unique key
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          controller.deleteCourse(snapshot.data![index].id);
                          // Implement delete functionality here
                          // You may want to call a method in your controller to delete the item
                          // Example: controller.deleteCourse(snapshot.data![index]);
                        },
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              BuildRow(
                                onTap: () async {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return EditUserDetails(
                                      course: snapshot.data![index],
                                    );
                                  }));
                                },
                                id: snapshot.data![index].id,
                                name: snapshot.data![index].name,
                                desinatedLabel: 'Designated',
                                desinatedValue: snapshot.data![index].course,
                                jobTimeLabel: 'Job Time',
                                jobtime: snapshot.data![index].timeSlot,
                                emailLabel: "Email",
                                email:
                                    snapshot.data![index].otherProperties.email,
                                ageLabel: 'Age',
                                age: snapshot.data![index].otherProperties.age
                                    .toString(),
                                locationLabel: 'Location',
                                location: snapshot
                                    .data![index].otherProperties.location,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
