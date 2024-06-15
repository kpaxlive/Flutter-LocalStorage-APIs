import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_2/bloc/cubit/todo_cubit.dart';
import 'package:task_2/components/alert_dialog.dart';
import 'package:task_2/components/delete_button.dart';
// import '../bloc/cubit/todo_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  Filter segmentValue = Filter.all;

  void _onSearchChanged() {
    // context.read<TodoCubit>().searchTodos(searchController.text);
    print("Buraya da girdi");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TodoCubit>().loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 46, 46, 61),
      body: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "You",
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                        ),
                        SizedBox(
                          height: 50,
                          width: 280,
                          child: SegmentedButton(
                            segments: const <ButtonSegment>[
                              ButtonSegment(
                                  value: Filter.all, label: Text("All")),
                              ButtonSegment(
                                  value: Filter.done, label: Text("Done")),
                              ButtonSegment(
                                  value: Filter.undone, label: Text("Undone")),
                            ],
                            selected: {state.filter},
                            onSelectionChanged: (value) {
                              context.read<TodoCubit>().setFilter(value.first);
                              context.read<TodoCubit>().loadTodos();
                              context.read<TodoCubit>().filterList();
                              // context
                              //     .read<TodoCubit>()
                              //     .setFilter(segmentValue);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "got things to do",
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: DialogAlert(
                                      titleController: titleController,
                                      contentController: contentController,
                                      todoStore: context.read<TodoCubit>(),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 55,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                child: TextField(
                  controller: context.read<TodoCubit>().searchController,
                  onChanged: (value) {
                    // print("Girdi");
                    // _onSearchChanged();
                    context.read<TodoCubit>().search(value);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 66, 66, 88),
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(25),
                        topEnd: Radius.circular(25)),
                  ),
                  child: state.isLoading
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) {
                            final task = state.todos[index];
                            return Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(255, 73, 73, 96),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                        value: state.todos[index].isDone,
                                        activeColor: Colors.blue,
                                        fillColor: MaterialStateProperty.all(
                                            const Color.fromARGB(
                                                255, 98, 119, 215)),
                                        onChanged: (value) {
                                          context
                                              .read<TodoCubit>()
                                              .toggleTodoStatus(
                                                  state.todos[index].id);
                                        }),
                                  ),
                                  const SizedBox(
                                      height: 80,
                                      width: 5,
                                      child:
                                          VerticalDivider(color: Colors.red)),
                                  const SizedBox(
                                    width: 5,
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
                                              textStyle: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade200,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          task.content,
                                          softWrap: true,
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  DeleteButton(
                                      todoStore: context.read<TodoCubit>(),
                                      id: state.todos[index].id),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
