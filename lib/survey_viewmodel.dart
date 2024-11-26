import 'dart:convert';
import 'package:cane_survey/master_model.dart';
import 'package:http/http.dart' as http;

class SurveyViewmodel {
  final String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2NhbmVkZXYuYmlybGEtc3VnYXIuY29tL2FwaS9sb2dpbiIsImlhdCI6MTczMjEwMjcyOCwiZXhwIjoxNzMyNzA3NTI4LCJuYmYiOjE3MzIxMDI3MjgsImp0aSI6IkVmR2pJR2xPaDQ0S3hlTnAiLCJzdWIiOiIyMDIxIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.wDBhRF9xhP3sypm5b7Hb5ZDxs3POxY2YyAWd1s6vtqg";

  Future<List<Map<String, String>>> fetchVillages(
      Map<String, String> parameters) async {
    final response = await http.post(
      Uri.parse("https://canedev.birla-sugar.com/api/fetchVillage"),
      body: json.encode(parameters),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic> && data['data'] is List) {
        final villages = data['data'] as List;
        // Map the list to extract both village code and name
        return villages.map((village) {
          return {
            'V_CODE': village['V_CODE'].toString(),
            'V_NAME': village['V_NAME'].toString(),
          };
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  //Grower List

  Future<List<Map<String, String>>> fetchGrowers(
      Map<String, String> parameters) async {
    final response = await http.post(
      Uri.parse("https://canedev.birla-sugar.com/api/fetchGrower"),
      body: json.encode(parameters),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic> && data['data'] is List) {
        final growers = data['data'] as List;
        // Map the list to extract both village code and name
        return growers.map((grower) {
          return {
            'G_CODE': grower['G_CODE'].toString(),
            'G_NAME': grower['G_NAME'].toString().trim() +
                " " +
                '(' +
                grower['G_FATHER'].toString().trim() +
                ')',
          };
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  // api for variety
  Future<Map<String, List<Map<String, String>>>> fetchMaster(
      Map<String, String> parameters) async {
    try {
      final response = await http.post(
        Uri.parse("https://canedev.birla-sugar.com/api/fetchAllmaster"),
        body: json.encode(parameters),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse the response into MasterModel
        MasterModel masterModel = MasterModel.fromJson(data);

        // Prepare the lists for different fields
        Map<String, List<Map<String, String>>> result = {
          "pests": masterModel.data?.pests
                  ?.map((pest) => {
                        "id": pest.id.toString(),
                        "pest_name": pest.pestName ?? "",
                      })
                  .toList() ??
              [],
          "variety": masterModel.data?.variety
                  ?.map((variety) => {
                        "VR_CODE": variety.vRCODE.toString(),
                        "VR_NAME": variety.vRNAME ?? "",
                      })
                  .toList() ??
              [],
          "land_types": masterModel.data?.landTypes
                  ?.map((landType) => {
                        "id": landType.id.toString(),
                        "land_type": landType.landType.toString()
                      })
                  .toList() ??
              [],
          "irrigation_source": masterModel.data?.irrigationSource
                  ?.map((irrigation) => {
                        "id": irrigation.id.toString(),
                        "NAME": irrigation.nAME.toString()
                      })
                  .toList() ??
              [],

          "inter_crops": masterModel.data?.interCrops
                  ?.map((interCrops) => {
                        "CRP_CODE": interCrops.cRPCODE.toString(),
                        "CRP_NAME": interCrops.cRPNAME.toString()
                      })
                  .toList() ??
              [],

          "seed_sources": masterModel.data?.seedSources
                  ?.map((seedSources) => {
                        "id": seedSources.id.toString(),
                        "seed_source": seedSources.seedSource.toString()
                      })
                  .toList() ??
              [],
          "nursery": masterModel.data?.nursery
                  ?.map((nursery) => {
                        "id": nursery.id.toString(),
                        "NAME": nursery.nAME.toString()
                      })
                  .toList() ??
              [],
          "planting_methods": masterModel.data?.plantingMethods
                  ?.map((plantingMethods) => {
                        "id": plantingMethods.id.toString(),
                        "planting_name": plantingMethods.plantingName.toString()
                      })
                  .toList() ??
              [],
          // Add similar mappings for other fields as needed
        };

        return result;
      } else {
        throw Exception(
            "Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("An error occurred: $error");
    }
  }
}