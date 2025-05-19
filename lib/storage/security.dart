import 'package:cryptography/cryptography.dart';
import 'package:convert/convert.dart' as convert;

const int _iterations = 10000;
const int _keyLength = 512;

class Security {
  Security({
    required this.salt,
    required this.iterations,
    required this.keyLength,
  });

  final String salt;
  final int iterations;
  final int keyLength;

  static Future<String> generateId({
    required String password,
    required String salt,
  }) async {
    final key = await Pbkdf2(
      macAlgorithm: Hmac.sha512(),
      iterations: _iterations,
      bits: _keyLength,
    ).deriveKeyFromPassword(password: password, nonce: salt.codeUnits);
    return convert.hex.encode(await key.extractBytes());
  }
}
