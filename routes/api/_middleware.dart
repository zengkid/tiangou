import 'package:dart_frog/dart_frog.dart';
import 'package:myapp/auth/authenticator.dart';
import 'package:myapp/auth/bearer_auth.dart';
import 'package:myapp/auth/user.dart';

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
