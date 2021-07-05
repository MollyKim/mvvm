import 'package:beamin_clone/controllers/base_controller.dart';
import 'package:beamin_clone/service/login/login_models.dart';
import 'package:beamin_clone/service/root_service.dart';

class LoginController extends BaseController {
  LoginController({
    required RootService rootService,
  }) : super(rootService);

  Future<PostLoginInfoModel?> loginInfos(
      {required String userid,
      required String userpwd,
      required os_div}) async {
    final formData = {
      'userid': userid,
      'userpwd': userpwd,
      'os_div': os_div,
      'regcode': '5',
    };

    final resp = await super.services.loginService.postLoginInfos(formData);

    update();
    return resp;
  }
}
