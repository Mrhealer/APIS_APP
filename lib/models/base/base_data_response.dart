
import 'base_model.dart';

class BaseDataResponse extends BaseModel {
  bool success;
  String urlRedirect;
  String message;
  Object data;
  int totalRow;
  String pager;
  String pagerInfo;
  int type;

  BaseDataResponse(
      {this.success,
      this.urlRedirect,
      this.message,
      this.data,
      this.totalRow,
      this.pager,
      this.pagerInfo,
      this.type});

  BaseDataResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    urlRedirect = json['UrlRedirect'];
    message = json['Message'];
    data = json['Data'];
    totalRow = json['TotalRow'];
    pager = json['Pager'];
    pagerInfo = json['PagerInfo'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['UrlRedirect'] = this.urlRedirect;
    data['Message'] = this.message;
    data['Data'] = this.data;
    data['TotalRow'] = this.totalRow;
    data['Pager'] = this.pager;
    data['PagerInfo'] = this.pagerInfo;
    data['Type'] = this.type;
    return data;
  }
}
