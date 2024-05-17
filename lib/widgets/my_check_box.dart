import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Key? key,
      Widget? title,
      FormFieldSetter<bool>? onSaved,
      FormFieldValidator<bool>? validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                  title: title,
                  value: state.value,
                  dense: state.hasError,
                  onChanged: state.didChange,
                  subtitle: state.hasError
                      ? Builder(
                          builder: (BuildContext context) => Text(
                            state.errorText ?? '',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                        )
                      : null,
                  controlAffinity: ListTileControlAffinity.leading);
            });
}
