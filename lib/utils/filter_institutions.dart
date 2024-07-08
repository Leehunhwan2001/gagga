import 'dart:convert';
import '../models/institution.dart'; // 실제 경로로 바꾸세요

// 프로그램 종류에 따른 필터링 함수
List<Institution> filterInstitutions(List<Institution> institutions, List<String> filters) {
  return institutions.where((institution) {
    bool matches = false;

    if (filters.contains('회화 General English') && institution.programs.containsKey('General Program')) {
      matches = true;
    }
    if (filters.contains('공인 인증 시험 대비') && institution.programs.containsKey('Test Preparation Program')) {
      matches = true;
    }
    if (filters.contains('취미반') && institution.programs.containsKey('Extra Activities')) {
      matches = true;
    }
    if (filters.contains('비즈니스') && institution.programs.containsKey('Business English')) {
      matches = true;
    }
    if (filters.contains('대학 입학과정') && institution.programs.containsKey('Univ Prep')) {
      matches = true;
    }
    if (filters.contains('정하고 있는 중이에요')) {
      matches = true;
    }

    return matches;
  }).toList();
}

// 한국인 비율에 따른 필터링 함수
List<Institution> filterInstitutionsByNationality(List<Institution> institutions, List<String> filters) {
  return institutions.where((institution) {
    bool matches = false;
    int krPercentage = institution.nationalityKR;

    if (filters.contains('없으면 좋겠다. \n(x<5%)') && krPercentage < 5) {
      matches = true;
    }
    if (filters.contains('그래도 조금은 있었으면 좋겠다\n(5<=x<10)') && krPercentage >= 5 && krPercentage < 10) {
      matches = true;
    }
    if (filters.contains('한국인이 있으면 좋다\n(10<=x<25)') && krPercentage >= 10 && krPercentage < 25) {
      matches = true;
    }
    if (filters.contains('한국인들이 많아야 편하다\n(25<=x)') && krPercentage >= 25) {
      matches = true;
    }

    return matches;
  }).toList();
}

// 설립 연도에 따른 필터링 함수
List<Institution> filterInstitutionsByYear(List<Institution> institutions, List<String> filters) {
  return institutions.where((institution) {
    bool matches = false;
    int year = institution.establishedYear;

    if (filters.contains('오래된 어학원이 좋아요.\n(x<1995)') && year < 1995) {
      matches = true;
    }
    if (filters.contains('상관 없어요.\n(모두 포함)')) {
      matches = true;
    }
    if (filters.contains('신생 어학원이 좋아요.\n(1995<=x)') && year >= 1995) {
      matches = true;
    }

    return matches;
  }).toList();
}

// 학생 수에 따른 필터링 함수
List<Institution> filterInstitutionsByTotalStudents(List<Institution> institutions, List<String> filters) {
  return institutions.where((institution) {
    bool matches = false;
    int totalStudents = institution.totalStudent; // 여기서 totalStudents 필드가 모델에 정의되어 있는지 확인하세요

    if (filters.contains('전체 정원 100명 이하 \n(x<=100)') && totalStudents <= 100) {
      matches = true;
    }
    if (filters.contains('전체정원 200명 정도(100<x<200)') && totalStudents > 100 && totalStudents < 200) {
      matches = true;
    }
    if (filters.contains('전체정원 200명 이상\n(200<=x)') && totalStudents >= 200) {
      matches = true;
    }

    return matches;
  }).toList();
}

// 반 학생 수에 따른 필터링 함수
List<Institution> filterInstitutionsByClassStudents(List<Institution> institutions, List<String> filters) {
  return institutions.where((institution) {
    bool matches = false;
    int classStudent = institution.classStudent;

    if (filters.contains('10명 이하\n(x<=10)') && classStudent <= 10) {
      matches = true;
    }
    if (filters.contains('10명 이상\n(10<x)') && classStudent > 10) {
      matches = true;
    }

    return matches;
  }).toList();
}

// 액티비티 제공 여부에 따른 필터링 함수
List<Institution> filterInstitutionsByActivity(
  List<Institution> institutions,
  List<String>? noActivity,
  List<String>? anyActivity,
  List<String>? requireActivity,
) {
  return institutions.where((institution) {
    if (noActivity != null && noActivity.contains('원하지 않는다.\n(액티비티 미제공)') && institution.activity == false) {
      return true;
    }
    if (anyActivity != null && anyActivity.contains('상관 없다.\n(액티비티 제공, 미제공 모두 포함)')) {
      return true;
    }
    if (requireActivity != null && requireActivity.contains('원한다. \n(액티비티 제공)') && institution.activity == true) {
      return true;
    }
    return false;
  }).toList();
}

// 종합 필터링 함수
List<Institution> filterInstitutionsAll(
  List<Institution> institutions,
  List<String> programFilters,
  List<String> nationalityFilters,
  List<String> activityFilters,
  List<String> yearFilters,
  List<String> totalStudentFilters,
  List<String> classStudentFilters, // 추가
) {
  List<Institution> filteredInstitutions = filterInstitutions(institutions, programFilters);
  filteredInstitutions = filterInstitutionsByNationality(filteredInstitutions, nationalityFilters);
  filteredInstitutions = filterInstitutionsByActivity(filteredInstitutions, activityFilters, activityFilters, activityFilters);
  filteredInstitutions = filterInstitutionsByYear(filteredInstitutions, yearFilters);
  filteredInstitutions = filterInstitutionsByTotalStudents(filteredInstitutions, totalStudentFilters);
  return filterInstitutionsByClassStudents(filteredInstitutions, classStudentFilters); // 추가
}

// 직렬화 및 역직렬화 함수 추가
String serializeInstitutions(List<Institution> institutions) {
  return jsonEncode(institutions.map((e) => e.toJson()).toList());
}

List<Institution> deserializeInstitutions(String jsonString) {
  List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((e) => Institution.fromJson(e)).toList();
}
