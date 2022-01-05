import 'package:control_c/controller/app_model_controller.dart';
import 'package:control_c/data/db_helper.dart';
import 'package:control_c/helpers/app_bar.dart';
import 'package:control_c/helpers/const.dart';
import 'package:control_c/helpers/snack_bar.dart';
import 'package:control_c/model/app_model.dart';
import 'package:control_c/widgets/text_form_field.dart';
import 'package:control_c/widgets/text_form_input_date.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterData extends StatefulWidget {
  final AppModel? appModel;

  const RegisterData({
    Key? key,
    this.appModel,
  });

  @override
  _RegisterDataState createState() => _RegisterDataState();
}

class _RegisterDataState extends State<RegisterData> {
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _controller = AppModelController(DbHelper());
  final _buttonController = RoundedLoadingButtonController();

  @override
  void initState() {
    _controller.setId(widget.appModel?.id);
    if (widget.appModel?.date != null) {
      _dateController.text = widget.appModel!.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThisAppBar.appBar(register),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormInputDate(
                  dateController: _dateController,
                  controller: _controller,
                ),
                TextInputField(
                  label: literInput,
                  initialValue: widget.appModel?.liters.toString(),
                  onSaved: (value) =>
                      _controller.liters = value!.replaceAll(',', '.'),
                  prefixIcon: const Icon(Icons.local_gas_station_outlined),
                ),
                TextInputField(
                  label: money,
                  initialValue: widget.appModel?.value.toString(),
                  onSaved: (value) =>
                      _controller.value = value!.replaceAll(',', '.'),
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedLoadingButton(
                  color: const Color(0xFF1ABC9C),
                  controller: _buttonController,
                  onPressed: _onSave,
                  animateOnTap: true,
                  child: const Text(
                    registerButton,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  successColor: const Color(0xFF1ABC9C),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _onSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _controller.save();
      _buttonController.success();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBarApp.snackBar(text: 'Sucesso'));
    } else {
      _buttonController.stop();
    }
  }
}
