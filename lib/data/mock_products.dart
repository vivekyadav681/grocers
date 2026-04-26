import 'package:grocers/models/product_model.dart';

final List<ProductModel> mockProducts = [
  // Snacks
  const ProductModel(name: "Lays Magic Masala", price: 20.0, imagePath: "assets/images/snack.png", category: Category.snack),
  const ProductModel(name: "Kurkure Masala Munch", price: 20.0, imagePath: "assets/images/snack.png", category: Category.snack),
  const ProductModel(name: "Haldiram Bhujia Sev", price: 55.0, imagePath: "assets/images/snack.png", category: Category.snack),
  const ProductModel(name: "Oreo Vanilla Creme", price: 35.0, imagePath: "assets/images/snack.png", category: Category.snack),
  const ProductModel(name: "Parle-G Biscuits", price: 10.0, imagePath: "assets/images/snack.png", category: Category.snack),
  const ProductModel(name: "Doritos Nacho Cheese", price: 50.0, imagePath: "assets/images/snack.png", category: Category.snack),
  const ProductModel(name: "Pringles Original", price: 110.0, imagePath: "assets/images/snack.png", category: Category.snack),
  const ProductModel(name: "Britannia Good Day", price: 30.0, imagePath: "assets/images/snack.png", category: Category.snack),
  
  // Vegetables
  const ProductModel(name: "Fresh Onion (1 kg)", price: 40.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  const ProductModel(name: "Potato (1 kg)", price: 30.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  const ProductModel(name: "Tomato (1 kg)", price: 60.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  const ProductModel(name: "Cauliflower (1 pc)", price: 45.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  const ProductModel(name: "Cabbage (1 pc)", price: 35.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  const ProductModel(name: "Spinach / Palak", price: 25.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  const ProductModel(name: "Carrot (500 g)", price: 50.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  const ProductModel(name: "Lady Finger (500 g)", price: 40.0, imagePath: "assets/images/vegetable.png", isFresh: true, category: Category.vegetable),
  
  // Fruits
  const ProductModel(name: "Kashmiri Apple (1 kg)", price: 150.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  const ProductModel(name: "Robusta Banana (1 Dozen)", price: 60.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  const ProductModel(name: "Nagpur Orange (1 kg)", price: 80.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  const ProductModel(name: "Alphonso Mango (1 kg)", price: 300.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  const ProductModel(name: "Papaya (1 pc)", price: 50.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  const ProductModel(name: "Green Grapes (500 g)", price: 100.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  const ProductModel(name: "Watermelon (1 pc)", price: 70.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  const ProductModel(name: "Pomegranate (500 g)", price: 120.0, imagePath: "assets/images/fruits.png", isFresh: true, category: Category.fruits),
  
  // Beverages
  const ProductModel(name: "Coca Cola (750 ml)", price: 40.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  const ProductModel(name: "Pepsi (750 ml)", price: 40.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  const ProductModel(name: "Thums Up (750 ml)", price: 40.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  const ProductModel(name: "Frooti Mango (1.2 L)", price: 65.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  const ProductModel(name: "Real Mixed Fruit Juice", price: 110.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  const ProductModel(name: "Red Bull Energy Drink", price: 115.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  const ProductModel(name: "Nescafe Classic Coffee", price: 150.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  const ProductModel(name: "Brooke Bond Taj Mahal Tea", price: 250.0, imagePath: "assets/images/beverages.png", category: Category.beverages),
  
  // Dairy
  const ProductModel(name: "Amul Taaza Milk (500 ml)", price: 27.0, imagePath: "assets/images/dairy.png", isFresh: true, category: Category.dairy),
  const ProductModel(name: "Mother Dairy Toned Milk", price: 27.0, imagePath: "assets/images/dairy.png", isFresh: true, category: Category.dairy),
  const ProductModel(name: "Amul Butter (100 g)", price: 56.0, imagePath: "assets/images/dairy.png", category: Category.dairy),
  const ProductModel(name: "Fresh Paneer (200 g)", price: 85.0, imagePath: "assets/images/dairy.png", isFresh: true, category: Category.dairy),
  const ProductModel(name: "Amul Masti Dahi (400 g)", price: 35.0, imagePath: "assets/images/dairy.png", isFresh: true, category: Category.dairy),
  const ProductModel(name: "Britannia Cheese Slices", price: 125.0, imagePath: "assets/images/dairy.png", category: Category.dairy),
  const ProductModel(name: "Patanjali Cow Ghee (1 L)", price: 610.0, imagePath: "assets/images/dairy.png", category: Category.dairy),
  
  // Home
  const ProductModel(name: "Surf Excel Easy Wash (1 kg)", price: 130.0, imagePath: "assets/images/home.png", category: Category.home),
  const ProductModel(name: "Ariel Matic Liquid (1 L)", price: 220.0, imagePath: "assets/images/home.png", category: Category.home),
  const ProductModel(name: "Vim Dishwash Bar", price: 15.0, imagePath: "assets/images/home.png", category: Category.home),
  const ProductModel(name: "Harpic Toilet Cleaner", price: 99.0, imagePath: "assets/images/home.png", category: Category.home),
  const ProductModel(name: "Lizol Floor Cleaner", price: 105.0, imagePath: "assets/images/home.png", category: Category.home),
  const ProductModel(name: "Comfort Fabric Conditioner", price: 220.0, imagePath: "assets/images/home.png", category: Category.home),
  const ProductModel(name: "Godrej Aer Pocket", price: 60.0, imagePath: "assets/images/home.png", category: Category.home),
  
  // Electronics
  const ProductModel(name: "Duracell AA Batteries (4 pcs)", price: 160.0, imagePath: "assets/images/electronics.png", category: Category.electronics),
  const ProductModel(name: "Eveready AAA Batteries", price: 120.0, imagePath: "assets/images/electronics.png", category: Category.electronics),
  const ProductModel(name: "Havells 9W LED Bulb", price: 99.0, imagePath: "assets/images/electronics.png", category: Category.electronics),
  const ProductModel(name: "Syska 4-Way Extension Board", price: 450.0, imagePath: "assets/images/electronics.png", category: Category.electronics),
  const ProductModel(name: "boAt BassHeads 100", price: 399.0, imagePath: "assets/images/electronics.png", category: Category.electronics),
  const ProductModel(name: "SanDisk 32GB Pen Drive", price: 350.0, imagePath: "assets/images/electronics.png", category: Category.electronics),
  const ProductModel(name: "Portronics USB Cable", price: 199.0, imagePath: "assets/images/electronics.png", category: Category.electronics),
];
