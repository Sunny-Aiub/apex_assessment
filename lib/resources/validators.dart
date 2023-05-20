class MyCustomValidator {
  static String? validateIsEmpty(value) {
    if (value.isEmpty == true) {
      return ' this field is required';
    }

    return null;
  }

  static String? phoneNumberValidation(value,) {
    if (value.length < 8)  {
      return 'The phone must be between 9 and 15 digits.';
    }else if(value.length >16){
      return 'The phone must be between 9 and 15 digits.';
    }
    return null;
  }

}
