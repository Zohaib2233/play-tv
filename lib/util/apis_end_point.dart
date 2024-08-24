class ApiEndPoints {
  // <BASE URL>

  static const String BASE_URL = 'https://admin.playtv4k.com/';

  //AUTH APIS
  static const String LOGIN_API = 'api/auth/user';
  static const String LOGOUT_API = 'api/auth/logout';
  static const String REGISTER_API = 'api/auth/register';
  static const String MANUAL_LOGIN_API = 'api/auth/login';






  //CHANNEL APIS

  static const String SEARCH_API = 'api/channel/search';
  static const String GET_ALL_CHANNEL_API = 'api/channel/get-info';
  static const String GET_FAV_CHANNEL_API = 'api/channel/get-favourite-channels';

  //COMMENT APIS
  static const String GET_ALL_COMMENT_API = 'api/channel/get-comments';
  static const String SUBMIT_COMMENT = 'api/channel/submit-comment';






}