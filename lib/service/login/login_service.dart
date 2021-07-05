import 'package:beamin_clone/service/base_service.dart';
import 'package:beamin_clone/service/login/login_models.dart';
import 'package:beamin_clone/utils/network_utils.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'login_service.g.dart';

@RestApi(baseUrl: 'https://$DEV_HOST2/v1')
abstract class LoginService extends BaseService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST('/login')
  @Headers(<String, dynamic>{})
  Future<PostLoginInfoModel> postLoginInfos(
      @Body() Map<String, dynamic> body,
      // @Body() PostLoginInfoBody,
  );
}
