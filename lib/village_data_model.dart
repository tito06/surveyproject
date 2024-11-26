class VillageDataModel {
  int? status;
  bool? success;
  int? code;
  String? message;
  List<Data>? data;

  VillageDataModel(
      {this.status, this.success, this.code, this.message, this.data});

  VillageDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? vCODE;
  String? vNAME;
  String? vHNAME;
  String? vYEAR;

  Data({this.vCODE, this.vNAME, this.vHNAME, this.vYEAR});

  Data.fromJson(Map<String, dynamic> json) {
    vCODE = json['V_CODE'];
    vNAME = json['V_NAME'];
    vHNAME = json['V_HNAME'];
    vYEAR = json['V_YEAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['V_CODE'] = this.vCODE;
    data['V_NAME'] = this.vNAME;
    data['V_HNAME'] = this.vHNAME;
    data['V_YEAR'] = this.vYEAR;
    return data;
  }
}
