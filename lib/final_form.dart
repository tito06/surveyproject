import 'package:cane_survey/final_check_survey_data.dart';
import 'package:cane_survey/survey_viewmodel.dart';
import 'package:flutter/material.dart';

class AgricultureFormScreen extends StatefulWidget {
  final Map<String, dynamic>? surveyData;

  AgricultureFormScreen({this.surveyData});

  @override
  _AgricultureFormScreenState createState() => _AgricultureFormScreenState();
}

class _AgricultureFormScreenState extends State<AgricultureFormScreen> {
  final SurveyViewmodel _surveyViewmodel = SurveyViewmodel();

  // Dummy data for dropdowns
  final List<String> _dummyOptions = ["Option 1", "Option 2", "Option 3"];
  final List<String> _vehicleType = ["Owner", "Rent"];
  final List<String> _agriImplement = ["Owner", "Rent"];

  // Form controllers and state variables
  List<Map<String, String>> variety = [];
  List<Map<String, String>> landType = [];
  List<Map<String, String>> pest = [];
  List<Map<String, String>> irrigation = [];
  List<Map<String, String>> interCrop = [];
  List<Map<String, String>> seedSource = [];
  List<Map<String, String>> nursery = [];
  List<Map<String, String>> plantingType = [];

  String selectedVarietyCode = "";
  String selectedLandTypeCode = "";
  String selectedPestCode = "";
  String selectedIrrigationCode = "";
  String selectedInterCropCode = "";
  String selectedSeedSourceCode = "";
  String selectedNurseryCode = "";
  String selectedPlantingCode = "";
  String selectedVehicleCode = "";
  String selectedAgriImplementCode = "";

  String? selectedVariety;
  String? selectedLandtypes;
  String? selectedPestType;
  String? selectedIrrigationType;
  String? selectedImterCropType;
  String? selectedSeedSourceType;
  String? selectedNurseryType;
  String? selectedPlantingType;

  String? cropCycle;
  String? qualityType;
  String? interCropType;
  String? seedSourceType;
  String? irrigationType;
  String? diseaseType;
  String? plantationType;
  String? vehicleSource;
  String? agriImplement;
  String? lastYearCropCycle;
  TextEditingController remarkController = TextEditingController();

