import 'package:flutter/cupertino.dart';

class TranscationProvider extends ChangeNotifier{

  List <String> budgets = ['Select a budget'];
  List <String> categories = ['Select a category'];

  List<String> get nbudgets => budgets;
  List<String> get ncategories => categories;

  void addToBudgets(String newItem) {
    budgets.add(newItem);
    notifyListeners();
  }

  void addToCategories(String newItem) {
    categories.add(newItem);
    notifyListeners();
  }

  void clearBudgets(List<String> clearBudget){
    budgets = clearBudget;
    notifyListeners();
  }

  void clearCategories(List<String> clearCategories){
    categories = clearCategories;
    notifyListeners();
  }





}