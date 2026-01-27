import 'package:bharatmandiram/model/videobyidmodel.dart' as content;
import 'package:bharatmandiram/model/videobyidmodel.dart' as language;
import 'package:bharatmandiram/model/videobyidmodel.dart';
import 'package:bharatmandiram/utils/constant.dart';
import 'package:bharatmandiram/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class VideoByIDProvider extends ChangeNotifier {
  VideoByIdModel videoByIdModel = VideoByIdModel();

  bool loading = false;

  bool isloading = false, loadMore = false;
  //content
  int? totalRows, totalPage, currentPage;
  bool? isMorePage;
  List<content.Result>? contentDataList = [];

  List<language.Result>? videoDataList = [];

  void setLoading(isLoading) {
    loading = isLoading;
    notifyListeners();
  }

  void setContentDataPaginationData(
      int? totalRows, int? totalPage, int? currentPage, bool? isMorePage) {
    this.currentPage = currentPage;
    this.totalRows = totalRows;
    this.totalPage = totalPage;
    this.isMorePage = isMorePage;
    notifyListeners();
  }

  Future<void> getVideoByCategory(categoryID, typeId, pageNo) async {
    debugPrint("getVideoByCategory userID :======> ${Constant.userID}");
    debugPrint("getVideoByCategory categoryID :==> $categoryID");
    debugPrint("getVideoByCategory typeId :======> $typeId");
    loading = true;
    videoByIdModel =
        await ApiService().videoByCategory(categoryID, typeId, pageNo);
    if (videoByIdModel.status == 200) {
      setContentDataPaginationData(
          videoByIdModel.totalRows,
          videoByIdModel.totalPage,
          videoByIdModel.currentPage,
          videoByIdModel.morePage);
      if (videoByIdModel.result != null &&
          (videoByIdModel.result?.length ?? 0) > 0) {
        for (var i = 0; i < (videoByIdModel.result?.length ?? 0); i++) {
          videoDataList?.add(videoByIdModel.result?[i] ?? language.Result());
        }
        final Map<int, language.Result> postMap = {};
        videoDataList?.forEach((item) {
          postMap[item.id ?? 0] = item;
        });
        videoDataList = postMap.values.toList();
        setLoadMore(false);
      }
    }

    loading = false;
    notifyListeners();
  }

  Future<void> getVideoByLanguage(languageID, typeId, pageNo) async {
    loading = true;
    videoByIdModel =
        await ApiService().videoByLanguage(languageID, typeId, pageNo);
    if (videoByIdModel.status == 200) {
      setContentDataPaginationData(
          videoByIdModel.totalRows,
          videoByIdModel.totalPage,
          videoByIdModel.currentPage,
          videoByIdModel.morePage);
      if (videoByIdModel.result != null &&
          (videoByIdModel.result?.length ?? 0) > 0) {
        for (var i = 0; i < (videoByIdModel.result?.length ?? 0); i++) {
          videoDataList?.add(videoByIdModel.result?[i] ?? language.Result());
        }
        final Map<int, language.Result> postMap = {};
        videoDataList?.forEach((item) {
          postMap[item.id ?? 0] = item;
        });
        videoDataList = postMap.values.toList();
        setLoadMore(false);
      }
    }
    loading = false;
    notifyListeners();
  }

  void clearVideoByIDProvider() {
    debugPrint("<================ clearVideoByIDProvider ================>");
    videoByIdModel = VideoByIdModel();
    videoDataList = [];
    currentPage = 0;
    totalPage = 0;
  }

  void setLoadMore(loadMore) {
    this.loadMore = loadMore;
    notifyListeners();
  }
}
