class WeatherDataModel {
  double? temperatureCurrent;
  double? temperatureMax;
  double? temperatureMin;
  String? temperatureUnit;
  String? condition;
  double? windSpeed;
  String? windSpeedUnit;
  String? windDirection;
  String? location;

  WeatherDataModel(
      {this.temperatureCurrent,
        this.temperatureMax,
        this.temperatureMin,
        this.temperatureUnit,
        this.condition,
        this.windSpeed,
        this.windSpeedUnit,
        this.windDirection,
        this.location});

  WeatherDataModel.fromJson(Map<String, dynamic> json) {
    temperatureCurrent = json['temperature_current'];
    temperatureMax = json['temperature_max'];
    temperatureMin = json['temperature_min'];
    temperatureUnit = json['temperature_unit'];
    condition = json['condition'];
    windSpeed = json['wind_speed'];
    windSpeedUnit = json['wind_speed_unit'];
    windDirection = json['wind_direction'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature_current'] = this.temperatureCurrent;
    data['temperature_max'] = this.temperatureMax;
    data['temperature_min'] = this.temperatureMin;
    data['temperature_unit'] = this.temperatureUnit;
    data['condition'] = this.condition;
    data['wind_speed'] = this.windSpeed;
    data['wind_speed_unit'] = this.windSpeedUnit;
    data['wind_direction'] = this.windDirection;
    data['location'] = this.location;
    return data;
  }
}
