import '../models/diet_profile.dart';

/// Predefined dietary profiles with ingredient restrictions
final List<DietProfile> predefinedProfiles = [
  
  // VEGAN PROFILE
  DietProfile(
    id: 'vegan',
    name: 'Vegan',
    avoidIngredients: [
      // Meat & Poultry
      'meat', 'beef', 'pork', 'chicken', 'turkey', 'lamb', 'veal', 'duck', 
      'goose', 'bacon', 'ham', 'sausage', 'pepperoni', 'salami',
      // Seafood
      'fish', 'salmon', 'tuna', 'cod', 'shrimp', 'crab', 'lobster', 'oyster',
      'clam', 'mussel', 'anchovy', 'sardine', 'caviar',
      // Dairy
      'milk', 'cream', 'butter', 'cheese', 'yogurt', 'whey', 'casein', 
      'lactose', 'ghee', 'buttermilk', 'sour cream', 'ice cream',
      // Eggs
      'egg', 'eggs', 'albumin', 'lysozyme', 'mayonnaise',
      // Honey & Insect Products
      'honey', 'beeswax', 'royal jelly', 'propolis', 'carmine', 'cochineal',
      'shellac', 'confectioner\'s glaze',
      // Animal-derived additives
      'gelatin', 'gelatine', 'isinglass', 'rennet', 'lard', 'tallow', 
      'suet', 'animal fat', 'bone char', 'monoglycerides', 'diglycerides',
    ],
    cautionIngredients: [
      'natural flavors', 'artificial flavors', 'vitamin d3', 'omega-3',
      'sugar', 'refined sugar', 'glycerin', 'glycerine', 'lecithin',
      'mono and diglycerides', 'stearic acid', 'oleic acid', 'capric acid',
      'palmitic acid', 'myristic acid', 'e120', 'e441', 'e542', 'e904',
    ],
  ),

  // GLUTEN-FREE PROFILE
  DietProfile(
    id: 'gluten_free',
    name: 'Gluten-Free',
    avoidIngredients: [
      // Primary gluten sources
      'wheat', 'barley', 'rye', 'triticale', 'malt', 'brewer\'s yeast',
      // Wheat varieties
      'durum', 'semolina', 'spelt', 'kamut', 'einkorn', 'farro', 'graham',
      'bulgur', 'couscous', 'seitan', 'wheat germ', 'wheat bran',
      // Barley products
      'barley malt', 'malt extract', 'malt syrup', 'malt flavoring',
      'malt vinegar',
      // Common sources
      'flour', 'bread', 'pasta', 'cereals containing gluten',
      // Hidden sources
      'modified food starch', 'hydrolyzed wheat protein', 'textured vegetable protein',
      'soy sauce', 'teriyaki sauce', 'breadcrumbs', 'croutons',
    ],
    cautionIngredients: [
      'oats', 'oat flour', 'modified starch', 'food starch', 'natural flavoring',
      'artificial flavoring', 'caramel color', 'maltodextrin', 'dextrin',
      'yeast extract', 'hydrolyzed vegetable protein', 'seasonings',
      'spice blends', 'stabilizers', 'emulsifiers', 'thickeners',
    ],
  ),

  // DAIRY-FREE PROFILE
  DietProfile(
    id: 'dairy_free',
    name: 'Dairy-Free',
    avoidIngredients: [
      // Milk & Cream
      'milk', 'whole milk', 'skim milk', '2% milk', 'cream', 'heavy cream',
      'light cream', 'half and half', 'evaporated milk', 'condensed milk',
      'powdered milk', 'milk solids', 'milk powder', 'dry milk',
      // Butter & Related
      'butter', 'buttermilk', 'butterfat', 'butter oil', 'ghee',
      'butter flavor', 'artificial butter flavor',
      // Cheese
      'cheese', 'cheddar', 'mozzarella', 'parmesan', 'swiss', 'cream cheese',
      'cottage cheese', 'ricotta', 'feta', 'goat cheese', 'blue cheese',
      // Yogurt & Cultured Products
      'yogurt', 'yoghurt', 'kefir', 'sour cream', 'crème fraiche',
      // Milk Proteins & Derivatives
      'whey', 'whey protein', 'casein', 'caseinate', 'sodium caseinate',
      'calcium caseinate', 'lactose', 'lactalbumin', 'lactoglobulin',
      'curds', 'custard', 'pudding',
      // Ice Cream & Frozen
      'ice cream', 'gelato', 'frozen yogurt',
      // Other
      'paneer', 'quark', 'dulce de leche', 'malted milk',
    ],
    cautionIngredients: [
      'natural flavors', 'artificial flavors', 'caramel color', 'lactic acid',
      'lactate', 'chocolate', 'milk chocolate', 'brown sugar flavoring',
      'butter flavoring', 'cheese flavoring', 'cream flavoring',
      'high protein flour', 'margarine', 'nisin', 'simplesse',
    ],
  ),

  // PEANUT ALLERGY PROFILE
  DietProfile(
    id: 'peanut_allergy',
    name: 'Peanut Allergy',
    avoidIngredients: [
      // Direct peanut products
      'peanut', 'peanuts', 'peanut butter', 'peanut oil', 'peanut flour',
      'peanut protein', 'groundnut', 'ground nut', 'goober', 'goober pea',
      'monkey nut', 'arachis oil', 'arachis hypogaea',
      // Products often containing peanuts
      'mixed nuts', 'nut butter', 'satay', 'satay sauce', 'goobers',
      'mandelonas', 'nu-nuts', 'beer nuts',
      // Peanut derivatives
      'hydrolyzed peanut protein', 'peanut extract', 'artificial nuts',
      'lupin', 'lupine',
    ],
    cautionIngredients: [
      // Cross-contamination risks
      'may contain peanuts', 'processed in a facility that processes peanuts',
      'manufactured on shared equipment with peanuts',
      'tree nuts', 'almond', 'cashew', 'walnut', 'pecan', 'hazelnut',
      'pistachio', 'macadamia', 'brazil nut', 'pine nut',
      // Asian cuisine ingredients
      'asian sauce', 'chili sauce', 'mole sauce', 'ethnic foods',
      'natural flavoring', 'artificial flavoring',
      // Other
      'vegetable oil', 'vegetable protein', 'hydrolyzed vegetable protein',
      'chocolate', 'candy', 'baked goods', 'granola', 'cereal bars',
      'energy bars', 'protein bars',
    ],
  ),
];

/// Gets a profile by its ID
DietProfile? getProfileById(String id) {
  try {
    return predefinedProfiles.firstWhere((profile) => profile.id == id);
  } catch (e) {
    return null;
  }
}

/// Gets the currently active profile from a list of profiles
DietProfile? getActiveProfile(List<DietProfile> profiles) {
  try {
    return profiles.firstWhere((profile) => profile.isActive);
  } catch (e) {
    return null;
  }
}
