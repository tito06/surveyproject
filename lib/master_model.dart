class MasterModel {
  int? status;
  bool? success;
  int? code;
  String? message;
  Data? data;

  MasterModel({this.status, this.success, this.code, this.message, this.data});

  MasterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<DiseaseControlMgmts>? diseaseControlMgmts;
  List<Disease>? disease;
  List<PestControlMgmts>? pestControlMgmts;
  List<Pests>? pests;
  List<Variety>? variety;
  List<PlantingMethods>? plantingMethods;
  List<SeedSources>? seedSources;
  List<SeedTypes>? seedTypes;
  List<LandTypes>? landTypes;
  List<RowSpaces>? rowSpaces;
  List<IndentTypes>? indentTypes;
  List<StandingCrops>? standingCrops;
  List<SoilTreatments>? soilTreatments;
  List<InterCrops>? interCrops;
  List<Nursery>? nursery;
  List<IrrigationSource>? irrigationSource;
  List<AgriItems>? agriItems;
  List<AgriSource>? agriSource;
  List<AgriUnit>? agriUnit;
  List<Season>? season;
  List<NurserySeedSources>? nurserySeedSources;
  AtspServices? atspServices;
  List<MasterSuggestions>? masterSuggestions;
  List<MasterTodos>? masterTodos;

  Data(
      {this.diseaseControlMgmts,
      this.disease,
      this.pestControlMgmts,
      this.pests,
      this.variety,
      this.plantingMethods,
      this.seedSources,
      this.seedTypes,
      this.landTypes,
      this.rowSpaces,
      this.indentTypes,
      this.standingCrops,
      this.soilTreatments,
      this.interCrops,
      this.nursery,
      this.irrigationSource,
      this.agriItems,
      this.agriSource,
      this.agriUnit,
      this.season,
      this.nurserySeedSources,
      this.atspServices,
      this.masterSuggestions,
      this.masterTodos});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['disease_control_mgmts'] != null) {
      diseaseControlMgmts = <DiseaseControlMgmts>[];
      json['disease_control_mgmts'].forEach((v) {
        diseaseControlMgmts!.add(new DiseaseControlMgmts.fromJson(v));
      });
    }
    if (json['disease'] != null) {
      disease = <Disease>[];
      json['disease'].forEach((v) {
        disease!.add(new Disease.fromJson(v));
      });
    }
    if (json['pest_control_mgmts'] != null) {
      pestControlMgmts = <PestControlMgmts>[];
      json['pest_control_mgmts'].forEach((v) {
        pestControlMgmts!.add(new PestControlMgmts.fromJson(v));
      });
    }
    if (json['pests'] != null) {
      pests = <Pests>[];
      json['pests'].forEach((v) {
        pests!.add(new Pests.fromJson(v));
      });
    }
    if (json['variety'] != null) {
      variety = <Variety>[];
      json['variety'].forEach((v) {
        variety!.add(new Variety.fromJson(v));
      });
    }
    if (json['planting_methods'] != null) {
      plantingMethods = <PlantingMethods>[];
      json['planting_methods'].forEach((v) {
        plantingMethods!.add(new PlantingMethods.fromJson(v));
      });
    }
    if (json['seed_sources'] != null) {
      seedSources = <SeedSources>[];
      json['seed_sources'].forEach((v) {
        seedSources!.add(new SeedSources.fromJson(v));
      });
    }
    if (json['seed_types'] != null) {
      seedTypes = <SeedTypes>[];
      json['seed_types'].forEach((v) {
        seedTypes!.add(new SeedTypes.fromJson(v));
      });
    }
    if (json['land_types'] != null) {
      landTypes = <LandTypes>[];
      json['land_types'].forEach((v) {
        landTypes!.add(new LandTypes.fromJson(v));
      });
    }
    if (json['row_spaces'] != null) {
      rowSpaces = <RowSpaces>[];
      json['row_spaces'].forEach((v) {
        rowSpaces!.add(new RowSpaces.fromJson(v));
      });
    }
    if (json['indent_types'] != null) {
      indentTypes = <IndentTypes>[];
      json['indent_types'].forEach((v) {
        indentTypes!.add(new IndentTypes.fromJson(v));
      });
    }
    if (json['standing_crops'] != null) {
      standingCrops = <StandingCrops>[];
      json['standing_crops'].forEach((v) {
        standingCrops!.add(new StandingCrops.fromJson(v));
      });
    }
    if (json['soil_treatments'] != null) {
      soilTreatments = <SoilTreatments>[];
      json['soil_treatments'].forEach((v) {
        soilTreatments!.add(new SoilTreatments.fromJson(v));
      });
    }
    if (json['inter_crops'] != null) {
      interCrops = <InterCrops>[];
      json['inter_crops'].forEach((v) {
        interCrops!.add(new InterCrops.fromJson(v));
      });
    }
    if (json['nursery'] != null) {
      nursery = <Nursery>[];
      json['nursery'].forEach((v) {
        nursery!.add(new Nursery.fromJson(v));
      });
    }
    if (json['irrigation_source'] != null) {
      irrigationSource = <IrrigationSource>[];
      json['irrigation_source'].forEach((v) {
        irrigationSource!.add(new IrrigationSource.fromJson(v));
      });
    }
    if (json['agri_items'] != null) {
      agriItems = <AgriItems>[];
      json['agri_items'].forEach((v) {
        agriItems!.add(new AgriItems.fromJson(v));
      });
    }
    if (json['agri_source'] != null) {
      agriSource = <AgriSource>[];
      json['agri_source'].forEach((v) {
        agriSource!.add(new AgriSource.fromJson(v));
      });
    }
    if (json['agri_unit'] != null) {
      agriUnit = <AgriUnit>[];
      json['agri_unit'].forEach((v) {
        agriUnit!.add(new AgriUnit.fromJson(v));
      });
    }
    if (json['season'] != null) {
      season = <Season>[];
      json['season'].forEach((v) {
        season!.add(new Season.fromJson(v));
      });
    }
    if (json['nursery_seed_sources'] != null) {
      nurserySeedSources = <NurserySeedSources>[];
      json['nursery_seed_sources'].forEach((v) {
        nurserySeedSources!.add(new NurserySeedSources.fromJson(v));
      });
    }
    atspServices = json['atsp_services'] != null
        ? new AtspServices.fromJson(json['atsp_services'])
        : null;
    if (json['master_suggestions'] != null) {
      masterSuggestions = <MasterSuggestions>[];
      json['master_suggestions'].forEach((v) {
        masterSuggestions!.add(new MasterSuggestions.fromJson(v));
      });
    }
    if (json['master_todos'] != null) {
      masterTodos = <MasterTodos>[];
      json['master_todos'].forEach((v) {
        masterTodos!.add(new MasterTodos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diseaseControlMgmts != null) {
      data['disease_control_mgmts'] =
          this.diseaseControlMgmts!.map((v) => v.toJson()).toList();
    }
    if (this.disease != null) {
      data['disease'] = this.disease!.map((v) => v.toJson()).toList();
    }
    if (this.pestControlMgmts != null) {
      data['pest_control_mgmts'] =
          this.pestControlMgmts!.map((v) => v.toJson()).toList();
    }
    if (this.pests != null) {
      data['pests'] = this.pests!.map((v) => v.toJson()).toList();
    }
    if (this.variety != null) {
      data['variety'] = this.variety!.map((v) => v.toJson()).toList();
    }
    if (this.plantingMethods != null) {
      data['planting_methods'] =
          this.plantingMethods!.map((v) => v.toJson()).toList();
    }
    if (this.seedSources != null) {
      data['seed_sources'] = this.seedSources!.map((v) => v.toJson()).toList();
    }
    if (this.seedTypes != null) {
      data['seed_types'] = this.seedTypes!.map((v) => v.toJson()).toList();
    }
    if (this.landTypes != null) {
      data['land_types'] = this.landTypes!.map((v) => v.toJson()).toList();
    }
    if (this.rowSpaces != null) {
      data['row_spaces'] = this.rowSpaces!.map((v) => v.toJson()).toList();
    }
    if (this.indentTypes != null) {
      data['indent_types'] = this.indentTypes!.map((v) => v.toJson()).toList();
    }
    if (this.standingCrops != null) {
      data['standing_crops'] =
          this.standingCrops!.map((v) => v.toJson()).toList();
    }
    if (this.soilTreatments != null) {
      data['soil_treatments'] =
          this.soilTreatments!.map((v) => v.toJson()).toList();
    }
    if (this.interCrops != null) {
      data['inter_crops'] = this.interCrops!.map((v) => v.toJson()).toList();
    }
    if (this.nursery != null) {
      data['nursery'] = this.nursery!.map((v) => v.toJson()).toList();
    }
    if (this.irrigationSource != null) {
      data['irrigation_source'] =
          this.irrigationSource!.map((v) => v.toJson()).toList();
    }
    if (this.agriItems != null) {
      data['agri_items'] = this.agriItems!.map((v) => v.toJson()).toList();
    }
    if (this.agriSource != null) {
      data['agri_source'] = this.agriSource!.map((v) => v.toJson()).toList();
    }
    if (this.agriUnit != null) {
      data['agri_unit'] = this.agriUnit!.map((v) => v.toJson()).toList();
    }
    if (this.season != null) {
      data['season'] = this.season!.map((v) => v.toJson()).toList();
    }
    if (this.nurserySeedSources != null) {
      data['nursery_seed_sources'] =
          this.nurserySeedSources!.map((v) => v.toJson()).toList();
    }
    if (this.atspServices != null) {
      data['atsp_services'] = this.atspServices!.toJson();
    }
    if (this.masterSuggestions != null) {
      data['master_suggestions'] =
          this.masterSuggestions!.map((v) => v.toJson()).toList();
    }
    if (this.masterTodos != null) {
      data['master_todos'] = this.masterTodos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiseaseControlMgmts {
  int? id;
  int? diseaseId;
  String? controlMeasurement;

  DiseaseControlMgmts({this.id, this.diseaseId, this.controlMeasurement});

  DiseaseControlMgmts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diseaseId = json['disease_id'];
    controlMeasurement = json['control_measurement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['disease_id'] = this.diseaseId;
    data['control_measurement'] = this.controlMeasurement;
    return data;
  }
}

class Disease {
  int? dFACTID;
  int? dCODE;
  String? dDESC;

  Disease({this.dFACTID, this.dCODE, this.dDESC});

  Disease.fromJson(Map<String, dynamic> json) {
    dFACTID = json['D_FACTID'];
    dCODE = json['D_CODE'];
    dDESC = json['D_DESC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['D_FACTID'] = this.dFACTID;
    data['D_CODE'] = this.dCODE;
    data['D_DESC'] = this.dDESC;
    return data;
  }
}

class PestControlMgmts {
  int? id;
  int? pestId;
  String? controlMeasurement;

  PestControlMgmts({this.id, this.pestId, this.controlMeasurement});

  PestControlMgmts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pestId = json['pest_id'];
    controlMeasurement = json['control_measurement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pest_id'] = this.pestId;
    data['control_measurement'] = this.controlMeasurement;
    return data;
  }
}

class Pests {
  int? id;
  int? fACTID;
  String? year;
  String? pestName;

  Pests({this.id, this.fACTID, this.year, this.pestName});

  Pests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fACTID = json['FACT_ID'];
    year = json['year'];
    pestName = json['pest_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['FACT_ID'] = this.fACTID;
    data['year'] = this.year;
    data['pest_name'] = this.pestName;
    return data;
  }
}

class Variety {
  int? vRCODE;
  String? vRNAME;
  String? vRCATEG;
  String? vRMATURITY;
  String? seedRate;

  Variety(
      {this.vRCODE, this.vRNAME, this.vRCATEG, this.vRMATURITY, this.seedRate});

  Variety.fromJson(Map<String, dynamic> json) {
    vRCODE = json['VR_CODE'];
    vRNAME = json['VR_NAME'];
    vRCATEG = json['VR_CATEG'];
    vRMATURITY = json['VR_MATURITY'];
    seedRate = json['seed_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VR_CODE'] = this.vRCODE;
    data['VR_NAME'] = this.vRNAME;
    data['VR_CATEG'] = this.vRCATEG;
    data['VR_MATURITY'] = this.vRMATURITY;
    data['seed_rate'] = this.seedRate;
    return data;
  }
}

class PlantingMethods {
  int? id;
  String? plantingName;
  String? year;

  PlantingMethods({this.id, this.plantingName, this.year});

  PlantingMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantingName = json['planting_name'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['planting_name'] = this.plantingName;
    data['year'] = this.year;
    return data;
  }
}

class SeedSources {
  int? id;
  String? seedSource;
  String? year;
  String? type;

  SeedSources({this.id, this.seedSource, this.year, this.type});

  SeedSources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seedSource = json['seed_source'];
    year = json['year'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seed_source'] = this.seedSource;
    data['year'] = this.year;
    data['type'] = this.type;
    return data;
  }
}

class SeedTypes {
  int? id;
  String? type;
  String? year;

  SeedTypes({this.id, this.type, this.year});

  SeedTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['year'] = this.year;
    return data;
  }
}

class LandTypes {
  int? id;
  String? landType;
  String? year;

  LandTypes({this.id, this.landType, this.year});

  LandTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landType = json['land_type'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['land_type'] = this.landType;
    data['year'] = this.year;
    return data;
  }
}

class RowSpaces {
  int? id;
  String? spaceName;
  String? year;

  RowSpaces({this.id, this.spaceName, this.year});

  RowSpaces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceName = json['space_name'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_name'] = this.spaceName;
    data['year'] = this.year;
    return data;
  }
}

class IndentTypes {
  int? id;
  String? type;
  String? year;
  String? fromMonth;
  String? toMonth;

  IndentTypes({this.id, this.type, this.year, this.fromMonth, this.toMonth});

  IndentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    year = json['year'];
    fromMonth = json['from_month'];
    toMonth = json['to_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['year'] = this.year;
    data['from_month'] = this.fromMonth;
    data['to_month'] = this.toMonth;
    return data;
  }
}

class StandingCrops {
  int? cRPCODE;
  String? cRPNAME;
  String? cRPYEAR;

  StandingCrops({this.cRPCODE, this.cRPNAME, this.cRPYEAR});

  StandingCrops.fromJson(Map<String, dynamic> json) {
    cRPCODE = json['CRP_CODE'];
    cRPNAME = json['CRP_NAME'];
    cRPYEAR = json['CRP_YEAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CRP_CODE'] = this.cRPCODE;
    data['CRP_NAME'] = this.cRPNAME;
    data['CRP_YEAR'] = this.cRPYEAR;
    return data;
  }
}

class SoilTreatments {
  int? id;
  int? fACTID;
  String? year;
  String? soiltreatmentname;

  SoilTreatments({this.id, this.fACTID, this.year, this.soiltreatmentname});

  SoilTreatments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fACTID = json['FACT_ID'];
    year = json['year'];
    soiltreatmentname = json['soiltreatmentname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['FACT_ID'] = this.fACTID;
    data['year'] = this.year;
    data['soiltreatmentname'] = this.soiltreatmentname;
    return data;
  }
}

class InterCrops {
  int? cRPCODE;
  String? cRPYEAR;
  int? cRPFACTID;
  String? cRPNAME;
  String? cRPTYPE;

  InterCrops(
      {this.cRPCODE, this.cRPYEAR, this.cRPFACTID, this.cRPNAME, this.cRPTYPE});

  InterCrops.fromJson(Map<String, dynamic> json) {
    cRPCODE = json['CRP_CODE'];
    cRPYEAR = json['CRP_YEAR'];
    cRPFACTID = json['CRP_FACTID'];
    cRPNAME = json['CRP_NAME'];
    cRPTYPE = json['CRP_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CRP_CODE'] = this.cRPCODE;
    data['CRP_YEAR'] = this.cRPYEAR;
    data['CRP_FACTID'] = this.cRPFACTID;
    data['CRP_NAME'] = this.cRPNAME;
    data['CRP_TYPE'] = this.cRPTYPE;
    return data;
  }
}

class Nursery {
  int? fACTID;
  String? year;
  int? id;
  String? nAME;

  Nursery({this.fACTID, this.year, this.id, this.nAME});

  Nursery.fromJson(Map<String, dynamic> json) {
    fACTID = json['FACT_ID'];
    year = json['year'];
    id = json['id'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FACT_ID'] = this.fACTID;
    data['year'] = this.year;
    data['id'] = this.id;
    data['NAME'] = this.nAME;
    return data;
  }
}

class IrrigationSource {
  int? id;
  String? nAME;

  IrrigationSource({this.id, this.nAME});

  IrrigationSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NAME'] = this.nAME;
    return data;
  }
}

class AgriItems {
  int? id;
  String? nAME;
  String? unit;

  AgriItems({this.id, this.nAME, this.unit});

  AgriItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nAME = json['NAME'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NAME'] = this.nAME;
    data['unit'] = this.unit;
    return data;
  }
}

class AgriSource {
  int? id;
  String? nAME;

  AgriSource({this.id, this.nAME});

  AgriSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NAME'] = this.nAME;
    return data;
  }
}

class AgriUnit {
  int? id;
  String? nAME;

  AgriUnit({this.id, this.nAME});

  AgriUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NAME'] = this.nAME;
    return data;
  }
}

class Season {
  String? seasonName;
  int? id;
  String? sYEAR;

  Season({this.seasonName, this.id, this.sYEAR});

  Season.fromJson(Map<String, dynamic> json) {
    seasonName = json['season_name'];
    id = json['id'];
    sYEAR = json['S_YEAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season_name'] = this.seasonName;
    data['id'] = this.id;
    data['S_YEAR'] = this.sYEAR;
    return data;
  }
}

class NurserySeedSources {
  int? id;
  String? seedSource;
  String? year;
  String? type;

  NurserySeedSources({this.id, this.seedSource, this.year, this.type});

  NurserySeedSources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seedSource = json['seed_source'];
    year = json['year'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seed_source'] = this.seedSource;
    data['year'] = this.year;
    data['type'] = this.type;
    return data;
  }
}

class AtspServices {
  List<LandPreparation>? landPreparation;
  List<PlotActivities>? plotActivities;

  AtspServices({this.landPreparation, this.plotActivities});

  AtspServices.fromJson(Map<String, dynamic> json) {
    if (json['land_preparation'] != null) {
      landPreparation = <LandPreparation>[];
      json['land_preparation'].forEach((v) {
        landPreparation!.add(new LandPreparation.fromJson(v));
      });
    }
    if (json['plot_activities'] != null) {
      plotActivities = <PlotActivities>[];
      json['plot_activities'].forEach((v) {
        plotActivities!.add(new PlotActivities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.landPreparation != null) {
      data['land_preparation'] =
          this.landPreparation!.map((v) => v.toJson()).toList();
    }
    if (this.plotActivities != null) {
      data['plot_activities'] =
          this.plotActivities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LandPreparation {
  int? id;
  String? serviceType;
  String? serviceName;

  LandPreparation({this.id, this.serviceType, this.serviceName});

  LandPreparation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceType = json['service_type'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_type'] = this.serviceType;
    data['service_name'] = this.serviceName;
    return data;
  }
}

class PlotActivities {
  int? id;
  String? serviceType;
  String? serviceName;

  PlotActivities({this.id, this.serviceType, this.serviceName});

  PlotActivities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceType = json['service_type'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_type'] = this.serviceType;
    data['service_name'] = this.serviceName;
    return data;
  }
}

class MasterSuggestions {
  int? id;
  String? suggestions;

  MasterSuggestions({this.id, this.suggestions});

  MasterSuggestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suggestions = json['suggestions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suggestions'] = this.suggestions;
    return data;
  }
}

class MasterTodos {
  int? id;
  String? todo;

  MasterTodos({this.id, this.todo});

  MasterTodos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['todo'] = this.todo;
    return data;
  }
}
