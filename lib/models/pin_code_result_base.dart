import 'pin_code_result.dart';

class PinCodeResultBase {
  // final Reply3 base;
  final bool success;
  final List<String> message;
  final PinCodeResult result;
  PinCodeResultBase(this.success,this.message, this.result);
  factory PinCodeResultBase.fromMap(Map<String, dynamic> json) {
    return PinCodeResultBase(
       json['success'] ?? false,
       (json['message'] == null ? <String>[] :
        List<String>.from(json['message'] is List ? <String>[] : <String>[])) ,
       // List<String>.from(json['message'] ?? '') ?? [],
        json['lookupresponse'] == null || !json.keys.contains('lookupresponse')
            ? PinCodeResult.emptyResult
            : PinCodeResult.fromMap(json['lookupresponse']));
  }
}
