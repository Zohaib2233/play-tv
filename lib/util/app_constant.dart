import 'package:play_tv/data/model/response/language_model.dart';

class AppConstants {
  static const APP_NAME = "TV APP 4K";
  static const String BASE_URL = 'https://dukkanapp.online';

  static const String THEME = 'theme';
  static const String PUBLIC_API_KEY = 'TVAPP_LIVE_AJKL341';



  // sharePreference
  static const String TOKEN = 'token';
  static const String LANG_KEY = 'lang';


  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';


  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}
