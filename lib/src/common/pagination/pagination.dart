class Pagination<T> {
  List<T>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  bool? first;
  Sort? sort;
  int? numberOfElements;
  int? size;
  int? number;
  bool? empty;

  Pagination(
      {this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.first,
      this.sort,
      this.numberOfElements,
      this.size,
      this.number,
      this.empty});

  Pagination copyWith(List<dynamic> newContent) {
    return Pagination(
        content: newContent,
        pageable: pageable,
        totalPages: totalPages,
        totalElements: totalElements,
        last: last,
        first: first,
        sort: sort,
        numberOfElements: numberOfElements,
        size: size,
        number: number,
        empty: empty);
  }

  Pagination<T2> newContent<T2>(List<T2> newContent) {
    return Pagination(
        content: newContent,
        pageable: pageable,
        totalPages: totalPages,
        totalElements: totalElements,
        last: last,
        first: first,
        sort: sort,
        numberOfElements: numberOfElements,
        size: size,
        number: number,
        empty: empty);
  }

  Pagination.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    content = (json['content'] as List<dynamic>).map((item) => fromJsonT(item as Map<String, dynamic>)).toList();
    pageable = json['pageable'] != null ? new Pageable.fromJson(json['pageable']) : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    first = json['first'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['first'] = this.first;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['number'] = this.number;
    data['empty'] = this.empty;
    return data;
  }

  @override
  String toString() {
    return 'Pagination{content: $content, pageable: $pageable, totalPages: $totalPages, totalElements: $totalElements, last: $last, first: $first, sort: $sort, numberOfElements: $numberOfElements, size: $size, number: $number, empty: $empty}';
  }
}

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable({this.sort, this.pageNumber, this.pageSize, this.offset, this.paged, this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['offset'] = this.offset;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool? unsorted;
  bool? sorted;
  bool? empty;

  Sort({this.unsorted, this.sorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    unsorted = json['unsorted'];
    sorted = json['sorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unsorted'] = this.unsorted;
    data['sorted'] = this.sorted;
    data['empty'] = this.empty;
    return data;
  }
}
