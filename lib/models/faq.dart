
class faq {
  String id;
  String question;
  String answer;


  faq.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    question = parsedJson['question'] ??'';
    answer = parsedJson['answer']??'';


  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id':id,
      'question' : question,
      'answer' : answer,


    };

  }}