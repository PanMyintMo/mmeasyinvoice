part of 'order_filter_cubit.dart';

abstract class OrderFilterState extends Equatable {
  const OrderFilterState();
}

class OrderFilterInitial extends OrderFilterState {
  @override
  List<Object?> get props => [];
}

class OrderFilterLoading extends OrderFilterState {
  @override
  List<Object> get props => [];
}

class OrderFilterSuccess extends OrderFilterState {
  final List<OrderDatas> orderData;
  final int totalRevenue;
  final int totalProfit;
  final int totalSales;
  final int totalFaultyItem;
  final int totalWareHouseQuantity;
  final int shopKeeper;

  const OrderFilterSuccess({
    required this.orderData,
    required this.totalRevenue,
    required this.totalProfit,
    required this.totalSales,
    required this.totalFaultyItem,
    required this.totalWareHouseQuantity,
    required this.shopKeeper,
  });

  @override
  List<Object?> get props => [
        orderData,
        totalRevenue,
        totalProfit,
        totalSales,
        totalFaultyItem,
        totalWareHouseQuantity,
        shopKeeper,
      ];

  OrderFilterSuccess copyWith({
    List<OrderDatas>? orderDatas,
    int? totalRevenue,
    int? totalProfit,
    int? totalSales,
    int? totalFaultyItem,
    int? totalWareHouseQuantity,
    int? shopKeeper,
  }) {
    return OrderFilterSuccess(
      orderData: orderDatas ?? orderData,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      totalProfit: totalProfit ?? this.totalProfit,
      totalSales: totalSales ?? this.totalSales,
      totalFaultyItem: totalFaultyItem ?? this.totalFaultyItem,
      totalWareHouseQuantity:
          totalWareHouseQuantity ?? this.totalWareHouseQuantity,
      shopKeeper: shopKeeper ?? this.shopKeeper,
    );
  }
}

class AddOrderSuccess extends OrderFilterState {
  final OrderResponse _orderResponse;

  const AddOrderSuccess(this._orderResponse);

  OrderResponse get orderResponse => _orderResponse;

  @override
  List<Object?> get props => [_orderResponse];
}

class OrderFilterFailed extends OrderFilterState {
  final String error;

  const OrderFilterFailed({required this.error});

  @override
  List<Object?> get props => [error];
}


//order by date
class OrderByDateRetreve extends OrderFilterState {
  final List<OrderDatas> orderByDateResponse;

  const OrderByDateRetreve(this.orderByDateResponse);

  List<OrderDatas> get orderResponse => orderByDateResponse;

  @override
  List<Object?> get props => [orderByDateResponse];
}
