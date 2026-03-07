import 'package:app_schedule_management/presentation/cubits/view_apps_cubit/cubit/view_apps_cubit.dart';
import 'package:app_schedule_management/presentation/screens/widgets/create_schedule_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewAppsFragment extends StatelessWidget {
  ViewAppsFragment({super.key});

  // App Search Text Editing Controller
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Apps', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<ViewAppsCubit>().searchApps(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              // Grid View of All Installed Apps
              BlocBuilder<ViewAppsCubit, ViewAppsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => Expanded(
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      ),
                    ),
                    loaded: (apps) => Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<ViewAppsCubit>().getInstalledApps();
                        },
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(12),
                          itemCount: apps.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                          itemBuilder: (context, index) {
                            final app = apps[index];
                            return InkWell(
                              onTap: () {
                                // Bottom Sheet For New Schedule Create
                                showCreateScheduleBottomSheet(context, app, null);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.memory(
                                    app.iconBytes!,
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    app.appName ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    error: (error) => Expanded(
                      child: Center(
                        child: Text(error, style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

