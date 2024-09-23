class Env {
  static const String baseUrl =
      'https://66f15a494153791915508bdf.mockapi.io/api/v1/';

  static Map<String, dynamic> get baseHeader => {
        'accept': 'application/json',
        'content-type': 'application/x-www-form-urlencoded',
      };
}
