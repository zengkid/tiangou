import 'package:dart_frog/dart_frog.dart';
import 'package:tiangou/auth/authenticator.dart';
import 'package:tiangou/auth/repository.dart';

Handler middleware(Handler handler) {
  return handler
      .use(provider<Authenticator>(
          (context) => Authenticator(context.read<UserRepository>())))
      .use(provider<UserRepository>((context) => UserRepository()));
}
