

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

final List<PetCategory> petCategories = [
  PetCategory(breedName: 'Golden Retriever', type: 'Dog', imageUrl: 'https://cdn.britannica.com/79/232779-050-6B0411D7/German-Shepherd-dog-Alsatian.jpg'),
  PetCategory(breedName: 'Persian Cat', type: 'Cat', imageUrl: 'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/a8bf1a2c-259e-4e95-b2c2-bb995876ed63/a252bcd6-9a10-40be-bf99-1d850d2026e4.png'),
  PetCategory(breedName: 'Canary', type: 'Bird', imageUrl: 'https://t3.ftcdn.net/jpg/06/10/68/10/360_F_610681083_M6XlAUkKj0I9ykA0Iz1ysOTCsNvpU5Vw.jpg'),
  PetCategory(breedName: 'Goldfish', type: 'Fish', imageUrl: 'https://img.freepik.com/free-photo/view-colorful-3d-fish-swimming-underwater_23-2150721076.jpg'),
];


