import 'package:beamin_clone/utils/logger_utils.dart';
import 'package:beamin_clone/utils/network_utils.dart';
import 'package:dio/dio.dart';

class RootService {
  static Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: onRequestWrapper,
        onResponse: onResponseWrapper,
        onError: onErrorWrapper,
      ),
    );

  static parseBody(dynamic data) {
    try {
      if (data is List) {
        final dynamicList = [];
        for (int i = 0; i < data.length; i++) {
          dynamicList.add(parseBody(data[i]));
        }
        return dynamicList;
      }

      if (data is Map) {
        for (var key in data.keys) {
          data[key] = parseBody(data[key]);
        }
      }

      if (data is int) return data;
      if (data is double) return data;
      return data;
    } catch (e) {
      customLogger.e(
        '이 에러가 난다면 해결 또는 헬프요청. 실행에는 영향 없음.'
            '\n$e',
      );
    }
  }

  static onErrorWrapper(
      DioError error,
      ErrorInterceptorHandler handler,
      ) async {
    if (LOG_HTTP_REQUESTS) {
      customLogger.d(
        '!!!!!!!!!!ERROR THROWN WITH FOLLOWING LOG!!!!!!!!!!\n'
            'path: ${error.requestOptions.baseUrl}${error.requestOptions.path}\n'
            'status code: ${error.response?.statusCode ?? ''}\n'
            'body: ${error.response?.data.toString() ?? ''}\n'
            'headers: ${error.response?.headers ?? ''}',
      );
    }

    // TODO production 가기전에 무조건 고처야함 RETRY 횟수를 지정하기!

    return handler.next(error);
  }

  static onResponseWrapper(
      Response resp,
      ResponseInterceptorHandler handler,
      ) async {
    if (LOG_HTTP_REQUESTS) {
      customLogger.d(
        '!!!!!!!!!!RESPONSE RECEIVED WITH FOLLOWING LOG!!!!!!!!!!\n'
            'path: ${resp.requestOptions.baseUrl}${resp.requestOptions.path}\n'
            'body: ${resp.data}\n'
            'headers: ${resp.headers}',
      );
    }

    return handler.next(resp);
  }

  static onRequestWrapper(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    if (options.headers.containsKey('content-type')) {
      final ct = options.headers['content-type'];

      options.contentType = ct;
    }

    if (LOG_HTTP_REQUESTS) {
      customLogger.d('!!!!!!!!!!REQUEST SENT WITH FOLLOWING LOG!!!!!!!!!!\n'
          'path: ${options.baseUrl}${options.path}\n'
          'body: ${parseBody(options.data)}\n'
          'headers: ${options.headers}');
    }

    return handler.next(options);
  }
}
