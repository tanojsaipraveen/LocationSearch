import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locationsearch/Models/NearbyModel.dart';

class NearbyPlacesWidget extends StatelessWidget {
  const NearbyPlacesWidget({
    Key? key,
    required this.future,
  }) : super(key: key);

  final Future<NearbyModel> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.data.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.data!.data[index].name != null) {
                return Card(
                  elevation: 4,
                  child: Container(
                    width: 170,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image(
                              image: NetworkImage(snapshot
                                  .data!.data[index].photo!.images!.medium!.url
                                  .toString()),
                              alignment: Alignment.center,
                              height: 150,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data!.data[index].name.toString() ??
                                    "text",
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                        child: Image.asset(
                                            'assets/images/star1.png'),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(snapshot.data!.data[index].rating
                                          .toString()),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        } else if (snapshot.hasError) {
          return const Text("error");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Text("");
        }
      },
    );
  }
}
