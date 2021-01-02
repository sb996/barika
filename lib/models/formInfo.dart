
class formInfo {
  String question;
  String answer;


  formInfo.fromJson(Map<String , dynamic> parsedJson) {
    question = parsedJson['question'];
    answer = parsedJson['answer']??'';


  }



  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'question' : question??"",
      'answer' : answer??'',

    };

  }

}