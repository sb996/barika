class Peyment {
  int id;
  String title;
  String code;
  String amount;
  String created_at;
  String status;
  String payment_type;

  Peyment.fromJson(Map<String , dynamic> parsedJson) {

    title = parsedJson['title']??"0";
    code = parsedJson['code']??"";
    amount = parsedJson['amount']??"";
    created_at = parsedJson['created_at']??"";
    status = parsedJson['status']??"";
    payment_type = parsedJson['payment_type']??"";

  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id' : id,
      'title' : title,
      'code' : code??"0",
      'amount' : amount??"",
      'created_at' : created_at??"",
      'status' : status??"",
      'payment_type' : payment_type??"",



  };}}