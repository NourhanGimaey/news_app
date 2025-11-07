import 'source.dart';

class ArticlesResponse {
  String? status;
  List<Source>? sources;

  ArticlesResponse({this.status, this.sources});

  @override
  String toString() {
    return 'ArticlesResponse(status: $status, sources: $sources)';
  }

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) {
    return ArticlesResponse(
      status: json['status'] as String?,
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'sources': sources?.map((e) => e.toJson()).toList(),
  };
}
