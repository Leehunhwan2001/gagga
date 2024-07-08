class Institution {
  final String name;
  final String country;
  final String region;
  final int nationalityKR;
  final int establishedYear;
  final bool activity;
  final int totalStudent;
  final int classStudent;
  final Map<String, List<Course>> programs;

  Institution({
    required this.name,
    required this.country,
    required this.region,
    required this.nationalityKR,
    required this.establishedYear,
    required this.activity,
    required this.totalStudent,
    required this.classStudent,
    required this.programs,
  });

  factory Institution.fromJson(Map<String, dynamic> json) {
    Map<String, List<Course>> programs = {};
    (json['Programs'] as Map<String, dynamic>).forEach((key, value) {
      programs[key] = (value as List).map((e) => Course.fromJson(e as Map<String, dynamic>)).toList();
    });

    return Institution(
      name: json['Institution'] as String,
      country: json['Country'] as String,
      region: json['Region'] as String,
      nationalityKR: json['NationalityKR'] as int,
      establishedYear: json['EstablishedYear'] as int,
      activity: (json['Activity'] as String) == 'Y',
      totalStudent: json['TotalStudent'] as int,
      classStudent: json['ClassStudent'] as int,
      programs: programs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Institution': name,
      'Country': country,
      'Region': region,
      'NationalityKR': nationalityKR,
      'EstablishedYear': establishedYear,
      'Activity': activity ? 'Y' : 'N',
      'TotalStudent': totalStudent,
      'ClassStudent': classStudent,
      'Programs': programs.map((key, value) => MapEntry(key, value.map((e) => e.toJson()).toList())),
    };
  }
}

class Course {
  final String courseName;
  final String description;

  Course({required this.courseName, required this.description});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseName: json['CourseName'] as String,
      description: json['Description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CourseName': courseName,
      'Description': description,
    };
  }
}
