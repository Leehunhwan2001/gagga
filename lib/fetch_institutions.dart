import 'package:firebase_database/firebase_database.dart';
import 'models/institution.dart';

Future<List<Institution>> fetchInstitutions() async {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  try {
    final dataSnapshot = await databaseReference.get();

    if (dataSnapshot.exists) {
      final data = dataSnapshot.value;

      List<Institution> institutions = [];

      if (data is List) {
        // 데이터가 리스트인 경우
        for (var value in data) {
          if (value != null) {
            final map = Map<String, dynamic>.from(value as Map);
            institutions.add(Institution.fromJson(map));
          }
        }
      } else if (data is Map) {
        // 데이터가 맵인 경우
        data.forEach((key, value) {
          final map = Map<String, dynamic>.from(value as Map);
          institutions.add(Institution.fromJson(map));
        });
      } else {
        throw TypeError();
      }

      // 데이터를 출력해보는 부분
      print('Institutions: $institutions');

      return institutions;
    } else {
      return [];
    }
  } catch (e) {
    print('오류가 발생했습니다: $e');
    return [];
  }
}
