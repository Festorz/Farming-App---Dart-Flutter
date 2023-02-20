import 'package:dio/dio.dart';
import 'package:mkulima/misc/colors.dart';
import 'package:mkulima/widgets/snackbar.dart';

class SubscriptionsProvider {
  var path = 'https://mkulima-app.herokuapp.com/payments';
  final Dio _dio = Dio();

  Future subscribeMpesa(Map<String, dynamic> data, context) async {
    try {
      Response response = await _dio.post('$path/mpesa', data: data);
    } on DioError catch (e) {
      Appsnackbar.snackbar(
          context, e.response!.data.toString(), AppColors.pink);
    }
  }
}
