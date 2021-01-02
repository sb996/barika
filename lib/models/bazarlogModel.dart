
class bazarlogModel {
  int id;
  String user_id;
  String type;
  String diet_type;
  String account_id;
  String details;
  String amount;
  String status;
  String server;


  bazarlogModel.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    user_id = parsedJson['user_id'] ??'';
    type = parsedJson['type']??'';
    diet_type = parsedJson['diet_type']??'';
    account_id = parsedJson['account_id']??'';
    details = parsedJson['details']??'';
    amount = parsedJson['amount']??'';
    status = parsedJson['status']??'';
    server = parsedJson['server']??'';


  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id':id,
      'user_id' : user_id,
      'type' : type,
      'diet_type' : diet_type,
      'account_id' : account_id,
      'details' : details,
      'amount' : amount,
      'status' : status,
      'server' : server,


    };

  }}