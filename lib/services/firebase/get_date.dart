import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fees_tracking/models/user.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
Future<List<Date>> getDate() async {
  try {
    final querySnapshot = await firebaseFirestore.collection('payments').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Date(
          january: data["january"],
          february: data["february"],
          march: data["march"],
          april: data["april"],
          may: data["may"],
          june: data["june"],
          july: data["july"],
          august: data["august"],
          september: data["september"],
          october: data["october"],
          november: data["november"],
          december: data["december"]);
    }).toList();
  } catch (e) {}
  return []; // Hata durumunda veya veri yoksa boş bir liste döndürün
}
