import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fees_tracking/models/user.dart';
import 'package:fees_tracking/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPanelScreen extends StatefulWidget {
  const UserPanelScreen({super.key});

  @override
  _UserPanelScreenState createState() => _UserPanelScreenState();
}

class _UserPanelScreenState extends State<UserPanelScreen> {
  Map<String, bool> paymentStatus = {};

  UserData? userData;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchPaymentStatus();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(userData?.username ?? "Loading..."),
        flexibleSpace: Container(
          decoration: AppColor.decoration,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: AppColor.decoration,
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
                    isPaid ? const Text("Paid") : const Text("Not pay"),
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

  Future<void> fetchUserInfo() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final uid = firebaseAuth.currentUser?.uid;

    if (uid != null) {
      try {
        final docSnapshot =
            await firebaseFirestore.collection('users').doc(uid).get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          setState(() {
            userData = UserData(
              uid: "",
              username: data?['username'] ?? 'Kullanıcı Adı Yok',
              flatNumber: data?['flat number'] ?? 'Daire Numarası Yok',
              pay: data?['pay'] ?? false,
              flatNo: data?['flat no'] ?? 'Daire No Yok',
            );
          });
        }
        {}
      } catch (e) {}
    }
  }

  Future<void> fetchPaymentStatus() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('payments')
          .doc(uid)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          paymentStatus = {
            'January ': docSnapshot.data()?['january'] ?? false,
            'February': docSnapshot.data()?['february'] ?? false,
            'March': docSnapshot.data()?['march'] ?? false,
            'April': docSnapshot.data()?['april'] ?? false,
            'May': docSnapshot.data()?['may'] ?? false,
            'June': docSnapshot.data()?['june'] ?? false,
            'July': docSnapshot.data()?['july'] ?? false,
            'August': docSnapshot.data()?['august'] ?? false,
            'September': docSnapshot.data()?['september'] ?? false,
            'October': docSnapshot.data()?['october'] ?? false,
            'November': docSnapshot.data()?['november'] ?? false,
            'December': docSnapshot.data()?['december'] ?? false,
          };
        });
      }
    }
  }
}
