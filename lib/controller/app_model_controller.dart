import 'package:control_c/data/db_helper.dart';
import 'package:control_c/model/app_model.dart';
import 'package:intl/intl.dart';

class AppModelController {
  final DbHelper _dbHelper;

  AppModelController(this._dbHelper);

  List<AppModel> items = [];
  List<AppModel> newItems = [];

  int get length => items.length > 0 ? items.length : 0;

  int? id;
  String date = '';
  String liters = '';
  String value = '';
  bool loading = false;
  bool compareList = false;

  void setId(int? gId) => id = gId;
  void setDate(String? date) => date = date;
  void setLiters(String? liters) => liters = liters;
  void setValue(String? value) => value = value;

  Future save() async {
    final appModel = AppModel(
      id: id,
      date: date,
      liters: double.tryParse(liters),
      value: double.tryParse(value),
    );
    if (id == null) {
      _dbHelper.insert(appModel);
    } else {
      _dbHelper.update(appModel);
    }
  }

  Duration toDate(String date){
    DateFormat rightFormat = DateFormat('dd/MM/yyyy');
    DateTime rightDate = rightFormat.parse(date);
    return rightDate.difference(DateTime.now());
  }

  void compare() {
    if (compareList == true) {
      items.sort((a, b) => toDate(a.date).compareTo(toDate(b.date)));
    }
  }



  Future readAll() async {
    loading = true;
    items = await _dbHelper.readAll();
    compare();
    newItems = items;
    loading = false;
  }

  Future delete(AppModel appModel) async {
    loading = true;
    await _dbHelper.delete(appModel);
    loading = false;
  }

  Future undo(AppModel appModel) async{
    await _dbHelper.insert(appModel);
  }
}
