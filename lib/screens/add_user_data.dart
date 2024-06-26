import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing_api/controller/networking_controller.dart';
import 'package:testing_api/model/course_model.dart';
import 'package:testing_api/screens/home_screen.dart';

class AddUserData extends StatelessWidget {
  const AddUserData({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NetworkingController());
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
                          return 'Enter a valid Degination';
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
                    return 'Enter valid email';
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
            SizedBox(
              width: double.infinity,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (controller.formkey.currentState!.validate()) {
                        controller.isLoading.value = true;
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
                        await controller.postCourse(newCourse);
                        controller.isLoading.value = false;
                        Duration threSecond = Duration(seconds: 2);

                        Future.delayed(threSecond, () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        });
                      }
                    },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
