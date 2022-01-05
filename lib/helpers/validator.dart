class Validator{

  static String? inputValidator(String? value){
    if(value!.isEmpty) return 'Insira alguma informação';
    if(value.length == 1) return 'Informação inválida';
    if(value.length > 6) return 'Valores excedentes';
  }

}