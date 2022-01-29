import 'package:bima/features/doctor/data/data_sources/local/tables/doctor_table.dart';
import 'package:hive/hive.dart';

abstract class DoctorLocalDataSource {
  Future<void> saveMovie(DoctorTable movieTable);
  Future<List<DoctorTable>> getMovies();
}

class DoctorLocalDataSourceImpl extends DoctorLocalDataSource {
  @override
  Future<List<DoctorTable>> getMovies() async {
    final movieBox = await Hive.openBox('movieBox');
    final movieIds = movieBox.keys;
    List<DoctorTable> movies = [];
    movieIds.forEach((movieId) {
      movies.add(movieBox.get(movieId));
    });
    return movies;
  }

  @override
  Future<void> saveMovie(DoctorTable movieTable) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.put(movieTable.id, movieTable);
  }
}