  // Loading state
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchMasterData();
  }

  Future<void> _fetchMasterData() async {
    Map<String, String> requestDataForVillage = {"mill_id": "203"};
    try {
      final items = await _surveyViewmodel.fetchMaster(requestDataForVillage);
      setState(() {
        pest = items['pests'] ?? [];
        variety = items['variety'] ?? [];
        landType = items['land_types'] ?? [];
        irrigation = items['irrigation_source'] ?? [];
        interCrop = items['inter_crops'] ?? [];
        seedSource = items['seed_sources'] ?? [];
        nursery = items['nursery'] ?? [];
        plantingType = items['planting_methods'] ?? [];

        selectedVarietyCode = variety.isNotEmpty ? variety[0]['VR_CODE']! : "-";
        selectedLandTypeCode = landType.isNotEmpty ? landType[0]['id']! : "-";

        isLoading = false;
      });
    } catch (e) {
      print("Error fetching variety name: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initial surveyData from the previous screen (if any)
    Map<String, dynamic> surveyData = widget.surveyData ?? {};
    print(surveyData);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Survey(3)"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgm.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.85),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Row 1

            if (isLoading) // Show the loader while fetching village data
              Center(child: CircularProgressIndicator()),
            if (!isLoading) ...[
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                        "Variety",
                        variety
                            .map((variety) =>
                                "${variety['VR_CODE']} / ${variety['VR_NAME']}")
                            .toList(),
                        selectedVarietyCode, (String? newValue) {
                      setState(() {
                        selectedVarietyCode =
                            newValue != null ? newValue.split(' / ')[0] : '';
                        selectedVariety =
                            newValue != null ? newValue.split('/')[1] : "";
                      });
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildTextField("Category", onChanged: (value) {
                      surveyData['category'] = value;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Row 2
              Row(
                children: [
                  Expanded(
                    child: buildDropdown("Crop Cycle", (value) {
                      setState(() {
                        cropCycle = value;
                        surveyData['cropCycle'] =
                            cropCycle; // Add to surveyData
                      });
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildTextField("After Wheat", onChanged: (value) {
                      surveyData['afterWheat'] = value;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Single Dropdowns
              buildDropdown("Quality Type", (value) {
                setState(() {
                  qualityType = value;
                  surveyData['qualityType'] = qualityType; // Add to surveyData
                });
              }),
              const SizedBox(height: 16),
              _buildDropdownField(
                  "Inter Crop Type",
                  interCrop
                      .map((interCrop) => "${interCrop['CRP_NAME']}")
                      .toList(),
                  selectedInterCropCode, (String? newValue) {
                setState(() {
                  selectedImterCropType = newValue ?? "";
                  surveyData['inter_crop_type'] = selectedImterCropType;
                });
              }),
              const SizedBox(height: 16),
              _buildDropdownField(
                  "Seed Source Type",
                  seedSource
                      .map((seedSource) => "${seedSource['seed_source']}")
                      .toList(),
                  selectedSeedSourceCode, (String? newValue) {
                setState(() {
                  selectedSeedSourceType = newValue ?? "";
                  surveyData['seed_type'] = selectedSeedSourceType;
                });
              }),
              const SizedBox(height: 16),

              // Row 3
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                        "Irrigation Type",
                        irrigation
                            .map((irrigation) => "${irrigation['NAME']}")
                            .toList(),
                        selectedIrrigationCode, (String? newValue) {
                      setState(() {
                        selectedIrrigationType = newValue ?? "";
                        surveyData['irrigation_type'] = selectedIrrigationType;
                      });
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                        "Land Type",
                        landType
                            .map((landType) => "${landType['land_type']}")
                            .toList(),
                        selectedLandTypeCode, (String? newValue) {
                      setState(() {
                        selectedLandtypes = newValue ?? "";
                        surveyData['land_type'] = selectedLandtypes;
                      });
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Single Dropdowns
              _buildDropdownField(
                  "Pest",
                  pest.map((pest) => "${pest['pest_name']}").toList(),
                  selectedPestCode, (String? newValue) {
                setState(() {
                  selectedPestType = newValue ?? "";
                  surveyData['pest_type'] = selectedPestType;
                });
              }),
              const SizedBox(height: 16),
              buildDropdown("Disease Type", (value) {
                setState(() {
                  diseaseType = value;
                  surveyData['diseaseType'] = diseaseType; // Add to surveyData
                });
              }),
              const SizedBox(height: 16),
              _buildDropdownField(
                  "Plantation Type",
                  plantingType
                      .map((plantyingType) =>
                          "${plantyingType['planting_name']}")
                      .toList(),
                  selectedPlantingCode, (String? newValue) {
                setState(() {
                  selectedPlantingType = newValue ?? "";
                  surveyData['planting_type'] = selectedPlantingType;
                });
              }),
              const SizedBox(height: 16),

              _buildDropdownField(
                  "Nursery Type",
                  nursery.map((nursery) => "${nursery['NAME']}").toList(),
                  selectedNurseryCode, (String? newValue) {
                setState(() {
                  selectedNurseryType = newValue ?? "";
                  surveyData['nursery_type'] = selectedNurseryType;
                });
              }),

              const SizedBox(height: 16),

              // Row 4
              Row(
                children: [
                  Expanded(
                      child: _buildDropdownField(
                          "Vehicle Source", _vehicleType, selectedVehicleCode,
                          (String? newValue) {
                    setState(() {
                      selectedVehicleCode = newValue ?? "";
                      surveyData['vehicleSource'] = selectedVehicleCode;
                    });
                  })),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildDropdownField(
                          "Agri Implement",
                          _agriImplement,
                          selectedAgriImplementCode, (String? newValue) {
                    setState(() {
                      selectedAgriImplementCode = newValue ?? "";
                      surveyData['agri_implementation'] =
                          selectedAgriImplementCode;
                    });
                  })),
                ],
              ),
              const SizedBox(height: 16),

              // Single Dropdown and Remarks
              buildDropdown("Last Year Crop Cycle", (value) {
                setState(() {
                  lastYearCropCycle = value;
                  surveyData['lastYearCropCycle'] =
                      lastYearCropCycle; // Add to surveyData
                });
              }),
              const SizedBox(height: 16),
              buildTextField(
                "Remark",
                maxLength: 20,
                controller: remarkController,
                onChanged: (value) {
                  surveyData['remark'] = value; // Add to surveyData
                },
              ),
              const SizedBox(height: 16),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to SurveyDataScreen and pass the surveyData
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SurveyDataScreen(surveyData: surveyData),
                        ),
                      );
                    },
                    child: const Text("Submit"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Cancel logic
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ]),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          items: _dummyOptions
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String selectedValue, ValueChanged<String?> onChanged) {
    if (!items.contains(selectedValue)) {
      selectedValue =
          items.isNotEmpty ? items[0] : ""; // Set to first item or default
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: null,
          hint: Text("Select Option"),
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildTextField(String label,
      {int? maxLength,
      TextEditingController? controller,
      ValueChanged<String>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLength: maxLength,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
