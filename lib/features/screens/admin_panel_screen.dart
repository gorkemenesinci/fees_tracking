import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fees_tracking/features/screens/user_detail_screen.dart';
import 'package:fees_tracking/models/user.dart';
import 'package:fees_tracking/utils/color.dart';
import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<UserData> _user = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
        flexibleSpace: Container(
          decoration: AppColor.decoration,
        ),
        title: const Text("Admin"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user.isEmpty
              ? const Center(child: Text("No Found User"))
              : Container(
                  decoration: AppColor.decoration,
                  child: ListView.builder(
                    itemCount: _user.length,
                    itemBuilder: (context, index) {
                      final user = _user[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.02),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailScreen(user: user),
                            ));
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Flat Number: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                user.username,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Apartment No: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                user.flatNo,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Future<void> fetchUser() async {
    try {
      final userCollection = firestore.collection('users');
      final querySnapshot = await userCollection.get();

      if (querySnapshot.docs.isEmpty) {
        setState(() {
          _user = [];
          _isLoading = false;
        });
        return;
      }

      List<UserData> users = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return UserData(
          uid: doc.id,
          username: data['username'] ?? 'No Info',
          flatNo: data['flat no'] ?? 'No Info',
          flatNumber: data['flat number'] ?? "No Info",
          pay: data['pay'] ?? true,
        );
      }).toList();

      setState(() {
        _user = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Veri çekme sırasında bir hata oluştu: $e");
    }
  }
}
