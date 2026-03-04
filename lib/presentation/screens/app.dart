import 'package:app_schedule_management/core/router/route_manager.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/presentation/cubits/view_apps_cubit/cubit/view_apps_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ViewAppsCubit>()..getInstalledApps(),
        ),  
      ],
      child: ToastificationWrapper(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.red,
                  primary: Colors.red,
                  secondary: Colors.black,
                ),
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: RouteManager.router,
            );
          },
        ),
      ),
    );
  }
}