import 'package:control_c/controller/app_model_controller.dart';
import 'package:control_c/helpers/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFormInputDate extends StatefulWidget {
  final AppModelController controller;
  final TextEditingController? dateController;

  const TextFormInputDate({
    required this.controller,
    this.dateController,
  });

  @override
  _TextFormInputDateState createState() => _TextFormInputDateState();
}

class _TextFormInputDateState extends State<TextFormInputDate> {
  Future _selectDate(BuildContext context) async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030),
        cancelText: 'Cancelar',
        confirmText: 'Selecionar',
        // locale: ,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.teal,
                primaryColorDark: Colors.teal,
                accentColor: Colors.teal,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        }).then((date) {
      if (date != null) {
        setState(() {
          widget.dateController!.text = DateFormat(dateFormat).format(date);
        });
      }
    });
  }

  @override
  void dispose() {
    widget.dateController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return 'Informe uma data';
      },
      controller: widget.dateController,
      decoration: const InputDecoration(
        label: Text(dateInput),
        prefixIcon: Icon(Icons.date_range),
        suffixIcon: Icon(Icons.arrow_drop_down),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
      onSaved: (value) => widget.controller.date = value!,
    );
  }
}
