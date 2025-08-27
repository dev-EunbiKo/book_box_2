// ignore_for_file: public_member_api_docs, sort_constructors_first
/// Parameter
class PMSearchBookList {
  final String keyword;
  final int pageNo;
  final int pageSize;

  PMSearchBookList({
    required this.keyword,
    required this.pageNo,
    this.pageSize = 15,
  });

  Map<String, dynamic> toJson() {
    return {'keyword': keyword, 'pageNo': pageNo, 'pageSize': pageSize};
  }
}

/// Response
class BaseDMSearchList {
  final DMSearchList? response;

  BaseDMSearchList({this.response});

  factory BaseDMSearchList.fromJson(Map<String, dynamic> json) =>
      BaseDMSearchList(
        response:
            json['response'] != null
                ? DMSearchList.fromJson(json['response'])
                : null,
      );
}

class DMSearchList {
  final SearchListReqData? request;

  final int? numFound;
  final List<SearchListData>? docs;

  DMSearchList({this.request, this.numFound, this.docs});

  factory DMSearchList.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? docs = json['docs'];
    return DMSearchList(
      request:
          json['request'] != null
              ? SearchListReqData.fromJson(json['request'])
              : null,
      numFound: json['numFound'],
      docs: docs?.map((item) => SearchListData.fromJson(item)).toList(),
    );
  }
}

class SearchListReqData {
  final String? keyword;
  final int? pageNo;
  final int? pageSize;

  SearchListReqData({this.keyword, this.pageNo, this.pageSize});

  factory SearchListReqData.fromJson(Map<String, dynamic> json) =>
      SearchListReqData(
        keyword: json['startDt'],

        pageNo: json['pageNo'],
        pageSize: json['pageSize'],
      );
}

class SearchListData {
  final SearchListItem? item;

  SearchListData({this.item});

  factory SearchListData.fromJson(Map<String, dynamic> json) => SearchListData(
    item: json['doc'] != null ? SearchListItem.fromJson(json['doc']) : null,
  );
}

class SearchListItem {
  final String? bookname;
  final String? authors;
  final String? publisher;
  final String? publicationYear;
  final String? isbn13;
  final String? additionSymbol;
  final String? vol;
  final String? classNo;
  final String? classNm;
  final String? bookImageURL;
  final String? bookDtlUrl;
  final String? loanCount;

  SearchListItem({
    this.bookname,
    this.authors,
    this.publisher,
    this.publicationYear,
    this.isbn13,
    this.additionSymbol,
    this.vol,
    this.classNo,
    this.classNm,
    this.bookImageURL,
    this.bookDtlUrl,
    this.loanCount,
  });

  factory SearchListItem.fromJson(Map<String, dynamic> json) => SearchListItem(
    bookname: json['bookname'],
    authors: json['authors'],
    publisher: json['publisher'],
    publicationYear: json['publication_year'],
    isbn13: json['isbn13'],
    additionSymbol: json['addition_symbol'],
    vol: json['vol'],
    classNo: json['class_no'],
    classNm: json['class_nm'],
    bookImageURL: json['bookImageURL'],
    bookDtlUrl: json['bookDtlUrl'],
    loanCount: json['loan_count'],
  );
}
