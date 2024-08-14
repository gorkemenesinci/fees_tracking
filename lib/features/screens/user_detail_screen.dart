import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fees_tracking/models/user.dart';
import 'package:fees_tracking/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  final UserData user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  Map<String, bool> paymentStatus = {};
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fetchPaymentStatus();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: AppColor.decoration,
        ),
        title: Text(widget.user.username),
        centerTitle: true,
        actions: const [BackButton()],
      ),
      body: Container(
        decoration: AppColor.decoration,
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: paymentStatus.length,
          itemBuilder: (context, index) {
            String month = paymentStatus.keys.elementAt(index);
            bool isPaid = paymentStatus[month] ?? false;
            return Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.02),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.black38,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(month),
                trailing: Column(
                  children: [
                    isPaid ? const Text("Paid") : const Text("Not Paid"),
                    Icon(
                      isPaid ? Icons.check : Icons.close,
                      color: isPaid ? Colors.green[900] : Colors.red,
                    ),
                  ],
                ),
                enabled: !isPaid,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchPaymentStatus() async {
    try {
      final uid = widget.user.uid;

      final docSnapshot = await FirebaseFirestore.instance
          .collection('payments')
          .doc(uid)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          setState(() {
            paymentStatus = {
              'January': data['january'] ?? false,
              'February': data['february'] ?? false,
              'March': data['march'] ?? false,
              'April': data['april'] ?? false,
              'May': data['may'] ?? false,
              'June': data['june'] ?? false,
              'July': data['july'] ?? false,
              'August': data['august'] ?? false,
              'September': data['september'] ?? false,
              'October': data['october'] ?? false,
              'November': data['november'] ?? false,
              'December': data['december'] ?? false,
            };
          });
        } else {
          print("Belge verisi boş.");
        }
      } else {
        print("Belirtilen kullanıcı için veri bulunamadı.");
      }
    } catch (e) {
      print("Ödeme durumu alınırken hata: $e");
    }
  }
}
