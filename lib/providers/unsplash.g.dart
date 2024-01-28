// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsplash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnsplashResponseImpl _$$UnsplashResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UnsplashResponseImpl(
      width: json['width'] as int,
      height: json['height'] as int,
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UnsplashResponseImplToJson(
        _$UnsplashResponseImpl instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'urls': instance.urls,
    };

_$UrlsImpl _$$UrlsImplFromJson(Map<String, dynamic> json) => _$UrlsImpl(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
      thumb: json['thumb'] as String,
      smallS3: json['smallS3'] as String?,
    );

Map<String, dynamic> _$$UrlsImplToJson(_$UrlsImpl instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'smallS3': instance.smallS3,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unsplashHash() => r'4d60789f49a8b183ad75e14d33265e84b2443c4c';

/// See also [unsplash].
@ProviderFor(unsplash)
final unsplashProvider = AutoDisposeFutureProvider<UnsplashResponse?>.internal(
  unsplash,
  name: r'unsplashProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$unsplashHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UnsplashRef = AutoDisposeFutureProviderRef<UnsplashResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
