import 'package:flutter/foundation.dart';

class ApplicationTracerModel{
  final String? aplksNmbr;
  final DateTime? aplksCreateOn;
  final DateTime? aplksVrfyOn;
  final DateTime? aplksUwOn;
  final DateTime? aplksPolisOn;
  final DateTime? aplksPrintPolisPage1On;
  final String? cstmFullName;
  final String? prdcName;
  final String? aplksPolisNmbr;
  final int? aplksStatusId;
  final InfoUnderwritingModel? underwriting;
  final List<InfoMonitoringModel>? monitoring;

  ApplicationTracerModel({this.aplksNmbr, this.aplksCreateOn, this.aplksVrfyOn, this.aplksUwOn, this.aplksPolisOn,
    this.aplksPrintPolisPage1On, this.cstmFullName, this.prdcName, this.aplksPolisNmbr, this.aplksStatusId, this.underwriting, this.monitoring
  });

  factory ApplicationTracerModel.fromJSON(Map<String, dynamic> jsonMap){
    
    var monitorings = jsonMap["monitoring"] as List;
    List<InfoMonitoringModel> listMonitoring = monitorings.map((i) => InfoMonitoringModel.fromJSON(i)).toList();
    final data = ApplicationTracerModel(
      aplksNmbr: jsonMap["aplksNmbr"],
      aplksCreateOn: DateTime.parse(jsonMap["aplksCreateOn"]),
      aplksVrfyOn: DateTime.parse(jsonMap["aplksVrfyOn"]),
      aplksUwOn: jsonMap["aplksUwOn"] != null ? DateTime.parse(jsonMap["aplksUwOn"]) : null,
      aplksPolisOn: DateTime.parse(jsonMap["aplksPolisOn"]),
      aplksPrintPolisPage1On: DateTime.parse(jsonMap["aplksPrintPolisPage1On"]),
      cstmFullName: jsonMap["cstmFullName"],
      prdcName: jsonMap["prdcName"],
      aplksPolisNmbr: jsonMap["aplksPolisNmbr"],
      aplksStatusId: jsonMap["aplksStatusId"],
      underwriting: jsonMap["underwriting"] == null ? null : InfoUnderwritingModel.fromJSON(jsonMap["underwriting"]),
      monitoring: listMonitoring
    );
    return data;
  }
}

class InfoUnderwritingModel{
  final String? risknoteAplksNmbr;
  final String? risknoteFlag;
  final String? risknoteNote;
  final DateTime? risknoteDate;
  final String? createBy;
  final DateTime? createOn;

  InfoUnderwritingModel({this.risknoteAplksNmbr, this.risknoteFlag, this.risknoteNote, this.risknoteDate, this.createBy, this.createOn});

  factory InfoUnderwritingModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = InfoUnderwritingModel(
      risknoteAplksNmbr: jsonMap["risknoteAplksNmbr"],
      risknoteFlag: jsonMap["risknoteFlag"],
      risknoteNote: jsonMap["risknoteNote"],
      risknoteDate: DateTime.parse(jsonMap["risknoteDate"]),
      createBy: jsonMap["createBy"],
      createOn: DateTime.parse(jsonMap["createOn"]),
    );
    return data;
  }
}

class InfoMonitoringModel{
  final String? dischl;
  final String? noapli;
  final String? nopsrt;
  final String? trccod;
  final String? trcdesc;
  final DateTime? tgltrc;
  final String? stats1;
  final String? createBy;
  final DateTime? createOn;

  InfoMonitoringModel({this.dischl, this.noapli, this.nopsrt, this.trccod, this.trcdesc, this.tgltrc, this.stats1, this.createBy, this.createOn});

  factory InfoMonitoringModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = InfoMonitoringModel(
      dischl: jsonMap["dischl"],
      noapli: jsonMap["noapli"],
      nopsrt: jsonMap["nopsrt"],
      trccod: jsonMap["trccod"],
      trcdesc: jsonMap["trcdesc"],
      tgltrc: DateTime.parse(jsonMap["tgltrc"]),
      stats1: jsonMap["stats1"],
      createBy: jsonMap["createBy"],
      createOn: DateTime.parse(jsonMap["createOn"]),
    );
    return data;
  }
}