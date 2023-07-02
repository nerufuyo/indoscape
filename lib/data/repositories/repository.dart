import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:indoscape/data/models/country_model.dart';
import 'package:indoscape/data/models/news_model.dart';
import 'package:indoscape/data/models/news_station_model.dart';

class Repository {
  final newsBaseUrl = 'https://api-berita-indonesia.vercel.app/';

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
}
