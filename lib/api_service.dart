import 'package:dio/dio.dart';

final client = Dio();

Future<String> getData() async {
  const url = 'https://script.drutosoft.com/sms/api/number';

  try {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      print(response.data);
      return (response.data['data']);
    } else {
      print('${response.statusCode} : ${response.data.toString()}');
      throw "error";
    }
  } catch (error) {
    print(error);
    throw "error";
  }
}
