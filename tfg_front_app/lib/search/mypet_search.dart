

import 'package:flutter/material.dart';

import '../models/pet_model.dart';

class PetSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar mascota';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return CircularProgressIndicator();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        child: const Center(
            child: Icon(Icons.search, color: Colors.black38, size: 100)),
      );
    } else {
      return CircularProgressIndicator();
      // return FutureBuilder(
      //   future: PetService.getMyPets(),
      //   builder: (BuildContext context, AsyncSnapshot<List<Pet>> snapshot) {
      //     if (snapshot.hasData) {
      //       List<Pet> petList = snapshot.data!;

      //       return ListView.builder(
      //         itemCount: petList.length,
      //         itemBuilder: (_, int index) {
      //           return _SuggestionItem(petList[index]);
      //         },
      //       );
      //     }

      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );
    }
  }
}

class _SuggestionItem extends StatelessWidget {
  final Pet pet;
  _SuggestionItem(this.pet);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "detail_pet_page");
      },
      child: Container(
        height: 240,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[300],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 30,
                              offset: const Offset(0, 10))
                        ],
                      ),
                      margin: const EdgeInsets.only(top: 50),
                      child: Align(
                        child: Hero(
                            tag: 1,
                            child: Image.asset(
                              'assets/contact_background.jpg',
                              fit: BoxFit.cover,
                            )),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 60, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
