import 'package:flutter/material.dart';
import 'package:natife_weather/gen/assets.gen.dart';
import 'package:natife_weather/gen/colors.gen.dart';
import 'package:natife_weather/models/location_data.dart';
import 'package:natife_weather/models/geolocation_data.dart';
import 'package:natife_weather/network/network_manager.dart';
import 'package:natife_weather/widgets/buttons/plane_image_button.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController searchController = TextEditingController();
  List<LocationData> searchResponse = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: searchResponse.length,
          itemBuilder: (BuildContext context, int index) {
            String state = searchResponse[index].state != null
                ? ' ${searchResponse[index].state},'
                : '';
            return InkWell(
              onTap: () => transferData(index),
              child: ListTile(
                title: Text(
                    "${searchResponse[index].city},$state ${searchResponse[index].country}"),
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() => AppBar(
        backgroundColor: ColorName.blue,
        elevation: 0,
        titleSpacing: 0,
        leading: PlaneImageButton(
          size: 25,
          assetImage: Assets.images.vector.back.path,
          onPressedCallback: () => Navigator.pop(context),
        ),
        title: isSearching
            ? searchTextField()
            : const Center(child: Text("Search Location")),
        actions: <Widget>[
          PlaneImageButton(
            size: 60,
            assetImage: isSearching
                ? Assets.images.vector.close.path
                : Assets.images.vector.search.path,
            onPressedCallback: () {
              setState(() {
                isSearching = !isSearching;
                if (searchResponse.isNotEmpty) {
                  searchController.clear();
                  searchResponse.clear();
                }
              });
            },
          ),
        ],
      );

  Widget searchTextField() {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: TextField(
        autofocus: true,
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorName.light,
          contentPadding: const EdgeInsets.all(0),
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    setState(() => searchResponse.clear());
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorName.light),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorName.light),
          ),
        ),
        onChanged: (request) {
          setState(() {
            if (request.isNotEmpty) {
              NetworkManager.findLocation(request).then((locations) {
                setState(() => searchResponse = locations);
              });
            } else {
              searchResponse.clear();
            }
          });
        },
      ),
    );
  }

  void transferData(int index) {
    final geolocationData = GeolocationData(
      cityName: searchResponse[index].city,
      latitude: searchResponse[index].latitude.toString(),
      longitude: searchResponse[index].longitude.toString(),
    );
    Navigator.pop(context, geolocationData);
  }
}
