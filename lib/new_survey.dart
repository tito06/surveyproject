import 'package:cane_survey/location_screen.dart';
import 'package:cane_survey/partition.dart';
import 'package:cane_survey/survey_viewmodel.dart';
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

  @override
  void initState() {
    super.initState();
    // Set some default values for inputs
    _fetchVillageName();
    _inputController1.text = "";
    _inputController2.text = "";
  }

  Future<void> _fetchVillageName() async {
    Map<String, String> requestDataForVillage = {"mill_id": "203"};
    try {
      final items = await _surveyViewmodel.fetchVillages(requestDataForVillage);
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
      "mill_id": "203",
      "village_id": villId
    };
    try {
      final items = await _surveyViewmodel.fetchGrowers(requestDataForGrower);
      setState(() {
        growerData = items;
        selectedGrowerCode =
            growerData.isNotEmpty ? growerData[0]['G_CODE']! : "-";

        isGrowerLoading = false;
      });
    } catch (e) {
      print("Error fetching village name: $e");
      setState(() {
        isVillageLoading = false;
      });
    }
  }

  void _handleSet() {
    // Handle the 'Set' button action
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Settings Applied"),
          content: Text(
              "Village: $selectedVillage\nGrower: $selectedGrower\nUnknown Grower: $isUnknownGrower"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _surveyData() {
    // Collect the data into a JSON object
    Map<String, dynamic> surveyData = {
      'plot_no': _inputController1.text,
      'plot_serial': _inputController2.text,
      'village': selectedVillage,
      'villageCode': selectedVillageCode,
      'growerCode': (isUnknownGrower ? "" : selectedGrowerCode),
      'grower': (isUnknownGrower ? "Unknown Grower" : selectedGrower),
      'coordinates': coordinates,
      'area':
          _inputController1.text, // You can update with the actual area input
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
                      Center(child: CircularProgressIndicator()),
                    if (!isVillageLoading) ...[
                      // Row containing first two input boxes and "Set" button

                      Row(
                        children: [
                          Expanded(
                            child:
                                buildTextField("Plot No.", _inputController1),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildTextField(
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
                      SizedBox(height: 20),

                      _buildDropdownField(
                          "Select Village",
                          villageData
                              .map((village) =>
                                  "${village['V_CODE']} / ${village['V_NAME']}")
                              .toList(),
                          selectedVillageCode, (String? newValue) {
                        setState(() {
                          selectedVillageCode =
                              newValue != null ? newValue.split(' / ')[0] : '';
                          selectedVillage =
                              newValue != null ? newValue.split('/')[1] : "";
                          growerData = [];
                          isGrowerLoading = true;
                        });
                        try {
                          isGrowerLoading = true;
                          _fetchGrowerName(selectedVillageCode);
                        } catch (e) {}
                      }),

                      SizedBox(height: 20),

                      if (isGrowerLoading) // Show the loader while fetching village data
                        Center(child: CircularProgressIndicator()),
                      if (!isGrowerLoading) ...[
                        _buildDropdownField(
                            "Select Growers",
                            growerData
                                .map((grower) =>
                                    "${grower['G_CODE']} / ${grower['G_NAME']}")
                                .toList(),
                            selectedGrowerCode, (String? newValue) {
                          setState(() {
                            selectedGrowerCode = newValue != null
                                ? newValue.split(' / ')[0]
                                : '';
                            selectedGrower =
                                newValue != null ? newValue.split('/')[1] : "";
                          });
                        })
                      ],

                      SizedBox(height: 20),
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
                          Text("Unknown Grower"),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Conditionally Render Coordinates
                      if (coordinates != null && coordinates != " ") ...[
                        Text("Coordinates"),
                        SizedBox(height: 8),
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
                        buildTextField("Area", _inputController1),
                        SizedBox(height: 20),
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
                        SizedBox(height: 20),
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
                                  coordinates = result;
                                });
                              }
                            },
                            child: Text(
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

  Widget buildTextField(String label, TextEditingController? controller) {
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
