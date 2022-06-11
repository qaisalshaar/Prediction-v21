// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserHealth {
  String? email;
  int? highbloodpressure;
  int? lowerbloodpressure;
  int? weight;
  int? height;
  int? cholesterol;
  String? medicine;
  String? diabetesinfamily; // yes / no
  String? date;
  int? glucoserate;
  double? skinfoldthickness; // null ok
  String? dietfood; // null ok
  String? medicineadvise; // null ok

  UserHealth({
    this.email,
    this.highbloodpressure,
    this.lowerbloodpressure,
    this.weight,
    this.height,
    this.cholesterol,
    this.medicine,
    this.diabetesinfamily,
    this.date,
    this.glucoserate,
    this.skinfoldthickness,
    this.dietfood,
    this.medicineadvise,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'highbloodpressure': highbloodpressure,
      'lowerbloodpressure': lowerbloodpressure,
      'weight': weight,
      'height': height,
      'cholesterol': cholesterol,
      'medicine': medicine,
      'diabetesinfamily': diabetesinfamily,
      'date': date,
      'glucoserate': glucoserate,
      'skinfoldthickness': skinfoldthickness,
      'dietfood': dietfood,
      'medicineadvise': medicineadvise,
    };
  }

  UserHealth.fromMap(dynamic obj) {
    email = obj['email'];
    highbloodpressure = obj['highbloodpressure'];
    lowerbloodpressure = obj['lowerbloodpressure'];

    weight = obj['weight'];
    height = obj['height'];
    cholesterol = obj['cholesterol'];
    medicine = obj['medicine'];
    diabetesinfamily = obj['diabetesinfamily'];
    date = obj['date'];
    glucoserate = obj['glucoserate'];
    skinfoldthickness = obj['skinfoldthickness'];
    dietfood = obj['dietfood'];
    medicineadvise = obj['medicineadvise'];
  }

  factory UserHealth.fromJson(String source) =>
      UserHealth.fromMap(json.decode(source) as Map<String, dynamic>);
}
