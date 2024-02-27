import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  ///If we had multiple env files, we could do something like this:
  ///static String get fileName => '.env.${Platform.environment['ENV']}';
  ///This would allow us to have a [.env.development], [.env.staging], and [.env.production]
  static String get fileName => '.env';
  static String get baseUrl => dotenv.env['BASE_URL']!;
}
