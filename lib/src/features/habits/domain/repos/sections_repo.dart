import 'package:dartz/dartz.dart';
import '../entities/section.dart';

abstract class SectionsRepo {
  Future<Either<Exception, List<Section>>> getAll();
  Future<Either<Exception, Section>> getById(String id);
  Future<Either<Exception, Section>> create(Section section);
  Future<Either<Exception, Section>> update(Section section);
  Future<Either<Exception, void>> delete(String id);

  Future<Either<Exception, void>> reorder(List<String> orderedSectionIds);
}
