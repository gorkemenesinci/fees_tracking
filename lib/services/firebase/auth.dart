import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fees_tracking/features/screens/admin_panel_screen.dart';
import 'package:fees_tracking/features/screens/user_panel_screen.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<void> login(BuildContext context, String email, String password) async {
  try {
    // Admin login kontrolü
    if (email == 'admin@admin.com') {
      if (password == 'admin123') {
        // Admin giriş başarılı
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminPanelScreen(),
          ),
        );
      } else {
        // Admin için yanlış şifre
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hatalı şifre")),
        );
      }
    } else {
      // Kullanıcı login işlemi
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      print("Giriş başarılı: ${userCredential.user?.email}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserPanelScreen(),
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Giriş hatası: ${e.message}")),
    );
  }
}
