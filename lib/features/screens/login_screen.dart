import 'package:fees_tracking/features/widgets/login_button.dart';
import 'package:fees_tracking/features/widgets/login_textfield.dart';
import 'package:fees_tracking/services/firebase/auth.dart';
import 'package:fees_tracking/utils/color.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final image = Image.asset(
      "assets/images/user_login_image.png",
      width: screenWidth * 0.6,
    );
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: AppColor.decoration,
        ),
      ),
      body: Container(
        decoration: AppColor.decoration,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "FEES TRACKING",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: screenHeight * 0.08),
                image,
                SizedBox(height: screenHeight * 0.08),
                LoginTextfield(
                    prefixIcon: const Icon(Icons.person),
                    controller: controller1,
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: "Username : "),
                SizedBox(height: screenHeight * 0.04),
                LoginTextfield(
                    prefixIcon: const Icon(Icons.password),
                    controller: controller2,
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: "Password : "),
                SizedBox(height: screenHeight * 0.07),
                LoginButton(
                    onPress: () {
                      login(
                        context,
                        controller1.text,
                        controller2.text,
                      );
                    },
                    text: Text(
                      "Login",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
