class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double humidity;
  final double feels_like;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.feels_like,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toDouble(),
      feels_like: json['main']['feels_like'].toDouble(),
    );
  }
}
