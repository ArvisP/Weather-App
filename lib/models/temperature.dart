class Temperature {
  String city;
  String country;
  int temp;
  int minTemp;
  int maxTemp;
  String description;

  Temperature({this.city, this.country, this.temp, this.minTemp, this.maxTemp, this.description});
}

int convertFtoC(int temperature){
  double result = (temperature - 32) * (5/9);
  return result.round();
}

int convertCtoF(int temperature){
  double result = temperature * (9/5) + 32;
  return result.round();
}