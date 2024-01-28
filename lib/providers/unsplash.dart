import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'unsplash.freezed.dart';
part 'unsplash.g.dart';

@freezed
class UnsplashResponse with _$UnsplashResponse {
  const factory UnsplashResponse({
    required int width,
    required int height,
    required Urls urls,
  }) = _UnsplashResponse;

  factory UnsplashResponse.fromJson(Map<String, dynamic> json) =>
      _$UnsplashResponseFromJson(json);
}

@freezed
class Urls with _$Urls {
  const factory Urls(
      {required String raw,
      required String full,
      required String regular,
      required String small,
      required String thumb,
      String? smallS3}) = _Urls;

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
}

@riverpod
Future<UnsplashResponse?> unsplash(UnsplashRef ref) async {
  final headers = {'Authorization': 'Client-ID '};

  final response = await http
      .get(Uri.https('api.unsplash.com', '/photos/random'), headers: headers);

  if (response.statusCode == 200) {
    final test = UnsplashResponse.fromJson(json.decode(response.body));
    return test;
  } else {
    return null;
  }
}
