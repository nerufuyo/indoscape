import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:indoscape/data/models/charades_model.dart';
import 'package:indoscape/data/models/country_model.dart';
import 'package:indoscape/data/models/culture_model.dart';
import 'package:indoscape/data/models/detail_movie_model.dart';
import 'package:indoscape/data/models/food_model.dart';
import 'package:indoscape/data/models/mountain_model.dart';
import 'package:indoscape/data/models/movie_model.dart';
import 'package:indoscape/data/models/news_model.dart';
import 'package:indoscape/data/models/news_station_model.dart';
import 'package:indoscape/data/models/quake_model.dart';
import 'package:indoscape/data/models/travel_model.dart';
import 'package:indoscape/data/models/weather_hour_model.dart';
import 'package:indoscape/data/models/weather_model.dart';

class Repository {
  final weatherApiKey = dotenv.env['WEATHER_API_KEY'];
  final movieApiKey = dotenv.env['MOVIE_API_KEY'];
  final newsBaseUrl = dotenv.env['NEWS_API'];
  final quakeBaseUrl = dotenv.env['QUAKE_API'];
  final charadesBaseUrl = dotenv.env['CHARADES_API'];
  final weatherBaseUrl = dotenv.env['WEATHER_API'];
  final movieBaseUrl = dotenv.env['MOVIE_API'];
  final countryBaseUrl = dotenv.env['COUNTRY_API'];

  Future<List<Country>> getCountryInformation() async {
    final response = await http.get(Uri.parse(countryBaseUrl!));

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
    final response = await http.get(Uri.parse(newsBaseUrl!));

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
      'appid': weatherApiKey.toString(),
    };
    Uri uri = Uri.https(weatherBaseUrl!, '/data/2.5/weather', parameters);

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
      'appid': weatherApiKey.toString(),
    };
    Uri uri = Uri.https(weatherBaseUrl!, '/data/2.5/forecast', parameters);

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

  Future<MovieModel> getNowPlayingMovies(int page) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> parameters = {
      'page': page.toString(),
      'region': 'ID',
      'api_key': movieApiKey.toString(),
    };

    final response = await http.get(
      Uri.https(movieBaseUrl!, '/3/movie/now_playing', parameters),
      headers: header,
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModel> getPopularMovies(int page) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> parameters = {
      'page': page.toString(),
      'region': 'ID',
      'api_key': movieApiKey.toString(),
    };

    final response = await http.get(
      Uri.https(movieBaseUrl!, '/3/movie/popular', parameters),
      headers: header,
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModel> getTopRatedMovies(int page) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> parameters = {
      'page': page.toString(),
      'region': 'ID',
      'api_key': movieApiKey.toString(),
    };

    final response = await http.get(
      Uri.https(movieBaseUrl!, '/3/movie/top_rated', parameters),
      headers: header,
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieModel> getUpcomingMovies(int page) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> parameters = {
      'page': page.toString(),
      'region': 'ID',
      'api_key': movieApiKey.toString(),
    };

    final response = await http.get(
      Uri.https(movieBaseUrl!, '/3/movie/upcoming', parameters),
      headers: header,
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DetailMovieModel> getMovieById(int id) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> parameters = {
      'api_key': movieApiKey.toString(),
    };

    final response = await http.get(
      Uri.https(movieBaseUrl!, '/3/movie/$id', parameters),
      headers: header,
    );

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DetailMovieModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CharadesModel> getCharades() async {
    final response = await http.get(Uri.parse(charadesBaseUrl!));
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CharadesModel.fromJson(data['hasil']);
      } else {
        throw Exception('Failed to load charades list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<FoodModel>> getFoodList() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/food.json');
    try {
      if (response.isNotEmpty) {
        final Map<String, dynamic> data = json.decode(response);
        final List<dynamic> foodList = data['foods'];
        return foodList.map((e) => FoodModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load food list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<MountainModel>> getMountainList() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/mountain.json');
    try {
      if (response.isNotEmpty) {
        final Map<String, dynamic> data = json.decode(response);
        final List<dynamic> mountainList = data['mountains'];
        return mountainList.map((e) => MountainModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load mountain list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CultureModel>> getCultureList() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/culture.json');
    try {
      if (response.isNotEmpty) {
        final Map<String, dynamic> data = json.decode(response);
        final List<dynamic> cultureList = data['cultures'];
        return cultureList.map((e) => CultureModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load culture list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<TravelModel>> getTravelList() async {
    final String response =
        await rootBundle.loadString('lib/assets/json/travel.json');
    try {
      if (response.isNotEmpty) {
        final Map<String, dynamic> data = json.decode(response);
        final List<dynamic> travelList = data['travels'];
        return travelList.map((e) => TravelModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load travel list');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
