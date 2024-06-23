import 'package:dart_frog/dart_frog.dart';
import 'package:tiangou/auth/authenticator.dart';


Handler middleware(Handler handler) {
  return handler.use(
    provider<Authenticator>(
          (_) => Authenticator(),
    ),
  );
}