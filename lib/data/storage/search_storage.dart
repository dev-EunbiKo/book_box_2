import 'package:book_box_2/data/storage/storage_core.dart';

class SearchStorage {
  static const recentKeyword = 'recentKeyword';

  /// 최근 검색어 가져오기
  static Future<List<SearchStorageRecentModel>?> getRecentList() async {
    SearchStorageRecentListModel? value =
        await StorageCore.getValue<SearchStorageRecentListModel?>(
          recentKeyword,
          fromJson: SearchStorageRecentListModel.fromJson,
        );

    return value?.list;
  }

  static Future<void> addRecent(SearchStorageRecentModel value) async {
    List<SearchStorageRecentModel>? list = await SearchStorage.getRecentList();
    if (list != null) {
      list.removeWhere((item) => item.keyword == value.keyword); // 중복 삭제
      list.insert(0, value);

      // 최대 20개
      if (list.length > 20) {
        list.removeLast();
      }
      await StorageCore.setValue(
        recentKeyword,
        SearchStorageRecentListModel(list: list).toJson(),
      );
    } else {
      await StorageCore.setValue(
        recentKeyword,
        SearchStorageRecentListModel(list: list).toJson(),
      );
    }
  }

  /// 최근 검색어 개별 삭제
  static Future<void> removeRecent(SearchStorageRecentModel value) async {
    List<SearchStorageRecentModel>? list = await SearchStorage.getRecentList();

    if (list != null) {
      list.removeWhere((item) => item.searchDate == value.searchDate);
      await StorageCore.setValue(
        recentKeyword,
        SearchStorageRecentListModel(list: list).toJson(),
      );
    }
  }

  /// 최근 검색어 전체 삭제
  static Future<void> clearRecentAll() async {
    await StorageCore.setValue(
      recentKeyword,
      SearchStorageRecentListModel(list: []).toJson(),
    );
  }
}

/// 최근 검색어 DM 리스트
class SearchStorageRecentListModel {
  final List<SearchStorageRecentModel>? list;

  SearchStorageRecentListModel({this.list});

  Map<String, dynamic> toJson() {
    return {'list': list?.map((item) => item.toJson()).toList()};
  }

  factory SearchStorageRecentListModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? listJson = json['list'];
    List<SearchStorageRecentModel>? searchList =
        listJson != null
            ? List<SearchStorageRecentModel>.from(
              listJson.map((item) => SearchStorageRecentModel.fromJson(item)),
            )
            : null;
    return SearchStorageRecentListModel(list: searchList);
  }
}

/// 최근 검색어 데이터 모델
class SearchStorageRecentModel {
  final String? keyword; // 검색 키워드
  final String? searchDate; // 검색 날짜

  SearchStorageRecentModel({this.keyword, this.searchDate});

  Map<String, dynamic> toJson() {
    return {'keyword': keyword, 'searchDate': searchDate};
  }

  factory SearchStorageRecentModel.fromJson(Map<String, dynamic> json) =>
      SearchStorageRecentModel(
        keyword: json['keyword'],
        searchDate: json['searchDate'],
      );
}
