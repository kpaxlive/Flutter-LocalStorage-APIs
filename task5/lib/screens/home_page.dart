import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_5/screens/models/task_model.dart';
import 'package:task_5/services/hive_service.dart';

class HomePage extends StatefulWidget {
  final HiveService hiveService;
  const HomePage({super.key, required this.hiveService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Set<int> segmentValue = {0};
  List filteredTasks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple.shade300,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AlertDialog(
                    title: const Text("Enter your task"),
                    content: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: titleController,
                            maxLength: 20,
                          ),
                          TextField(
                            controller: contentController,
                            maxLines: 3,
                            maxLength: 60,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            if (contentController.text.isNotEmpty &&
                                titleController.text.isNotEmpty) {
                              String key = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              TodoModel todo = TodoModel(
                                  key: key,
                                  done: false,
                                  title: titleController.text,
                                  content: contentController.text);
                              widget.hiveService.addTodoItem(key, todo);
                              contentController.clear();
                              titleController.clear();
                              Navigator.pop(context);
                              setState(() {});
                            }
                          },
                          child: const Text("Add Task")),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel")),
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.grey.shade200, size: 40),
        ),
      ),
      backgroundColor: Colors.deepPurple.shade800,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Task Manager",
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade200,
              ),
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 75,
              width: 300,
              child: Center(
                child: SegmentedButton(
                  segments: const <ButtonSegment<int>>[
                    ButtonSegment<int>(value: 0, label: Text("All")),
                    ButtonSegment<int>(value: 1, label: Text("Done")),
                    ButtonSegment<int>(value: 2, label: Text("Undone")),
                  ],
                  selected: segmentValue,
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  showSelectedIcon: false,
                  onSelectionChanged: (value) {
                    setState(() {
                      segmentValue = value;
                      filteredTasks = _filterTasks(filteredTasks, segmentValue);
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder(
            future: Future.value(widget.hiveService.getAllTodoItems()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something Went Wrong"),
                  );
                } else {
                  final allTasks = snapshot.data as List;
                    filteredTasks = _filterTasks(allTasks, segmentValue);
                  return Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey.shade100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Checkbox(
                                  value: task.done,
                                  onChanged: (value) {
                                    setState(() {
                                      task.done = value!;
                                      widget.hiveService
                                          .addTodoItem(task.key, task);
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        task.title.toUpperCase(),
                                        style: GoogleFonts.aBeeZee(
                                            textStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      )),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(task.content,
                                          softWrap: true,
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      Colors.grey.shade800))),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                IconButton(
                                    onPressed: () {
                                      widget.hiveService
                                          .deleteTodoItem(task.key);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      size: 30,
                                      color: Colors.red.shade700,
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
  
 List _filterTasks(List allTasks, Set<int> segment) 
 {
    if(segment == {0})
    {
      return allTasks;
    }
    else if(segment == {1})
    {
      return allTasks.where((task) => task.done == true).toList();
    }
    else
    {
      return allTasks.where((task) => task.done == false).toList();
    }
 }
}
