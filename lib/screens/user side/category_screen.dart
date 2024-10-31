import 'package:flutter/material.dart';
import 'package:second_project/models/category_model.dart';
import 'package:second_project/widgets/category_text.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String selectedCategory = 'All';
  String sortOrder = 'Alphabetical';

  List<PetCategory> get filteredCategories {
    List<PetCategory> filtered = petCategories;
    if (selectedCategory != 'All') {
      filtered = petCategories.where((cat) => cat.type == selectedCategory).toList();
    }
    if (sortOrder == 'Alphabetical') {
      filtered.sort((a, b) => a.breedName.compareTo(b.breedName));
    } else {
      filtered.sort((a, b) => a.type.compareTo(b.type));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search here..',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                onFieldSubmitted: (value) {
                  // Handle search
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryOption(
                    label: 'Dogs',
                    isSelected: selectedCategory == 'Dogs',
                    onTap: () => setState(() => selectedCategory = 'Dogs'),
                  ),
                  CategoryOption(
                    label: 'Cats',
                    isSelected: selectedCategory == 'Cats',
                    onTap: () => setState(() => selectedCategory = 'Cats'),
                  ),
                  CategoryOption(
                    label: 'Birds',
                    isSelected: selectedCategory == 'Birds',
                    onTap: () => setState(() => selectedCategory = 'Birds'),
                  ),
                  CategoryOption(
                    label: 'All',
                    isSelected: selectedCategory == 'All',
                    onTap: () => setState(() => selectedCategory = 'All'),
                  ),
                ],
              ),
              // DropdownButton<String>(
              //   value: sortOrder,
              //   items: ['Alphabetical', 'Type'].map((sort) {
              //     return DropdownMenuItem(value: sort, child: Text('Sort by $sort'));
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       sortOrder = value!;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return PetCategoryCard(category: category);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

