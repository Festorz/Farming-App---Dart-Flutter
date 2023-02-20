import 'package:dio/dio.dart';
import 'package:mkulima/model/marketdata.dart';
import 'package:mkulima/model/products.dart';
import 'package:mkulima/model/recordData.dart';
import 'package:mkulima/model/unverifiedMarket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider {
  var path = 'https://mkulima-app.herokuapp.com/product';
  var recordsPath = 'https://mkulima-app.herokuapp.com/record';
  final Dio _dio = Dio();
  late SharedPreferences prefs;

  List<ProductsModel> product = [];
  List<MarketModel> market = [];
  List<RecordModel> record = [];
  List<UnverifiedMarket> unverifiedProducts = [];

  Future addProduct(Map<String, dynamic> data) async {
    try {
      var formdata = FormData.fromMap(data);
      await _dio.post('$path/add/', data: formdata);
    } on DioError catch (e) {}
  }

  Future<List<ProductsModel>> getFarmProducts(username) async {
    try {
      prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? '';
      Response response =
          await _dio.post('$path/getProducts/', data: {"username": username});
      for (var element in response.data) {
        product.add(ProductsModel.fromJson(element));
      }
      return product;
    } on DioError catch (e) {
      return product;
    }
  }

  Future setMarket(Map<String, dynamic>? data) async {
    try {
      await _dio.post('$path/setmarket/', data: data);
    } on DioError catch (e) {}
  }

  Future setPremium(Map<String, dynamic>? data) async {
    try {
      await _dio.post('$path/setpremium/', data: data);
    } on DioError catch (e) {}
  }

  Future<List<MarketModel>> getMarketProducts() async {
    try {
      prefs = await SharedPreferences.getInstance();
      String country = prefs.getString('country') ?? '';

      Response response =
          await _dio.post('$path/getMarket/', data: {'country': country});
      for (var element in response.data) {
        market.add(MarketModel.fromJson(element));
      }
      return market;
    } on DioError catch (e) {
      return market;
    }
  }

  Future addRecords(Map<String, dynamic>? data) async {
    try {
      await _dio.post('$recordsPath/add/', data: data);
    } on DioError catch (e) {}
  }

  Future<List<RecordModel>> getRecords() async {
    try {
      prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? '';
      Response response = await _dio
          .post('$recordsPath/getRecords/', data: {"username": username});
      for (var element in response.data) {
        record.add(RecordModel.fromJson(element));
      }
      return record;
    } on DioError catch (e) {
      return record;
    }
  }

  Future deleteRecord(Map<String, dynamic>? data) async {
    try {
      await _dio.post('$recordsPath/deleteRecord/', data: data);
    } on DioError catch (e) {}
  }

  Future<List<UnverifiedMarket>> getAllMarket() async {
    try {
      Response response = await _dio.get('$path/unverifiedMarket/');
      for (var element in response.data) {
        unverifiedProducts.add(UnverifiedMarket.fromJson(element));
      }
      return unverifiedProducts;
    } on DioError catch (e) {
      return unverifiedProducts;
    }
  }

  Future setVerified(Map<String, dynamic>? data) async {
    try {
      await _dio.post('$path/setVerified/', data: data);
    } on DioError catch (e) {}
  }
}
