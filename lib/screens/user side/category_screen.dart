import 'package:flutter/material.dart';

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

class CategoryOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.teal.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}

class PetCategoryCard extends StatelessWidget {
  final PetCategory category;
  const PetCategoryCard({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.breedName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                
                ),
               
          
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category.type,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle wishlist toggle
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                    ),
          
                  ],
                ),
                Text('Price\$250'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add to cart
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Add to Cart',
                    style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PetCategory {
  final String breedName;
  final String type;
  final String imageUrl;

  PetCategory({
    required this.breedName,
    required this.type,
    required this.imageUrl,
  });
}

// Sample data
final List<PetCategory> petCategories = [
  PetCategory(breedName: 'Golden Retriever', type: 'Dog', imageUrl: 'https://cdn.britannica.com/79/232779-050-6B0411D7/German-Shepherd-dog-Alsatian.jpg'),
  PetCategory(breedName: 'Persian Cat', type: 'Cat', imageUrl: 'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/a8bf1a2c-259e-4e95-b2c2-bb995876ed63/a252bcd6-9a10-40be-bf99-1d850d2026e4.png'),
  PetCategory(breedName: 'Canary', type: 'Bird', imageUrl: 'https://t3.ftcdn.net/jpg/06/10/68/10/360_F_610681083_M6XlAUkKj0I9ykA0Iz1ysOTCsNvpU5Vw.jpg'),
  PetCategory(breedName: 'Goldfish', type: 'Fish', imageUrl: 'https://img.freepik.com/free-photo/view-colorful-3d-fish-swimming-underwater_23-2150721076.jpg'),
];
