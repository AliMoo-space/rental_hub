import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/core/connection/network_info.dart';
import 'package:rental_hub/feature/booking/data/datasources/booking_remote_data_source.dart';
import 'package:rental_hub/feature/booking/data/models/create_rental_order_dto.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_stats_entity.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RentalOrderEntity>> createRentalOrder(CreateRentalOrderDto dto) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOrder = await remoteDataSource.createRentalOrder(dto);
        return Right(remoteOrder);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, RentalOrderStatsEntity>> getRenterOrderStats() async {
    if (await networkInfo.isConnected) {
      try {
        final stats = await remoteDataSource.getRenterOrderStats();
        return Right(stats);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, List<RentalOrderEntity>>> getMyOrders({String? status, int pageNumber = 1, int pageSize = 10}) async {
    if (await networkInfo.isConnected) {
      try {
        final orders = await remoteDataSource.getMyOrders(
          status: status,
          pageNumber: pageNumber,
          pageSize: pageSize,
        );
        return Right(orders);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, List<RentalOrderEntity>>> getMyListingsOrders({String? status, int pageNumber = 1, int pageSize = 10}) async {
    if (await networkInfo.isConnected) {
      try {
        final orders = await remoteDataSource.getMyListingsOrders(
          status: status,
          pageNumber: pageNumber,
          pageSize: pageSize,
        );
        return Right(orders);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, RentalOrderEntity>> getRentalOrderById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOrder = await remoteDataSource.getRentalOrderById(id);
        return Right(remoteOrder);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> approveRentalOrder(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.approveRentalOrder(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> rejectRentalOrder(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.rejectRentalOrder(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> cancelRentalOrder(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.cancelRentalOrder(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> shipRentalOrder(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.shipRentalOrder(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> confirmReceiptRentalOrder(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.confirmReceiptRentalOrder(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> returnRentalOrder(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.returnRentalOrder(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.message));
      }
    } else {
      return Left(Failure(errMessage: "No internet connection"));
    }
  }
}
