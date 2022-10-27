import 'package:flutter/material.dart';

class AdminManageView extends StatefulWidget {
  const AdminManageView({super.key});

  @override
  State<AdminManageView> createState() => _AdminManageViewState();
}

class _AdminManageViewState extends State<AdminManageView> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Manage")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked = !isClicked;
                  });
                },
                child: Container(
                  width: size.width * 0.95,
                  padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black45)),
                  child: Text(
                    "Jake Completed Task",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              SizedBox(
                child: isClicked
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: size.width * 0.85,
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black45,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        side:
                                            BorderSide(color: Colors.black26)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Approve"),
                                    ),
                                  ),
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        side:
                                            BorderSide(color: Colors.black26)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Approve"),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: size.width * 0.95,
                            padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black45)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Jake Submitted Doucoment",
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const Material(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.black26)),
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text("Approve"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
