import 'package:cane_survey/screens/add_partition.dart';
import 'package:cane_survey/screens/final_form.dart';
import 'package:flutter/material.dart';

class PartitionScreen extends StatefulWidget {
  // final List<Map<String, dynamic>>? areaData;
  final Map<String, dynamic>? surveyData;

  PartitionScreen({this.surveyData});

  @override
  State<PartitionScreen> createState() => _PartitionScreenState();
}

class _PartitionScreenState extends State<PartitionScreen> {
  List<String> partion = ['No partition', '2', '3'];
  String? selectedPartion;
  final TextEditingController _inputPartition = TextEditingController();
  List<Map<String, dynamic>>? areaData;
  double totalArea = 0.0;

  @override
  void initState() {
    super.initState();
    _inputPartition.text = "";

    selectedPartion = partion[0];
    totalArea = widget.surveyData!["total_area"];

    print(widget.surveyData);
    print(totalArea);
  }

  @override
  Widget build(BuildContext context) {
    // final areaData = widget.areaData;
    Map<String, dynamic> surveyData = widget.surveyData ?? {};

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "New Survey(2)",
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
                    child: totalArea == 0.00000
                        ? const Center(
                            child: Text(
                              "Total area can not be 0.0",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                DropdownButtonFormField<String>(
                                  value: selectedPartion,
                                  items: partion.map((partion) {
                                    return DropdownMenuItem<String>(
                                      value: partion,
                                      child: Text(partion),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedPartion = newValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Numner of Partion",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                if (selectedPartion != "No partition")
                                  Row(children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _inputPartition,
                                        decoration: const InputDecoration(
                                          labelText: "Your Share Area (%)",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  const Color.fromARGB(
                                                      255, 146, 214, 148))),
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AreaScreen(
                                                      balanceArea: double.parse(
                                                          _inputPartition
                                                              .value.text
                                                              .trim()),
                                                      surveyData: surveyData,
                                                    )));

                                        if (result != null) {
                                          setState(() {
                                            areaData = result;
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Add Partition",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                SizedBox(height: 20),
                                if (areaData != null && areaData != " ") ...[
                                  const Text(
                                    "Partition:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: areaData!.length,
                                    itemBuilder: (context, index) {
                                      final areadata = areaData![index];
                                      return Card(
                                          elevation: 3,
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //   "Village: ${areadata['village']}",
                                                  //   style: const TextStyle(
                                                  //       fontSize: 18,
                                                  //       fontWeight: FontWeight.bold),
                                                  // ),
                                                  // SizedBox(height: 4),
                                                  // Text(
                                                  //   "Village code: ${areadata['villageCode']}",
                                                  //   style: const TextStyle(
                                                  //       fontSize: 18,
                                                  //       fontWeight: FontWeight.bold),
                                                  // ),
                                                  // SizedBox(height: 4),
                                                  // Text(
                                                  //   "Grower: ${areadata['grower']}",
                                                  //   style: const TextStyle(
                                                  //       fontSize: 18,
                                                  //       fontWeight: FontWeight.bold),
                                                  // ),
                                                  // SizedBox(height: 4),
                                                  // Text(
                                                  //   "Grower code: ${areadata['growerCode']}",
                                                  //   style: const TextStyle(
                                                  //       fontSize: 18,
                                                  //       fontWeight: FontWeight.bold),
                                                  // ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    "Area:  ${areadata['area']} %",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    "Total Area:  ${areadata['totalArea']} hectre",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )));
                                    },
                                  ),
                                ],
                                const SizedBox(
                                  height: 8,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 146, 214, 148))),
                                    onPressed: () {
                                      surveyData['no_of_partition'] =
                                          selectedPartion;
                                      surveyData['share_area'] = areaData;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AgricultureFormScreen(
                                                    surveyData: surveyData,
                                                  )));
                                    },
                                    child: Text(
                                      "Next",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ])))));
  }
}
