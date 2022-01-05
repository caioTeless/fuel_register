class AppModel {
  int? id;
  String date;
  double? liters;
  double? value;

  AppModel({
    this.id,
    required this.date,
    required this.liters,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    final data = {
      'date': date,
      'liters': liters,
      'value': value,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  factory AppModel.fromMap(Map<String, dynamic> map) {
    return AppModel(
      id: map['id'],
      date: map['date'],
      liters: map['liters'],
      value: map['value'],
    );
  }
}
