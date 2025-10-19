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

  // PREGNANCY-SAFE PROFILE
  DietProfile(
    id: 'pregnancy',
    name: 'Pregnancy-Safe',
    avoidIngredients: [
      // High-mercury fish (FDA/EPA warning)
      'shark', 'swordfish', 'king mackerel', 'tilefish', 'bigeye tuna',
      'marlin', 'orange roughy', 'gulf tilefish',
      // Raw/undercooked seafood & meat
      'raw fish', 'sushi', 'sashimi', 'raw oysters', 'raw clams', 
      'raw scallops', 'ceviche', 'raw shrimp', 'smoked salmon', 'lox',
      'nova', 'gravlax', 'refrigerated smoked seafood',
      'raw meat', 'rare meat', 'tartare', 'carpaccio', 'raw beef',
      'raw pork', 'undercooked poultry',
      // Raw/undercooked eggs
      'raw eggs', 'soft-boiled eggs', 'runny eggs', 'homemade mayonnaise',
      'hollandaise sauce', 'caesar dressing', 'raw cookie dough',
      'raw cake batter', 'tiramisu', 'homemade ice cream with raw eggs',
      // Unpasteurized products
      'unpasteurized milk', 'raw milk', 'unpasteurized cheese', 
      'unpasteurized juice', 'raw apple cider',
      // Soft cheeses (listeria risk)
      'brie', 'camembert', 'roquefort', 'feta', 'gorgonzola', 'queso blanco',
      'queso fresco', 'panela', 'fresh mozzarella',
      // Deli meats & prepared meats (unless heated)
      'cold deli meat', 'cold cuts', 'lunch meat', 'hot dogs', 'bologna',
      'salami', 'pepperoni', 'prosciutto', 'pâté', 'meat spreads',
      'refrigerated pâté', 'refrigerated meat spread',
      // Alcohol (complete avoidance)
      'alcohol', 'wine', 'beer', 'liquor', 'spirits', 'rum', 'vodka',
      'whiskey', 'bourbon', 'gin', 'tequila', 'sake', 'champagne',
      'cooking wine', 'sherry', 'rum extract', 'brandy',
      // Excessive caffeine sources
      'energy drink', 'pre-workout supplement', 'diet pills',
      // Raw sprouts (bacterial risk)
      'raw alfalfa sprouts', 'raw clover sprouts', 'raw radish sprouts',
      'raw mung bean sprouts', 'raw sprouts',
      // Unwashed produce indicators
      'unwashed', 'soil', 'garden fresh',
      // Liver & high vitamin A
      'liver', 'liver pâté', 'liverwurst', 'cod liver oil',
      'retinyl palmitate', 'retinol', 'vitamin a palmitate',
      // Herbal teas & supplements (many unsafe)
      'herbal supplement', 'herbal remedy', 'kava', 'comfrey', 'pennyroyal',
      'black cohosh', 'blue cohosh', 'dong quai', 'ephedra', 'yohimbe',
      'saw palmetto', 'goldenseal',
      // Artificial sweeteners (some)
      'saccharin', 'cyclamate',
      // High-sodium/preserved foods
      'msg', 'monosodium glutamate', 'sodium nitrite', 'sodium nitrate',
      // Other high-risk items
      'raw bean sprouts', 'unpasteurized honey', 'quinine', 'tonic water with quinine',
    ],
    cautionIngredients: [
      // Moderate-mercury fish (limit consumption)
      'tuna', 'albacore tuna', 'white tuna', 'yellowfin tuna', 'ahi tuna',
      'sea bass', 'grouper', 'snapper', 'halibut', 'spanish mackerel',
      'bluefish', 'tilefish',
      // Caffeine (limit to 200mg/day)
      'caffeine', 'coffee', 'black tea', 'green tea', 'cola', 'soda',
      'chocolate', 'cocoa', 'espresso', 'cappuccino', 'latte',
      // Processed meats (high sodium/nitrates)
      'bacon', 'sausage', 'ham', 'cured meat', 'smoked meat',
      // Soft-serve ice cream (listeria risk if machine not clean)
      'soft serve', 'soft-serve ice cream', 'frozen yogurt machine',
      // High-sodium foods
      'canned soup', 'instant noodles', 'ramen', 'soy sauce',
      'pickled', 'cured', 'brined',
      // Certain fish (moderate intake)
      'canned tuna', 'fish sticks', 'imitation crab',
      // Artificial sweeteners (limit)
      'aspartame', 'sucralose', 'acesulfame potassium', 'neotame',
      'stevia', 'sugar alcohol', 'sorbitol', 'xylitol', 'erythritol',
      // Processed foods (high sodium/additives)
      'canned', 'preserved', 'instant', 'packaged',
      // Herbal teas (many unknown safety)
      'herbal tea', 'chamomile tea', 'peppermint tea', 'ginger tea',
      'raspberry leaf tea', 'nettle tea',
      // Licorice & anise
      'licorice', 'licorice root', 'anise', 'star anise', 'fennel',
      // Excessive sugar
      'high fructose corn syrup', 'corn syrup', 'dextrose',
      // Certain nuts (aflatoxin risk if moldy)
      'peanut', 'peanut butter',
      // Raw honey (botulism risk - though minimal for adults)
      'honey', 'raw honey',
      // Certain oils in excess
      'fish oil supplement', 'omega-3 supplement',
      // Smoked foods
      'smoked', 'smoke flavoring',
      // Certain spices in large amounts
      'cinnamon', 'nutmeg', 'paprika', 'chili powder',
      // Processed cheese
      'american cheese', 'cheese product', 'cheese spread',
      // Blue-veined cheese
      'blue cheese', 'stilton', 'danish blue',
      // Street food/buffet items (food safety concerns)
      'buffet', 'salad bar item',
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
