import 'dart:ffi';

import 'package:cane_survey/shared_pref_helper.dart';
import 'package:cane_survey/view_models/survey_viewmodel.dart';
import 'package:flutter/material.dart';

class AreaScreen extends StatefulWidget {
  final double balanceArea;
  final Map<String, dynamic>? surveyData;

  AreaScreen({required this.balanceArea, required this.surveyData});

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  // List to hold added data
  final SurveyViewmodel _surveyViewmodel = SurveyViewmodel();

  final List<Map<String, dynamic>> _areaData = [];
  final List<Map<String, dynamic>> _areaDataF = [];

  // Controllers for dialog form
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _growerController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  bool _isUnknownGrower = false;
  double totalArea = 0.0;
  double remainingAreaInHectre = 0.0;
  double balAreaPercent = 0;
  bool onPress = false;

  List<Map<String, String>> growerData = [];
  String selectedGrowerCode = "";
  String? selectedGrower;
  bool isGrowerLoading = true;
  String? token;
  String? villName;
  String? millId;

  Future<void> _initializeData() async {
    await _loadToken();

    //await _fetchGrowerName();
  }

  Future<void> _loadToken() async {
    final authtoken = await SharedPrefHelper.getToken();
    final villageName = await SharedPrefHelper.getVillageName();
    final authMillId = await SharedPrefHelper.getMillId();
    setState(() {
      token = authtoken;
      villName = villageName;
      millId = authMillId;
    });
  }

  Future<void> _fetchGrowerName(String villId) async {
    Map<String, String> requestDataForGrower = {
      "mill_id": "$millId",
      "village_id": villId
    };
    try {
      // Call the API
      final items =
          await _surveyViewmodel.fetchGrowers(token, requestDataForGrower);
      setState(() {
        growerData = items;
        selectedGrowerCode =
            (growerData.isNotEmpty ? growerData[0]['G_CODE'] : "-")!;
        isGrowerLoading = false;
      });
    } catch (e) {
      print("Error fetching grower name: $e");
      setState(() {
        growerData = [];
        isGrowerLoading = false;
      });
    }
  }

  void _showAddDialog(String villageCode, double totalArea) async {
    setState(() {
      isGrowerLoading = true;
    });
    await _fetchGrowerName(villageCode);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Area Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Village: $villName",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Grower:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                isGrowerLoading
                    ? Center(child: CircularProgressIndicator())
                    : DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: null,
                        hint: Text("Select Option"),
                        isExpanded: true,
                        items: growerData
                            .map((grower) =>
                                "${grower['G_CODE']} / ${grower['G_NAME']}")
                            .toList()
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGrowerCode = newValue != null
                                ? newValue.split(' / ')[0]
                                : '';
                            selectedGrower =
                                newValue != null ? newValue.split('/')[1] : "";
                          });
                        },
                      ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _isUnknownGrower,
                      onChanged: (bool? value) {
                        setState(() {
                          _isUnknownGrower = value!;
                        });
                      },
                    ),
                    Text("Unknown Grower"),
                  ],
                ),
                TextField(
                  controller: _areaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Area %",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final double totalAreas = double.parse(_areaController.text);
                remainingAreaInHectre = (totalAreas / 100) * totalArea;

                onPress = true;
                _addAreaData(villageCode, selectedGrower, selectedGrowerCode,
                    totalAreas, remainingAreaInHectre);
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _addAreaData(String? villageCode, String? grower, String? growerCode,
      double area, double? totalArea) {
    setState(() {
      _areaData.add({
        'villageCode': villageCode,
        'growerCode': growerCode,
        'area': area ?? 0.0,
        'totalArea': remainingAreaInHectre
      });

      _areaDataF.add({
        'share_area_percent': area ?? 0.0,
      });

      if (onPress == true) {
        _recalculateRemainingArea(area);
      }
      // Clear form after adding
      _villageController.clear();
      _growerController.clear();
      _areaController.clear();
      _isUnknownGrower = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // _initializeData();
    _loadToken();
    balAreaPercent = 100 - widget.balanceArea;
  }

  void _recalculateRemainingArea(double areaPercent) {
    setState(() {
      balAreaPercent = balAreaPercent - areaPercent;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalArea = _areaData.fold(0.0, (sum, item) => sum + item['area']);
    Map<String, dynamic> surveyData = widget.surveyData ?? {};

    //totalArea = double.parse(surveyData["area"]);
    if (surveyData["area"] != null && surveyData["area"] is String) {
      totalArea = double.tryParse(surveyData["area"]) ?? 0.0;
    } else if (surveyData["area"] != null && surveyData["area"] is double) {
      totalArea = surveyData["area"];
    }

    if (!onPress)
      remainingAreaInHectre = (widget.balanceArea / 100) * totalArea;

    if (_areaData.isEmpty) {
      _addAreaData(surveyData["villageCode"], surveyData["grower"],
          surveyData["growerCode"], widget.balanceArea, remainingAreaInHectre);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Area Management"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/bgm.png'), // Add your background image path
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.85), // Make it light and subtle
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balance Area: ${balAreaPercent} %",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Total Area: ${totalArea} Hect",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (balAreaPercent != 0.0)
                  ElevatedButton(
                    onPressed: () {
                      _showAddDialog(surveyData["village_code"], totalArea);
                    },
                    child: Text("Add Partition"),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _areaDataF);
                    },
                    child: Text("Submit"),
                  ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: _areaData.length,
                    itemBuilder: (context, index) {
                      final item = _areaData[index];
                      return Card(
                          elevation: 3,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "Village: ${item['village']}",
                                  //   style: const TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   "Village code: ${item['villageCode']}",
                                  //   style: const TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   "Grower: ${item['grower']}",
                                  //   style: const TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  // SizedBox(height: 4),
                                  // Text(
                                  //   "Grower code: ${item['growerCode']}",
                                  //   style: const TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  // SizedBox(height: 4),
                                  Text(
                                    "Area:  ${item['area']} %",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Total Area:  ${item['totalArea']} hectre",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
