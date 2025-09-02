// ignore_for_file: public_member_api_docs, sort_constructors_first
/// Parameter
class PMSelBookDetail {
  final String isbn;

  PMSelBookDetail({required this.isbn});

  Map<String, dynamic> toJson() {
    return {'isbn13': isbn};
  }
}

/// Response
class BaseDMSelBookDetail {
  final DMSelBookDetail? response;

  BaseDMSelBookDetail({this.response});

  factory BaseDMSelBookDetail.fromJson(Map<String, dynamic> json) =>
      BaseDMSelBookDetail(
        response:
            json['response'] != null
                ? DMSelBookDetail.fromJson(json['response'])
                : null,
      );
}

class DMSelBookDetail {
  final SelBookDetailReqData? request;
  final List<SelBookDetailData>? detail;

  DMSelBookDetail({this.request, this.detail});

  factory DMSelBookDetail.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? detail = json['detail'];
    return DMSelBookDetail(
      request:
          json['request'] != null
              ? SelBookDetailReqData.fromJson(json['request'])
              : null,
      detail: detail?.map((item) => SelBookDetailData.fromJson(item)).toList(),
    );
  }
}

class SelBookDetailReqData {
  final String? isbn;

  SelBookDetailReqData({this.isbn});

  factory SelBookDetailReqData.fromJson(Map<String, dynamic> json) =>
      SelBookDetailReqData(isbn: json['isbn13']);
}

class SelBookDetailData {
  final BookDetailItem? item;

  SelBookDetailData({this.item});

  factory SelBookDetailData.fromJson(Map<String, dynamic> json) =>
      SelBookDetailData(
        item:
            json['book'] != null ? BookDetailItem.fromJson(json['book']) : null,
      );
}

class BookDetailItem {
  final int? no;
  final String? bookname;
  final String? authors;
  final String? publisher;
  final String? publicationYear;
  final String? publicationDate;
  final String? isbn;
  final String? isbn13;
  final String? additionSymbol;
  final String? vol;
  final String? classNo;
  final String? classNm;
  final String? description;
  final String? bookImageURL;

  BookDetailItem({
    this.no,
    this.bookname,
    this.authors,
    this.publisher,
    this.publicationYear,
    this.publicationDate,
    this.isbn,
    this.isbn13,
    this.additionSymbol,
    this.vol,
    this.classNo,
    this.classNm,
    this.description,
    this.bookImageURL,
  });

  factory BookDetailItem.fromJson(Map<String, dynamic> json) => BookDetailItem(
    no: json['no'],
    bookname: json['bookname'],
    authors: json['authors'],
    publisher: json['publisher'],
    publicationYear: json['publication_date'],
    publicationDate: json['publication_year'],
    isbn: json['isbn'],
    isbn13: json['isbn13'],
    additionSymbol: json['addition_symbol'],
    vol: json['vol'],
    classNo: json['class_no'],
    classNm: json['class_nm'],
    description: json['description'],
    bookImageURL: json['bookImageURL'],
  );
}
