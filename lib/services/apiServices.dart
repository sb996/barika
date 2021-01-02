// flutter packages pub run build_runner watch
import 'package:chopper/chopper.dart';
// import 'package:http/io_client.dart' as http;
// import 'dart:io';
part 'apiServices.chopper.dart';
// https://cors-anywhere.herokuapp.com/
@ChopperApi(baseUrl: 'https://api2.barikaapp.com/api/')
// @ChopperApi(baseUrl: 'https://cors-anywhere.herokuapp.com/https://api.barikaapp.com/api/')
abstract class apiServices extends ChopperService {
  // Put & Patch requests are specified the same way - they must contain the @Body

  //register
  @Post(path: 'register')
  Future<Response> registerApi(
      @Body() Map<String, dynamic> body,
      );

  //login
  @Post(path: 'login')
  Future<Response> login(
      @Body() Map<String, dynamic> body,
      );

  //activation
  @Post(path: 'activate')
  Future<Response> getToken(
      @Body() Map<String, dynamic> body,
      );

  @Post(path: 'activate')
  Future<Response> getToken2 (
      [
        @Query("phone")String phone,
        @Query("code")String code,
        @Query("country")String country,]);


  //all exercise {type:exercise}
  @Post(path: 'categories2')
  Future<Response> getExercise(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//sub exercise{category: }
  @Post(path: 'exercises')
  Future<Response> getSubExercises(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//FAQ
  @Get(path: 'FAQ')
  Future<Response> getFAQ(
      [@Header('Authorization') String auth]);



//sub exercise SinglePage
  @Get(path: 'exercises/{id}')
  Future<Response> getSubExercisesSinglePage(
      [@Path('id') String id,
        @Header('Authorization') String auth]);


  //all supplement {type:supplement}
  @Post(path: 'categories2')
  Future<Response> getSupplement(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//sub supplement{category: }
  @Post(path: 'supplements')
  Future<Response> getSubSupplements(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//sub supplements SinglePage
  @Get(path: 'supplements/{id}')
  Future<Response> getSupplementSinglePage(
      [@Path('id') String id,
        @Header('Authorization') String auth]);

//all albums {type:albums}
  @Post(path: 'categories2')
  Future<Response> getAlbums(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//sub albums{category: }
  @Post(path: 'albums')
  Future<Response> getSubAlbum(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//sub Single albums SinglePage
  @Get(path: 'albums/{id}')
  Future<Response> getAlbumSinglePage(
      [@Path('id') String id,
        @Header('Authorization') String auth]);


  //all recipes {type:recipes}
  @Post(path: 'categories2')
  Future<Response> getRecipes(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//sub albums{category: }
  @Post(path: 'recipes')
  Future<Response> getSubRecipes(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

//sub Single albums SinglePage
  @Get(path: 'recipes/{id}')
  Future<Response> getRecipesSinglePage(
      [@Path('id') String id,
        @Header('Authorization') String auth]);

  @Get(path: 'start')
  Future<Response> getStart ([
    @Query("date")String date ,
    @Query("first")String first ,
    @Query("pid")String pid ,
    @Query("app_type")String type ,
    @Header('Authorization') String auth]);

  @Get(path: 'start')
  Future<Response> getStart2 ([
    @Query("date")String date ,
    @Query("first")String type ,
    @Header('Authorization') String auth]);

  @Get(path: 'start2')
  Future<Response> getStart3 ([
    @Query("date")String date ,
    @Header('Authorization') String auth]);

  @Get(path: 'user')
  Future<Response> getUserInfo(@Header('Authorization') String auth);

  @Post(path: 'user/update')
  Future<Response> updateUserInfo(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

  @Post(path: 'user/children/update')
  Future<Response> updateChildInfo(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

  @Post(path: 'user/create')
  Future<Response> addUser(
      [@Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);


  @Get(path: 'user/diets2')
  Future<Response> getUserInfoDiet2(
      [@Query("used")String used,
        @Header('Authorization') String auth]);

  @Get(path: 'diets/children/{id}')
  Future<Response> getChildrenDiet(
      [@Path('id') String id,
        @Query("type")String type,
        @Query("type2")String type2,
        @Query("logId")int logId,
        @Header('Authorization') String auth]);

  @Get(path: 'login/token',headers: {"Accept":"application/json"})
  Future<Response> getTokenActvation(
      [ @Header('Authorization') String auth]);


  @Get(path: 'payment/history')
  Future<Response> getPayHistory(
      [ @Header('Authorization') String auth]);

  @Post(path: 'payment/discount2')
  Future<Response> Paydiscount(
      [
        @Query("code")String type,
        @Query("amount")String type2,
        @Query("type")String type3,
        @Header('Authorization') String auth]);

  @Get(path: 'diets/price/{type}')

  Future<Response> getDietPrice(
      [@Path('type') String type,
        @Header('Authorization') String auth]);

  @Get(path: 'diets/find')
  Future<Response> getDietFind(
      [@Query('dietId') String type,
        @Header('Authorization') String auth]);

  // @Get(path: 'diets/children2/{id}')
  // Future<Response> getDietChild(
  //     [@Path('id') String id,
  //       @Query("type")String type,
  //       @Query("type2")String type2,
  //       @Header('Authorization') String auth]);


  @Get(path: 'store')
  Future<Response> getStoreInfo(@Header('Authorization') String auth);

  @Get(path: 'store2')
  Future<Response> getStoreInfo2(@Header('Authorization') String auth);


  @Post(path: 'payment/{type}/create')
  Future<Response>creatPay(
      [@Path('type') String type,
        @Query("amount")String amount,
        @Query("discount")String discount,
        @Query("disAmount")String disAmount,
        @Query("user_id")String userid,
        @Query("account_id")String account_id,
        @Query("diet_type")String diettype,
        @Header('Authorization') String auth]);


  @Post(path: 'payment/request/diet/free')
  Future<Response> freeDiet(
      [
        @Query("user_id")String userid,
        @Query("diet_type")String diettype,
        @Header('Authorization') String auth]);

  @Post(path: 'payment/request/account/free')
  Future<Response> freeAcount(
      [@Query("user_id")String userid,
        @Query("account_id")String accountid,
        @Header('Authorization') String auth]);


  @Post(path: 'payment/bazaar')
  Future<Response> bazaarPayment(
      [
        @Body() Map<String, dynamic> body,
        @Header('Authorization') String auth]);

  @Get(path: 'contact-us')
  Future<Response> contactUs(@Header('Authorization') String auth);

  @Get(path: 'nutrients')
  Future<Response> nutrients(@Header('Authorization') String auth);



  @Post(path: 'payment/discount2')
  Future<Response> paymentDiscount (
      [@Query("code")String code,
        @Query("amount")String amount,
        @Header('Authorization') String auth]);


  // @Post(path: 'payment/{type}/create')
  // Future<Response> createFactor (
  //     [
  //       @Path('type') String type,
  //       @Query("discount")String discount,
  //       @Query("disAmount")String disAmount,
  //       @Header('Authorization') String auth]);
  //

  @Post(path: 'login')
  Future<Response> loginCode (
      [
        @Query("phone")String phone,
        @Query("country")String country,]);


  @Post(path: 'register')
  Future<Response> registerCode (
      [
        @Query("name")String name,
        @Query("phone")String phone,
        @Query("presenter_referral")String presenter_referral,
        @Query("lang")String lang,
        @Query("country")String country,]);

  // https://api.barikaapp.com/api/payment/factor?diet_type=vegetarian
 @Get(path: 'v3/payment/factor')
  Future<Response> getFactor(
      [@Query("diet_type")String diettype,
        @Header('Authorization') String auth]);

  @Post(path: 'payment/euro/request')
  Future<Response> euroPay(
      [
        @Query("order_id")String order_id,
        @Query("fname")String fname,
        @Query("lname")String lname,
        @Query("email")String email,
        @Query("mobile")String mobile,
        @Query("address")String address,
        @Query("postalCode")String postalCode,
        @Query("country")String country,
        @Query("city")String city,
        @Header('Authorization') String auth]);




  @Get(path: 'v3/fruits')
  Future<Response> getFruits(
      [@Query("date")String date,
        @Header('Authorization') String auth]);


  @Get(path: 'v3/cereals')
  Future<Response> getCereals(
      [@Query("date")String date,
        @Header('Authorization') String auth]);


  @Get(path: 'v3/user/diets/finished')
  Future<Response> getExpiredDiet(
      [  @Header('Authorization') String auth]);

  @Get(path: 'v3/user/diets')
  Future<Response> getUserInfoDiet(
      [@Query("used")String used,
        @Header('Authorization') String auth]);

  @Get(path: '/v3/diets/children2/{id}')
  Future<Response> getDietChild(
      [@Path('id') String id,
        @Query("user_name")String user_name,
        @Query("user_height")String user_height,
        @Query("user_weight")String user_weight,
        @Query("user_birthdate")String user_birthdate,
        @Query("user_sex")String user_sex,
        @Query("user_appetite")String user_appetite,
        @Query("user_activity")String user_activity,
        @Query("dietId")String dietId,
        @Query("selfId")String selfId,
        @Query("type")String type,
        @Query("type2")String type2,
        @Header('Authorization') String auth]);



//  @Post(path: 'categories2')
//  Future<Response> getExercise([
//    @Body() Map<String, dynamic> body,
//    @Header('Authorization') String auth
//  ]);

  static apiServices create() {
    final client = ChopperClient(
      // client: http.IOClient(
      //   HttpClient()..connectionTimeout = const Duration(seconds: 35),
      // ),
      // The first part of the URL is now here
      // baseUrl: 'https://cors-anywhere.herokuapp.com/https://api.barikaapp.com/api/',
      baseUrl: 'https://api2.barikaapp.com/api/',
      services: [
        // The generated implementation
        _$apiServices(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$apiServices(client);
  }
}
