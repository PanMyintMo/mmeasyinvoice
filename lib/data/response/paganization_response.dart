import 'package:mmeasyInvoice/data/response/page_link.dart';

class PaganizationResponse {
  final int currentPage;
  final List<dynamic> data;
  final String firstPageUrl;
  final int? from;
  final int lastPage;
  final String lastPageUrl;
  final List<PageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int total;
  final int? status;
  final String? message;

  PaganizationResponse({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.status,
    required this.message,
  });

  factory PaganizationResponse.fromJson(Map<String, dynamic> json) {
    return PaganizationResponse(
      currentPage: json['current_page'],
      data: (json['data']['data'] as List<dynamic>?) ?? [],
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>?)?.map((item) => PageLink.fromJson(item)).toList() ?? [],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
      status: json['status'],
      message: json['message'],
    );
  }
}
