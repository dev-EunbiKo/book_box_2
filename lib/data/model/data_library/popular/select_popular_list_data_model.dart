class PMSelPopularList {
  final String startDt;

  PMSelPopularList({required this.startDt});

  Map<String, dynamic> toJson() {
    return {'startDt': startDt};
  }
}

class BaseDMPopularList {
  final DMSelPopularList? response;

  BaseDMPopularList({this.response});

  factory BaseDMPopularList.fromJson(Map<String, dynamic> json) =>
      BaseDMPopularList(
        response:
            json['response'] != null
                ? DMSelPopularList.fromJson(json['response'])
                : null,
      );
}

class DMSelPopularList {
  final RequestSelPopularList? request;
  final String? resultNum;
  final String? numFound;
  final SelPopularListData? data;

  DMSelPopularList({this.request, this.resultNum, this.numFound, this.data});

  factory DMSelPopularList.fromJson(Map<String, dynamic> json) =>
      DMSelPopularList(
        request:
            json['request'] != null
                ? RequestSelPopularList.fromJson(json['request'])
                : null,
        resultNum: json['resultNum'],
        numFound: json['numFound'],
        data:
            json['docs'] != null
                ? SelPopularListData.fromJson(json['docs'])
                : null,
      );
}

class RequestSelPopularList {
  final String? startDt;
  final String? endDt;
  final String? pageNo;
  final String? pageSize;

  RequestSelPopularList({this.startDt, this.endDt, this.pageNo, this.pageSize});

  factory RequestSelPopularList.fromJson(Map<String, dynamic> json) =>
      RequestSelPopularList(
        startDt: json['startDt'],
        endDt: json['endDt'],
        pageNo: json['pageNo'],
        pageSize: json['pageSize'],
      );
}

class SelPopularListData {
  final List<PopularListBookItem>? bookList;

  SelPopularListData({this.bookList});

  factory SelPopularListData.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? bookList = json['docs'];

    return SelPopularListData(
      bookList:
          bookList?.map((item) => PopularListBookItem.fromJson(item)).toList(),
    );
  }
}

class PopularListBookItem {
  final PopularListItem? item;

  PopularListBookItem({this.item});

  factory PopularListBookItem.fromJson(Map<String, dynamic> json) =>
      PopularListBookItem(
        item:
            json['doc'] != null ? PopularListItem.fromJson(json['doc']) : null,
      );
}

class PopularListItem {
  final String? no;
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
