import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/constants/dimens.dart';
import 'package:task/infrastructure/cubit/job_cubit.dart';
import 'package:task/infrastructure/cubit/navigation_view_model.dart';
import 'package:task/presentation/screens/main/view_model/main_view_model.dart';
import 'package:task/presentation/screens/settings/view/settings_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late MainViewModel jobSearchViewModel;
  final TextEditingController controller = TextEditingController();
  bool isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    jobSearchViewModel = MainViewModel(
      context.read<JobCubit>(),
      context.read<NavigationCubit>(),
    );

    controller.addListener(() {
      setState(() {
        isTextFieldEmpty = controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentPage) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('AppBar Name'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (index) {
              context.read<NavigationCubit>().changePage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Ana Ekran',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Ayarlar',
              ),
            ],
          ),
          body: SafeArea(
            child: IndexedStack(
              index: currentPage,
              children: [buildHomePage(), const SettingsView()],
            ),
          ),
        );
      },
    );
  }

  Widget buildHomePage() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.paddingPageHorizontal),
          child: Stack(
            children: [
              TextFormField(
                controller: controller,
                onChanged: (value) {
                  final query = controller.text;
                  if (query.isNotEmpty) {
                    jobSearchViewModel.searchJobs(query);
                  }
                },
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                  filled: true,
                ),
              ),
              if (isTextFieldEmpty)
                Positioned(
                  left: 55,
                  top: 15,
                  child: IgnorePointer(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(milliseconds: 1000),
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Sıva Ustası...',
                          textStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                        TypewriterAnimatedText(
                          'Duvar Ustası...',
                          textStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                        TypewriterAnimatedText(
                          'Marangoz...',
                          textStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        BlocBuilder<JobCubit, JobState>(
          builder: (context, state) {
            if (state is JobLoading) {
              return const CircularProgressIndicator();
            } else if (state is JobLoaded) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final job = state.jobs[index];
                    return ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('İş Açıklaması'),
                            content: Text(job.jobDesc),
                          ),
                        );
                      },
                      title: Text(job.jobTitle),
                      subtitle: Text(job.jobDesc),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 12,
                      ),
                    );
                  },
                ),
              );
            } else if (state is JobError) {
              return Text('Error: ${state.message}');
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
