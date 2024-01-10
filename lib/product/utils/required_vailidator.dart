import 'package:form_field_validator/form_field_validator.dart';

class RequiredCostValidator extends TextFieldValidator {
  RequiredCostValidator({required String errorText}) : super(errorText);
  String errorValue='';
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if(value!.isNotEmpty&&int.parse(value!)<=100000){
      return true;
    }
    else {
      errorValue= value!.isEmpty?errorText:"Cost should be less than or equal to 100,000";
      return false;
    }
  }

  @override
  String? call(String? value) {
    return isValid(value) ? null :errorValue;
  }
}