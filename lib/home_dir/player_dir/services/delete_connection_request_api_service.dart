import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class DeleteConnectionRequestRequestApiService {
  static DeleteConnectionRequestRequestApiService? _instance;

  DeleteConnectionRequestRequestApiService._internal();

  static DeleteConnectionRequestRequestApiService getInstance() {
    _instance ??= DeleteConnectionRequestRequestApiService._internal();
    return _instance!;
  }

/* ==============================================Deny Request Api================================================*/

  Future? deleteConnectionRequest(context) async {
    try {
      var response = await http.post(
        Uri.parse(AppApiUtils.deleteConnectionRequestUrl),
        headers: {
          "auth_token": UserDetails.userAuthToken!,
          "request_id": "12345",
          "user_id": UserDetails.userID!,
          "to_id": "",
        },
      );
      if (response.statusCode == 200) {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strConnectionRequestCancelled);
      } else {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strSomethingWrong);
      }
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return e;
    }
  }
}
