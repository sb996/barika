class notices {
  int id;
  String message;
  String created_at;
  String updated_at;

  notices.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    message = parsedJson['message'] ??'';
    created_at = parsedJson['created_at']??'';
    updated_at = parsedJson['updated_at']??'';
  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id':id,
      'message' : message,
      'created_at' : created_at,
      'updated_at'  : updated_at,

    };

  }}