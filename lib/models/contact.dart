class contact {
  String telegram;
  String rubika;
  String instagram;
  String website;
  String description;


  contact.fromJson(Map<String , dynamic> parsedJson) {
    telegram = parsedJson['telegram'];
    rubika = parsedJson['rubika'] ??'';
    instagram = parsedJson['instagram']??'';
    website = parsedJson['website']??'';
    description = parsedJson['description']??'';

  }

  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'telegram':telegram,
      'rubika' : rubika,
      'instagram' : instagram,
      'website' : website,
      'description' : description,

    };

  }
}