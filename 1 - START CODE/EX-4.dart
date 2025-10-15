enum DeliveryMethod { pickUp, delivery }

class Product {
  final String productName;
  final double productPrice;

  Product({required this.productName, required this.productPrice});
}

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({required this.product, required this.quantity});

  double subTotal() => product.productPrice * quantity;
}

class Address {
  final String street;
  final String city;
  final String postalCode;

  Address({required this.street, required this.city, required this.postalCode});
}

class Order {
  final List<OrderItem> items;
  final DeliveryMethod method;
  final Address? address;
  final double deliveryFee;

  Order.pickUp({required List<OrderItem> items})
    : items = List.unmodifiable(items),
      method = DeliveryMethod.pickUp,
      address = null,
      deliveryFee = 0.0;

  Order.delivery({
    required List<OrderItem> items,
    required Address address,
    this.deliveryFee = 5.0,
  }) : items = List.unmodifiable(items),
       method = DeliveryMethod.delivery,
       address = address;

  double totalAmount() {
    double sum = 0;
    for (var item in items) {
      sum += item.subTotal();
    }

    if (method == DeliveryMethod.delivery) {
      sum += deliveryFee;
    }

    return sum;
  }

  @override
  String toString() {
    final itemsString = items
        .map(
          (it) =>
              '- ${it.product.productName} x${it.quantity} = \$${it.subTotal().toStringAsFixed(2)}',
        )
        .join('\n');

    final deliveryInfo = method == DeliveryMethod.delivery && address != null
        ? 'Delivery fee: \$${deliveryFee.toStringAsFixed(2)}\nDeliver to: ${address!.street}, ${address!.city}, ${address!.postalCode}'
        : 'Pickup at shop';

    return 'Order (${method == DeliveryMethod.pickUp ? "Pickup" : "Delivery"})\n'
        '$itemsString\n'
        '$deliveryInfo\n'
        'Total: \$${totalAmount().toStringAsFixed(2)}';
  }
}

void main() {
  final apple = Product(productName: 'Apple', productPrice: 0.5);
  final milk = Product(productName: 'Milk (1L)', productPrice: 1.2);
  final bread = Product(productName: 'Bread', productPrice: 1.0);

  final item1 = OrderItem(product: apple, quantity: 10);
  final item2 = OrderItem(product: milk, quantity: 2);
  final item3 = OrderItem(product: bread, quantity: 1);

  final pickupOrder = Order.pickUp(items: [item1, item3]);
  print(pickupOrder);

  final addr = Address(
    street: '123 Main St',
    city: 'Phnom Penh',
    postalCode: '12000',
  );
  final deliveryOrder = Order.delivery(
    items: [item1, item2, item3],
    address: addr,
    deliveryFee: 3.5,
  );
  print(deliveryOrder);
}
