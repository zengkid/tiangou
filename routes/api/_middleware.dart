import 'package:dart_frog/dart_frog.dart';
import 'package:tiangou/auth/authenticator.dart';
import 'package:tiangou/auth/bearer_auth.dart';
import 'package:tiangou/auth/repository.dart';
import 'package:tiangou/auth/user.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<User>(
      retrieveUser: (RequestContext context, String token) {
        final authenticator = context.read<Authenticator>();
        return authenticator.verifyToken(token);
      },
    ),
  );
  // return handler;
}
