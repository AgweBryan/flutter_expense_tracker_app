import 'package:get/get.dart';

class AddTransactionController extends GetxController {
  final Rx<String> _transactionType = ''.obs;
  final Rx<String> _selectedDate = ''.obs;
  final Rx<String> _selectedCategory = Rx<String>('');
  final Rx<String> _selectedMode = Rx<String>('');
  final Rx<String> _selectedTime = ''.obs;
  // DateFormat('hh:mm a').format(DateTime.now()).obs;
  final Rx<String> _selectedImage = Rx<String>('');

  String get selectedDate => _selectedDate.value;
  String get selectedTime => _selectedTime.value;
  String get selectedCategory => _selectedCategory.value;
  String get selectedMode => _selectedMode.value;
  String get selectedImage => _selectedImage.value;

  String get transactionType => _transactionType.value;

  changeTransactionType(String tt) => _transactionType.value = tt;
  updateSelectedCategory(String category) => _selectedCategory.value = category;
  updateSelectedMode(String mode) => _selectedMode.value = mode;

  updateSelectedDate(String date) => _selectedDate.value = date;
  updateSelectedTime(String time) => _selectedTime.value = time;

  updateSelectedImage(String path) {
    _selectedImage.value = path;

    Get.back();
  }
}
