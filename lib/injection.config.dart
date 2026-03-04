// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'data/data_sources/local_db_source/i_local_db_source.dart' as _i660;
import 'data/data_sources/local_db_source/local_db_source.dart' as _i59;
import 'data/services/app_installed_services.dart' as _i114;
import 'presentation/cubits/view_apps_cubit/cubit/view_apps_cubit.dart'
    as _i305;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i114.AppInstalledServices>(
      () => _i114.AppInstalledServices());
  gh.lazySingleton<_i59.LocalDbSource>(() => _i660.LocalDbSourceImpl());
  gh.factory<_i305.ViewAppsCubit>(
      () => _i305.ViewAppsCubit(gh<_i114.AppInstalledServices>()));
  return getIt;
}
