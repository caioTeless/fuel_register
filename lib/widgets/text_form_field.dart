import 'package:control_c/helpers/validator.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Function(String?) onSaved;
  final Icon prefixIcon;

  const TextInputField({
    required this.label,
    this.initialValue,
    required this.onSaved,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: TextFormField(
        validator: Validator.inputValidator,
        initialValue: initialValue,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: prefixIcon,
        ),
        keyboardType: TextInputType.number,
        onSaved: onSaved,
      ),
    );
  }
}
