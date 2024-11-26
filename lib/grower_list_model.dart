class GrowerListModel {
  int? status;
  bool? success;
  int? code;
  String? message;
  List<Data>? data;

  GrowerListModel(
      {this.status, this.success, this.code, this.message, this.data});

  GrowerListModel.fromJson(Map<String, dynamic> json) {
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
  int? gCODE;
  String? gNAME;
  String? gFATHER;
  String? gHNAME;

  Data({this.gCODE, this.gNAME, this.gFATHER, this.gHNAME});

  Data.fromJson(Map<String, dynamic> json) {
    gCODE = json['G_CODE'];
    gNAME = json['G_NAME'];
    gFATHER = json['G_FATHER'];
    gHNAME = json['G_HNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['G_CODE'] = this.gCODE;
    data['G_NAME'] = this.gNAME;
    data['G_FATHER'] = this.gFATHER;
    data['G_HNAME'] = this.gHNAME;
    return data;
  }
}
