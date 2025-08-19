// ignore_for_file: public_member_api_docs, sort_constructors_first
/// Parameter
class PMSelPopularList {
  final String startDt;
  final String endDt;
  final String addCode;
  final int pageNo;
  final int pageSize;

  PMSelPopularList({
    required this.startDt,
    required this.endDt,
    this.addCode = '0;1;2;4;9',
    this.pageNo = 1,
    this.pageSize = 15,
  });

  Map<String, dynamic> toJson() {
    return {
      'startDt': startDt,
      'endDt': endDt,
      'addCode': addCode,
      'pageNo': pageNo,
      'pageSize': pageSize,
    };
  }
}

/// Response
class BaseDMSelPopularList {
  final DMSelPopularList? response;

  BaseDMSelPopularList({this.response});

  factory BaseDMSelPopularList.fromJson(Map<String, dynamic> json) =>
      BaseDMSelPopularList(
        response:
            json['response'] != null
                ? DMSelPopularList.fromJson(json['response'])
                : null,
      );
}

class DMSelPopularList {
  final SelPopularListReqData? request;
  final int? resultNum;
  final int? numFound;
  final List<SelPopularListData>? docs;

  DMSelPopularList({this.request, this.resultNum, this.numFound, this.docs});

  factory DMSelPopularList.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? docs = json['docs'];
    return DMSelPopularList(
      request:
          json['request'] != null
              ? SelPopularListReqData.fromJson(json['request'])
              : null,
      resultNum: json['resultNum'],
      numFound: json['numFound'],
      docs: docs?.map((item) => SelPopularListData.fromJson(item)).toList(),
    );
  }
}

class SelPopularListReqData {
  final String? startDt;
  final String? endDt;
  final int? pageNo;
  final int? pageSize;

  SelPopularListReqData({this.startDt, this.endDt, this.pageNo, this.pageSize});

  factory SelPopularListReqData.fromJson(Map<String, dynamic> json) =>
      SelPopularListReqData(
        startDt: json['startDt'],
        endDt: json['endDt'],
        pageNo: json['pageNo'],
        pageSize: json['pageSize'],
      );
}

class SelPopularListData {
  final PopularListItem? item;

  SelPopularListData({this.item});

  factory SelPopularListData.fromJson(Map<String, dynamic> json) =>
      SelPopularListData(
        item:
            json['doc'] != null ? PopularListItem.fromJson(json['doc']) : null,
      );
}

class PopularListItem {
  final int? no;
  final String? ranking;
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

  PopularListItem({
    this.no,
    this.ranking,
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

  factory PopularListItem.fromJson(Map<String, dynamic> json) =>
      PopularListItem(
        no: json['no'],
        ranking: json['ranking'],
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
