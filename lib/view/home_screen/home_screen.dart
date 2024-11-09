import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController title = TextEditingController();

  final formkey = GlobalKey<FormState>();
  var todoList = FirebaseFirestore.instance.collection("TodoList");

  void bottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      backgroundColor: ColorConstants.sheetcolor,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.black,
                          fontSize: 18),
                      controller: title,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        } else {
                          return 'must fill';
                        }
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorConstants.grey,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorConstants.black,
                              width: 2.0,
                            ),
                          ),
                          hintText: "Enter task title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(ColorConstants.button)),
                        onPressed: () async {
                          Navigator.pop(context);

                          if (formkey.currentState!.validate()) {
                            await todoList.add({
                              "title": title.text,
                              "completed": false,
                            });
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: ColorConstants.white),
                        ))
                  ],
                )),
          ),
        );
      },
    );
  }

  // Update the task completion status in Firestore
  Future<void> updateTaskCompletion(String docId, bool isCompleted) async {
    await todoList.doc(docId).update({
      "completed": isCompleted,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.grey,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://img.freepik.com/premium-vector/young-man-face-avater-vector-illustration-design_968209-13.jpg"),
              ),
            )
          ],
          title: Text(
            "My Tasks",
            style: TextStyle(
                color: ColorConstants.white,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: ColorConstants.black,
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: ColorConstants.blue.withOpacity(0.8),
          backgroundColor: ColorConstants.orange,
          onPressed: () {
            title.clear();
            bottomSheet(context);
          },
          child: Icon(
            Icons.add,
            color: ColorConstants.black,
            size: 30,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: todoList.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            documents[index].data()! as Map<String, dynamic>;
                        bool isTaskCompleted = data['completed'] ?? false;

                        return InkWell(
                          onLongPress: () async {
                            // To delete task
                            await todoList.doc(documents[index].id).delete();
                          },
                          child: Card(
                            color: ColorConstants.blue,
                            child: ListTile(
                              title: Text(
                                data['title'] ?? "",
                                style: TextStyle(
                                    color: ColorConstants.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                isTaskCompleted ? "Task Completed" : "",
                                style: TextStyle(
                                    color: ColorConstants.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Checkbox(
                                activeColor: ColorConstants.green,
                                value: isTaskCompleted,
                                onChanged: (value) {
                                  setState(() {
                                    // Update the task completion status in Firestore
                                    updateTaskCompletion(
                                        documents[index].id, value!);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: documents.length)
                ],
              ),
            );
          },
        ));
  }
}
