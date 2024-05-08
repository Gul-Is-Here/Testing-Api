import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing_api/controller/networking_controller.dart';
import 'package:testing_api/model/course_model.dart';
import 'package:testing_api/screens/home_screen.dart';

class EditUserDetails extends StatelessWidget {
  final Course? course;

  const EditUserDetails({Key? key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NetworkingController());

    // Populate form fields with course data if available
    if (course != null) {
      controller.nameController.text = course!.name;
      controller.designatedController.text = course!.course;
      controller.emailController.text = course!.otherProperties.email;
      controller.jobController.text = course!.timeSlot;
      controller.locationController.text = course!.otherProperties.location;
      controller.ageController.text = course!.otherProperties.age.toString();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        key: controller.formkey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: controller.nameController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Enter a valid Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'e.g Alex',
                        hintStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Enter a valid Designation';
                        } else {
                          return null;
                        }
                      },
                      controller: controller.designatedController,
                      decoration: InputDecoration(
                        hintText: 'e.g Flutter Developer',
                        hintStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: controller.emailController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return 'Enter a valid email';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'e.g csgpakistan@gmail.com',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Enter a valid Time';
                        } else {
                          return null;
                        }
                      },
                      controller: controller.jobController,
                      decoration: InputDecoration(
                        hintText: 'e.g Morning',
                        hintStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: controller.locationController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Enter a valid location';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'e.g Lahore',
                        hintStyle: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: controller.ageController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return 'Age must be 18 plus';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'e.g 18',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Update button...

            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (controller.formkey.currentState!.validate()) {
                    // Set loading state to true
                    controller.isLoading.value = true;

                    try {
                      // Create a new course object with updated data
                      Course newCourse = Course(
                        otherProperties: OtherProperties(
                          age: int.parse(controller.ageController.text),
                          email: controller.emailController.text.trim(),
                          location: controller.locationController.text.trim(),
                        ),
                        id: '',
                        name: controller.nameController.text.trim(),
                        course: controller.designatedController.text.trim(),
                        timeSlot: controller.jobController.text.trim(),
                        v: 0,
                      );

                      // Update the course
                      await controller.updateCourse(newCourse, newCourse.id);

                      // If update is successful, navigate back to previous screen
                      Navigator.pop(context);
                    } catch (e) {
                      // Handle errors if update fails
                      Get.snackbar('Error', 'Failed to update course');
                    } finally {
                      // Set loading state to false after update completes
                      controller.isLoading.value = false;
                    }
                  }
                },
                child: controller.isLoading.value
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
