import 'package:cane_survey/location_screen.dart';
import 'package:cane_survey/screens/partition.dart';
import 'package:cane_survey/shared_pref_helper.dart';
import 'package:cane_survey/view_models/survey_viewmodel.dart';
import 'package:flutter/material.dart';

class InputFormScreen extends StatefulWidget {
  // final List<Map<String, dynamic>>? coordinates;

  // InputFormScreen({this.coordinates});

  @override
  _InputFormScreenState createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final SurveyViewmodel _surveyViewmodel = SurveyViewmodel();

  // Controllers for the input fields
  final TextEditingController _inputController1 = TextEditingController();
  final TextEditingController _inputController2 = TextEditingController();
  final TextEditingController _inputController3 = TextEditingController();

  // Dummy data for dropdowns

  List<Map<String, String>> villageData = [];
  String selectedVillageCode = "";
  bool isVillageLoading = true;
  List<Map<String, String>> growerData = [];
  String selectedGrowerCode = "";
  bool isGrowerLoading = false;

  String? selectedVillage;
  String? selectedGrower;
  bool isUnknownGrower = false;
  String? selectedPartion;
  List<Map<String, dynamic>>? coordinates;
  String? token;
  String? millId;
  double _area = 0.0;
  double? lat_1, lat_2, lat_3, lat_4, long_1, long_2, long_3, long_4;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _inputController1.text = "";
    _inputController2.text = "";
  }

  Future<void> _initializeData() async {
    await _loadToken();

    await _fetchVillageName();
  }

  Future<void> _loadToken() async {
    final authtoken = await SharedPrefHelper.getToken();
    final authmillId = await SharedPrefHelper.getMillId();

    setState(() {
      token = authtoken ?? "";
      millId = authmillId;
    });
  }

  Future<void> _fetchVillageName() async {
    Map<String, String> requestDataForVillage = {"mill_id": "$millId"};
    try {
      final items =
          await _surveyViewmodel.fetchVillages(token, requestDataForVillage);
      setState(() {
        villageData = items;
        selectedVillageCode =
            villageData.isNotEmpty ? villageData[0]['V_CODE']! : "-";

        isVillageLoading = false;
      });
    } catch (e) {
      print("Error fetching village name: $e");
      setState(() {
        isVillageLoading = false;
      });
    }
  }

  Future<void> _fetchGrowerName(String villId) async {
    Map<String, String> requestDataForGrower = {
      "mill_id": "$millId",
      "village_id": villId
    };
    setState(() {
      isGrowerLoading = true; // Show loading indicator while fetching data
    });

    try {
      final items =
          await _surveyViewmodel.fetchGrowers(token, requestDataForGrower);

      setState(() {
        growerData = items;
        isGrowerLoading = false; // Stop loading after data is fetched

        if (growerData.isNotEmpty) {
          selectedGrowerCode = growerData[0]['G_CODE']!;
          selectedGrower = growerData[0]['G_NAME']!;
        } else {
          selectedGrowerCode = "No Grower Found";
          selectedGrower = "";
        }
      });
    } catch (e) {
      print("Error fetching grower name: $e");
      setState(() {
        selectedGrowerCode = "Error fetching data";
        selectedGrower = "";
        isGrowerLoading = false;
      });
    }
  }

  void _handleSet() {
    // Handle the 'Set' button action
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Settings Applied"),
          content: Text(
              "Village: $selectedVillage\nGrower: $selectedGrower\nUnknown Grower: $isUnknownGrower"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void processData(List<Map<String, dynamic>>? data) {
    for (int i = 0; i < data!.length && i < 4; i++) {
      switch (i) {
        case 0:
          lat_1 = data[i]['latitude'];
          long_1 = data[i]['longitude'];
          continue;
        case 1:
          lat_2 = data[i]['latitude'];
          long_2 = data[i]['longitude'];
          continue;
        case 2:
          lat_3 = data[i]['latitude'];
          long_3 = data[i]['longitude'];
          continue;
        case 3:
          lat_4 = data[i]['latitude'];
          long_4 = data[i]['longitude'];
          break;
      }
    }
  }

  void _surveyData() {
    // Collect the data into a JSON object
    Map<String, dynamic> surveyData = {
      'mill_id': '$millId',
      'plot_no': _inputController1.text,
      'plot_serial_no': _inputController2.text,
      'village_code': selectedVillageCode,
      'grower_code': (isUnknownGrower ? "" : selectedGrowerCode),
      'lat_1': lat_1,
      'long_1': long_1,
      'lat_2': lat_2,
      'long_2': long_2,
      'lat_3': lat_3,
      'long_3': long_3,
      'lat_4': lat_4,
      'long_4': long_4,
      'total_area': _area, // You can update with the actual area input
    };

    // Pass the JSON object to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartitionScreen(
            surveyData: surveyData), // Passing data to the next screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "New Survey(1)",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                  'assets/bgm.png'), // Add your background image path
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.85), // Make it light and subtle
                BlendMode.dstATop,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isVillageLoading) // Show the loader while fetching village data
                      const Center(child: CircularProgressIndicator()),
                    if (!isVillageLoading) ...[
                      // Row containing first two input boxes and "Set" button

                      Row(
                        children: [
                          Expanded(
                            child: buildTextFieldPlot(
                                "Plot No.", _inputController1),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildTextFieldPlot(
                                "Plot Seriel", _inputController2),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 146, 214, 148),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            onPressed: _handleSet,
                            child: const Text(
                              "Set",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildDropdownField(
                          "Select Village",
                          villageData
                              .map((village) =>
                                  "${village['V_CODE']} / ${village['V_NAME']}")
                              .toList(),
                          selectedVillageCode, (String? newValue) async {
                        setState(() {
                          selectedVillageCode =
                              newValue != null ? newValue.split(' / ')[0] : '';
                          selectedVillage =
                              newValue != null ? newValue.split('/')[1] : "";
                          growerData = [];
                          isGrowerLoading = true;
                        });
                        //svae here

                        if (selectedVillage != null &&
                            selectedVillage!.isNotEmpty) {
                          await SharedPrefHelper.saveVillageName(
                              selectedVillage!);
                        }
                        try {
                          isGrowerLoading = true;
                          _fetchGrowerName(selectedVillageCode);
                        } catch (e) {}
                      }),

                      const SizedBox(height: 20),

                      if (isGrowerLoading) // Show the loader while fetching village data
                        const Center(child: CircularProgressIndicator()),

                      if (isGrowerLoading) ...[
                        Center(), // Show loading indicator
                      ] else if (growerData.isEmpty) ...[
                        const Center(
                          child: Text(
                            "No Grower Data Available",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ] else ...[
                        _buildDropdownField(
                          "Select Growers",
                          growerData
                              .map((grower) =>
                                  "${grower['G_CODE']} / ${grower['G_NAME']}")
                              .toList(),
                          selectedGrowerCode,
                          (String? newValue) {
                            setState(() {
                              selectedGrowerCode = newValue != null
                                  ? newValue.split(' / ')[0]
                                  : '';
                              selectedGrower = newValue != null
                                  ? newValue.split(' / ')[1].trim()
                                  : "";
                            });
                          },
                        )
                      ],

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isUnknownGrower,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isUnknownGrower = newValue!;
                                if (isUnknownGrower == true) {
                                  growerData = [];
                                }
                              });
                            },
                          ),
                          const Text("Unknown Grower"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Conditionally Render Coordinates
                      if (coordinates != null && coordinates != " ") ...[
                        const Text("Coordinates"),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: coordinates!.length,
                          itemBuilder: (context, index) {
                            final coord = coordinates![index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                    "Lat: ${coord['latitude']}, Lng: ${coord['longitude']}"),
                                subtitle:
                                    Text("Distance: ${coord['distance']} m"),
                              ),
                            );
                          },
                        ),
                        // SizedBox(height: 8),
                        buildTextField("Area", _inputController3,
                            _area.toStringAsFixed(5)),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 146, 214, 148))),
                            onPressed: _surveyData,
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ] else ...[
                        const Center(
                          child: Text(
                            "No coordinates added yet.",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 146, 214, 148))),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LocationTrackingScreen()));

                              if (result != null) {
                                setState(() {
                                  coordinates = result["coordinate"];
                                  _area = result["area"];
                                  processData(coordinates);
                                });
                              }
                            },
                            child: const Text(
                              "Add Coordinate",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ]),
            ),
          ),
        ));
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

  Widget buildTextField(
      String label, TextEditingController? controller, String? area) {
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
          decoration: InputDecoration(
            hintText: "${_area.toStringAsFixed(5)}",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldPlot(String label, TextEditingController? controller) {
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
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
