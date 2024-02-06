import 'package:bloc/bloc.dart';

import 'package:mmeasyInvoice/data/repository/auth_repository.dart';

import 'package:mmeasyInvoice/data/response/warehouseResponse/warehouse_response.dart';

import 'package:mmeasyInvoice/state/get/cubit/warehouse_state.dart';


class WarehouseCubit extends Cubit<WarehouseState> {

  final AuthRepository _authRepository;


  WarehouseCubit(this._authRepository) : super(WarehouseInitial());


  Future<void> warehouse() async {

    emit(WarehouseLoading());


    try {

      final response = await _authRepository.warehouseApi();


      final warehouseResponse = WarehouseResponse.fromJson(response);


      emit(WarehouseSuccess(warehouseResponse));

    } catch (e) {

      emit(WarehouseFailed(error: e.toString()));

    }

  }

}

