// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiServices.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$apiServices extends apiServices {
  _$apiServices([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = apiServices;

  @override
  Future<Response<dynamic>> registerApi(Map<String, dynamic> body) {
    final $url = 'https://api2.barikaapp.com/api/register';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> login(Map<String, dynamic> body) {
    final $url = 'https://api2.barikaapp.com/api/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getToken(Map<String, dynamic> body) {
    final $url = 'https://api2.barikaapp.com/api/activate';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getToken2(
      [String phone, String code, String country]) {
    final $url = 'https://api2.barikaapp.com/api/activate';
    final $params = <String, dynamic>{
      'phone': phone,
      'code': code,
      'country': country
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getExercise(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/categories2';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSubExercises(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/exercises';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFAQ([String auth]) {
    final $url = 'https://api2.barikaapp.com/api/FAQ';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSubExercisesSinglePage(
      [String id, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/exercises/$id';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSupplement(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/categories2';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSubSupplements(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/supplements';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSupplementSinglePage([String id, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/supplements/$id';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAlbums(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/categories2';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSubAlbum(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/albums';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAlbumSinglePage([String id, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/albums/$id';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRecipes(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/categories2';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSubRecipes(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/recipes';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRecipesSinglePage([String id, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/recipes/$id';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStart(
      [String date, String first, String pid, String type, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/start';
    final $params = <String, dynamic>{
      'date': date,
      'first': first,
      'pid': pid,
      'app_type': type
    };
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStart2([String date, String type, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/start';
    final $params = <String, dynamic>{'date': date, 'first': type};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStart3([String date, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/start2';
    final $params = <String, dynamic>{'date': date};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserInfo(String auth) {
    final $url = 'https://api2.barikaapp.com/api/user';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateUserInfo(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/user/update';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateChildInfo(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/user/children/update';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addUser([Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/user/create';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserInfoDiet2([String used, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/user/diets2';
    final $params = <String, dynamic>{'used': used};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getChildrenDiet(
      [String id, String type, String type2, int logId, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/diets/children/$id';
    final $params = <String, dynamic>{
      'type': type,
      'type2': type2,
      'logId': logId
    };
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTokenActvation([String auth]) {
    final $url = 'https://api2.barikaapp.com/api/login/token';
    final $headers = {'Authorization': auth, 'Accept': 'application/json'};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPayHistory([String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/history';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> Paydiscount(
      [String type, String type2, String type3, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/discount2';
    final $params = <String, dynamic>{
      'code': type,
      'amount': type2,
      'type': type3
    };
    final $headers = {'Authorization': auth};
    final $request = Request('POST', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDietPrice([String type, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/diets/price/$type';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDietFind([String type, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/diets/find';
    final $params = <String, dynamic>{'dietId': type};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStoreInfo(String auth) {
    final $url = 'https://api2.barikaapp.com/api/store';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStoreInfo2(String auth) {
    final $url = 'https://api2.barikaapp.com/api/store2';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> creatPay(
      [String type,
      String amount,
      String discount,
      String disAmount,
      String userid,
      String account_id,
      String diettype,
      String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/$type/create';
    final $params = <String, dynamic>{
      'amount': amount,
      'discount': discount,
      'disAmount': disAmount,
      'user_id': userid,
      'account_id': account_id,
      'diet_type': diettype
    };
    final $headers = {'Authorization': auth};
    final $request = Request('POST', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> freeDiet(
      [String userid, String diettype, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/request/diet/free';
    final $params = <String, dynamic>{'user_id': userid, 'diet_type': diettype};
    final $headers = {'Authorization': auth};
    final $request = Request('POST', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> freeAcount(
      [String userid, String accountid, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/request/account/free';
    final $params = <String, dynamic>{
      'user_id': userid,
      'account_id': accountid
    };
    final $headers = {'Authorization': auth};
    final $request = Request('POST', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> bazaarPayment(
      [Map<String, dynamic> body, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/bazaar';
    final $headers = {'Authorization': auth};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> contactUs(String auth) {
    final $url = 'https://api2.barikaapp.com/api/contact-us';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> nutrients(String auth) {
    final $url = 'https://api2.barikaapp.com/api/nutrients';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> paymentDiscount(
      [String code, String amount, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/discount2';
    final $params = <String, dynamic>{'code': code, 'amount': amount};
    final $headers = {'Authorization': auth};
    final $request = Request('POST', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> loginCode([String phone, String country]) {
    final $url = 'https://api2.barikaapp.com/api/login';
    final $params = <String, dynamic>{'phone': phone, 'country': country};
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerCode(
      [String name,
      String phone,
      String presenter_referral,
      String lang,
      String country]) {
    final $url = 'https://api2.barikaapp.com/api/register';
    final $params = <String, dynamic>{
      'name': name,
      'phone': phone,
      'presenter_referral': presenter_referral,
      'lang': lang,
      'country': country
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFactor([String diettype, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/v3/payment/factor';
    final $params = <String, dynamic>{'diet_type': diettype};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> euroPay(
      [String order_id,
      String fname,
      String lname,
      String email,
      String mobile,
      String address,
      String postalCode,
      String country,
      String city,
      String auth]) {
    final $url = 'https://api2.barikaapp.com/api/payment/euro/request';
    final $params = <String, dynamic>{
      'order_id': order_id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'mobile': mobile,
      'address': address,
      'postalCode': postalCode,
      'country': country,
      'city': city
    };
    final $headers = {'Authorization': auth};
    final $request = Request('POST', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFruits([String date, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/v3/fruits';
    final $params = <String, dynamic>{'date': date};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCereals([String date, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/v3/cereals';
    final $params = <String, dynamic>{'date': date};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getExpiredDiet([String auth]) {
    final $url = 'https://api2.barikaapp.com/api/v3/user/diets/finished';
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserInfoDiet([String used, String auth]) {
    final $url = 'https://api2.barikaapp.com/api/v3/user/diets';
    final $params = <String, dynamic>{'used': used};
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDietChild(
      [String id,
      String user_name,
      String user_height,
      String user_weight,
      String user_birthdate,
      String user_sex,
      String user_appetite,
      String user_activity,
      String dietId,
      String selfId,
      String type,
      String type2,
      String auth]) {
    final $url = 'https://api2.barikaapp.com/api//v3/diets/children2/$id';
    final $params = <String, dynamic>{
      'user_name': user_name,
      'user_height': user_height,
      'user_weight': user_weight,
      'user_birthdate': user_birthdate,
      'user_sex': user_sex,
      'user_appetite': user_appetite,
      'user_activity': user_activity,
      'dietId': dietId,
      'selfId': selfId,
      'type': type,
      'type2': type2
    };
    final $headers = {'Authorization': auth};
    final $request = Request('GET', $url, client.baseUrl,
        parameters: $params, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
