
class Job {
  final String profession;
  final String salary;
  final String conditions;
  final String relocation;
  final String gender;
  final int age;
  final List<String> education;
  final String experience;
  final String city;
  final List<String> workExperience;
  final String skills;
  final String urls;
  bool isFavorite; // New field to track if job is favorite

  Job({
    required this.profession,
    required this.salary,
    required this.conditions,
    required this.relocation,
    required this.gender,
    required this.age,
    required this.education,
    required this.experience,
    required this.city,
    required this.workExperience,
    required this.skills,
    required this.urls,
    this.isFavorite = false, // Default is not favorite
  });



  // Convert a JSON map to a Job object
  factory Job.fromJson(Map<String, dynamic> json) {
  return Job(
    profession: json['Профессия'] ?? '',
    salary: json['Зарплата'] ?? '',
    conditions: json['Условия'] ?? '',
    relocation: json['Переезд'] ?? '',
    gender: json['Пол'] ?? '',
    age: int.tryParse(json['Возраст'].toString().trim()) ?? 0,
    // Handle education: if it's a List, keep it; if it's a String, wrap it in a List.
    education: (json['Образование'] is List)
        ? List<String>.from(json['Образование'])
        : (json['Образование'] is String)
            ? [json['Образование']]
            : [],
    experience: json['Опыт работы'] ?? '',
    city: json['Город'] ?? '',
    // Handle workExperience: if it's a List, keep it; if it's a String, wrap it in a List.
    workExperience: (json['Трудовая деятельность'] is List)
        ? List<String>.from(json['Трудовая деятельность'])
        : (json['Трудовая деятельность'] is String)
            ? [json['Трудовая деятельность']]
            : [],
    skills: json['Навыки'] ?? '',
    urls: json['urls'] ?? '', // Treat urls as a single string
  );
}


  // Convert a Job object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Профессия': profession,
      'Зарплата': salary,
      'Условия': conditions,
      'Переезд': relocation,
      'Пол': gender,
      'Возраст': age,
      'Образование': education,
      'Опыт работы': experience,
      'Город': city,
      'Трудовая деятельность': workExperience,
      'Навыки': skills,
      'urls': urls, // Keep urls as a string
    };
  }
}
