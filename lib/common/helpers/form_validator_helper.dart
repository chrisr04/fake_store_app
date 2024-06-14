import 'package:fake_store_app/common/values/values.dart';

class FormValidatorHelper {
  static const _emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String? isRequired(String? value) {
    if (value != null && value.isNotEmpty) return null;
    return StringValue.thisFieldIsRequired;
  }

  static String? isRequiredInteger(String? value) {
    if (value != null && int.tryParse(value) != null) return null;
    return StringValue.thisFieldMustContainIntegerNumbers;
  }

  static String? isRequiredEmail(String? value) {
    RegExp regExp = RegExp(_emailRegex);
    if (value != null && regExp.hasMatch(value)) return null;
    return StringValue.thisFieldMustContainValidEmail;
  }
}
