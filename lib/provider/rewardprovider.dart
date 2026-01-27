import 'package:bharatmandiram/model/earncoinmodel.dart';
import 'package:bharatmandiram/model/earncointransactionlistmodel.dart' as transaction;
import 'package:bharatmandiram/model/earncointransactionlistmodel.dart';
import 'package:bharatmandiram/model/successmodel.dart';
import 'package:bharatmandiram/webservice/apiservices.dart';
import 'package:flutter/foundation.dart';

class RewardProvider extends ChangeNotifier {
  Earncoinmodel earncoinsModel = Earncoinmodel();
  SuccessModel earntransactionmodel = SuccessModel();
  EarnCoindTransactionListModel earntransactionlistmodel =
      EarnCoindTransactionListModel();
  bool loadmore = false;
  bool isLoading = false;
  bool loading = false;
  List<transaction.Result>? transactionlist = [];

  int? totalRows,  totalPage, currentPage;
  bool isMorePage = false;
  void setLoading(isloading) {
    isLoading = isloading;
    loading = isloading;
  }

  void cleaProvider(){
    transactionlist = [];
    currentPage = 0;
     totalPage = 0;
  }

    void setPaginationData(int? totalRows, int? totalPage,
      int? currentPage, bool? isMorePage) {
    this.currentPage = currentPage;
    this.totalRows = totalRows;
    this.totalPage = totalPage;
    this.isMorePage = isMorePage!;
    
    notifyListeners();
  }

  Future<void> getEarnCoins() async {
    isLoading = true;
    earncoinsModel = await ApiService().getearncoins();
    debugPrint("earncoinsModel status :==> ${earncoinsModel.status}");
    debugPrint("earncoinsModel message :==> ${earncoinsModel.message}");

    isLoading = false;
    notifyListeners();
  }

  Future<void> getEarnTransactions(coin, type) async {
    loading = true;
    earntransactionmodel = await ApiService().getearntransaction(coin, type);
    debugPrint(
        "earntransactionmodel status :==> ${earntransactionmodel.status}");
    debugPrint(
        "earntransactionmodel message :==> ${earntransactionmodel.message}");
 
    loading = false;
    notifyListeners();
  }
  void setLoadMore(loadmore) {
    this.loadmore = loadmore;
    notifyListeners();
  }

  Future<void> getEarnTransactionsList(pageNo) async {
    isLoading = true;
    earntransactionlistmodel = await ApiService().getearntransactionlist(pageNo);
    debugPrint(
        "earntransactionlistmodel status :==> ${earntransactionlistmodel.status}");
    debugPrint(
        "earntransactionlistmodel message :==> ${earntransactionlistmodel.message}");
 if (earntransactionlistmodel.status == 200) {
      setPaginationData(
          earntransactionlistmodel.totalRows,
          earntransactionlistmodel.totalPage,
          earntransactionlistmodel.currentPage,
          earntransactionlistmodel.morePage);
      if (earntransactionlistmodel.result != null &&
          (earntransactionlistmodel.result?.length ?? 0) > 0) {
        if (earntransactionlistmodel.result != null &&
            (earntransactionlistmodel.result?.length ?? 0) > 0) {
          for (var i = 0;
              i < (earntransactionlistmodel.result?.length ?? 0);
              i++) {
            transactionlist
                ?.add(earntransactionlistmodel.result?[i] ?? transaction.Result());
          }
          final Map<int, transaction.Result> postMap = {};
          transactionlist?.forEach((item) {
            postMap[item.id ?? 0] = item;
          });
          transactionlist = postMap.values.toList();

          setLoadMore(false);
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
