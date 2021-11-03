import 'package:flavor_http/http.dart';

String base =
    'https://firebasestorage.googleapis.com/v1beta/projects/633139741304/buckets/dlxstudios-f6e64.appspot.com';

String bucket = 'dlxstudios-f6e64.appspot.com';
String get base1 => 'https://storage.googleapis.com/storage/v1/b/$bucket/o';
// String token =
//     'ya29.a0ARrdaM8t5g7SfuYqb-R_A1Y2-ycZBaviSHAd-05P0aViEdLWpXgTPLlTqnc1tdTsypRHOtIKJd-5dY5l4ZIk8rxMvO_AkUINyBw1pSweGpc1ZTxI4n3ODgtQm2Hq8j32vpLjv2KabInHoF5btZKLAf8RLVeAxq37MWGp9ICaXfP-H0rAEM1MfySnuXwN-o4qlrkcNwWo1_uOLxzvJxpWD2BqFAQQrzH5DPIN1eXz5Kk0A9srQM9hRS3sASTfj6adALWnfK4';
var headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer $token',
};

String base3 = 'http://localhost:8547/users/';

var token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MzUzOTY1OTAsImV4cCI6MTYzNTM5NjYyMCwic3ViIjoiNjE3OWYxNTg0MmI3ODg3OTIwOWIyNWQ1IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdCIsImp0aSI6ImRlZjI2OTY2LTUwYjYtNDM2Ny05ZWRjLWI0ODdkNThjNjgzNSJ9.O8OCVm1XsQAILLPX9uNCyBxqkZeK_mpRKvWLgVDyXfE';

class NetStore {
  FlavorHttp http = FlavorHttp();

  // NetStore() {}
  Future<Map<String, dynamic>> fetchData() async {
    return await http
        .fetch(
      base3,
      headers: headers,
      // params: {'key': 'AIzaSyCnYzzqZdHbbWol5JRUnW3SUt0rI8MzAr0'},
    )
        .then((value) {
      print('value::$value');
      return value;
    });
  }
}
