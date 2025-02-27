import 'package:flutter_rocket/flutter_rocket.dart';

class RocketClientTest extends RocketClient {
  List<Map<String, dynamic>> dummyData;
  RocketClientTest(
    this.dummyData,
  ) : super(url: '');
  @override
  Future<RocketModel> request<T>(String endpoint,
      {RocketModel<T>? model,
      HttpMethods method = HttpMethods.get,
      RocketDataCallback? inspect,
      List<String>? target,
      RocketOnError? onError,
      Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      RetryOptions retryOptions = const RetryOptions()}) async {
    model!.state = RocketState.loading;
    await Future.delayed(const Duration(seconds: 1));
    try {
      model.setMulti(dummyData);
    } catch (e) {
      model.setException(RocketException(exception: e.toString()));
    }

    return model;
  }
}
