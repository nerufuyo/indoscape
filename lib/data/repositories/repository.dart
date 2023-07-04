import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:indoscape/common/private.dart';
import 'package:indoscape/data/models/country_model.dart';
import 'package:indoscape/data/models/news_model.dart';
import 'package:indoscape/data/models/news_station_model.dart';
import 'package:indoscape/data/models/quake_model.dart';
import 'package:indoscape/data/models/weather_hour_model.dart';
import 'package:indoscape/data/models/weather_model.dart';

class Repository {
  final newsBaseUrl = 'https://api-berita-indonesia.vercel.app/';
  final quakeBaseUrl = 'https://cuaca-gempa-rest-api.vercel.app/';
  final weatherBaseUrl = 'api.openweathermap.org';

  Future<List<Country>> getCountryInformation() async {
    final response = await http
        .get(Uri.parse('https://restcountries.com/v3.1/name/indonesia'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return List<Country>.from(
              data.map((countryData) => Country.fromJson(countryData)));
        } else if (data is Map<String, dynamic>) {
          return [Country.fromJson(data)];
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load country information');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<NewsStationListModel>> getNewsStationList() async {
    final response = await http.get(Uri.parse(newsBaseUrl));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<NewsStationListModel> newsStationList = [];
        for (final newsStation in data['endpoints']) {
          newsStationList.add(NewsStationListModel.fromJson(newsStation));
        }
        return newsStationList;
      } else {
        throw Exception('Failed to load news station list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<NewsModel> getNewsList(String station, String category) async {
    final response =
        await http.get(Uri.parse('$newsBaseUrl/$station/$category'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NewsModel.fromJson(data['data']);
      } else {
        throw Exception('Failed to load news list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<QuakeModel> getQuake() async {
    final response = await http.get(Uri.parse('$quakeBaseUrl/quake'));

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return QuakeModel.fromJson(data['data']);
      } else {
        throw Exception('Failed to load quake information');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WeatherModel> getWeather(String lat, String lon) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> parameters = {
      'lat': lat,
      'lon': lon,
      'appid': weatherApiKey,
    };
    Uri uri = Uri.https(weatherBaseUrl, '/data/2.5/weather', parameters);

    final response = await http.get(uri, headers: header);

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('Failed to load weather information');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WeatherHourModel> getWeatherByHour(String lat, String lon) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> parameters = {
      'lat': lat,
      'lon': lon,
      'appid': weatherApiKey,
    };
    Uri uri = Uri.https(weatherBaseUrl, '/data/2.5/forecast', parameters);

    final response = await http.get(uri, headers: header);

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherHourModel.fromJson(data);
      } else {
        throw Exception('Failed to load weather information');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
