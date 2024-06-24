import 'package:http/http.dart' as http;

Future<void> main() async {
  var numbers = <int>[];
  for (var i = 0; i < 100; i++) {
    numbers.add(i);
  }

  // var uri =  Uri.encodeFull('http://localhost:8080/');
  var url = Uri.http('localhost:8080', '/');


  // http.post(url)

  var list = await Future.wait(numbers.map((i) => http.get(url)));

  for (var res in list) {
    print(res.body);
  }
}
