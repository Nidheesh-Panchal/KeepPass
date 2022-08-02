import 'package:encrypt/encrypt.dart';

class Encrypt {
  static Encrypted? encrypted;
  static String? decrypted;

  static String encryptAES(String plainText, String pass) {
    // final Key key = Key.fromUtf8('my 32 length key................');
    final Key key = Key.fromUtf8(pass);
    final IV iv = IV.fromLength(16);
    final Encrypter encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted!.base64;
  }

  static String decryptAES(String plainText, String pass) {
    // final Key key = Key.fromUtf8('my 32 length key................');
    final Key key = Key.fromUtf8(pass);
    final IV iv = IV.fromLength(16);
    final Encrypter encrypter = Encrypter(AES(key));
    Encrypted preprocess = Encrypted.from64(plainText);
    decrypted = encrypter.decrypt(preprocess, iv: iv);
    return decrypted!;
  }
}
