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

  // TREE NUT ALLERGY PROFILE
  DietProfile(
    id: 'tree_nut_allergy',
    name: 'Tree Nut Allergy',
    avoidIngredients: [
      // Common tree nuts
      'almond', 'almonds', 'cashew', 'cashews', 'walnut', 'walnuts',
      'pecan', 'pecans', 'hazelnut', 'hazelnuts', 'filbert', 'filberts',
      'pistachio', 'pistachios', 'macadamia', 'macadamia nut',
      'brazil nut', 'brazil nuts', 'pine nut', 'pine nuts', 'pignolia',
      'chestnut', 'chestnuts', 'beechnut', 'butternut', 'hickory nut',
      'chinquapin', 'ginkgo nut', 'shea nut', 'lichee nut', 'lychee nut',
      // Nut butters and oils
      'almond butter', 'cashew butter', 'hazelnut butter', 'nut butter',
      'almond oil', 'walnut oil', 'hazelnut oil', 'macadamia oil',
      'nut oil', 'mixed nut oil',
      // Nut flours and meals
      'almond flour', 'almond meal', 'hazelnut flour', 'cashew flour',
      'pecan flour', 'nut flour', 'nut meal',
      // Nut milks
      'almond milk', 'cashew milk', 'hazelnut milk', 'macadamia milk',
      'nut milk',
      // Products and derivatives
      'marzipan', 'almond paste', 'nougat', 'gianduja', 'praline',
      'nutella', 'nut extract', 'natural nut extract', 'artificial nut flavoring',
      'mortadella', 'pesto', 'nut pieces', 'chopped nuts',
    ],
    cautionIngredients: [
      // Cross-contamination risks
      'may contain tree nuts', 'processed in a facility that processes tree nuts',
      'manufactured on shared equipment with tree nuts',
      'peanuts', 'peanut butter', 'mixed nuts',
      // Foods often containing nuts
      'chocolate', 'candy', 'baked goods', 'cookies', 'cakes', 'pastries',
      'granola', 'trail mix', 'energy bars', 'protein bars', 'cereal bars',
      'ice cream', 'frozen desserts', 'nut clusters',
      // Ingredients that may contain nuts
      'natural flavoring', 'artificial flavoring', 'natural extracts',
      'ethnic foods', 'asian cuisine', 'indian cuisine', 'middle eastern cuisine',
      'vegetable oil', 'nut paste', 'nut pieces',
    ],
  ),

  // SOY ALLERGY PROFILE
  DietProfile(
    id: 'soy_allergy',
    name: 'Soy Allergy',
    avoidIngredients: [
      // Direct soy products
      'soy', 'soya', 'soybean', 'soybeans', 'edamame', 'tofu', 'tempeh',
      'miso', 'natto', 'okara', 'yuba', 'soy milk', 'soy cheese',
      'soy yogurt', 'soy ice cream', 'soy nuts', 'soy nut butter',
      // Soy protein
      'soy protein', 'soy protein isolate', 'soy protein concentrate',
      'textured soy protein', 'tsp', 'textured vegetable protein', 'tvp',
      'hydrolyzed soy protein', 'soy albumin',
      // Soy derivatives
      'soy sauce', 'tamari', 'shoyu', 'soy lecithin', 'lecithin',
      'soy flour', 'soy fiber', 'soy grits', 'soy sprouts',
      'soybean oil', 'soy oil', 'vegetable oil',
      // Asian sauces often containing soy
      'teriyaki sauce', 'worcestershire sauce', 'hoisin sauce',
      'oyster sauce', 'bean paste', 'bean sauce', 'miso paste',
      // Other soy products
      'mono-diglyceride', 'monoglyceride', 'diglyceride',
      'glycine max', 'soy isoflavones', 'soy peptides',
      'hydrolyzed vegetable protein', 'hvp', 'msg', 'monosodium glutamate',
    ],
    cautionIngredients: [
      // May contain soy
      'vegetable broth', 'vegetable stock', 'natural flavors',
      'artificial flavors', 'bouillon', 'vegetable gum',
      // Oils (refined soy oil often tolerated)
      'vegetable oil', 'cooking oil', 'mixed oil',
      // Lecithin (soy lecithin vs sunflower lecithin)
      'lecithin', 'e322',
      // Asian foods
      'asian cuisine', 'chinese food', 'japanese food', 'korean food',
      'stir fry', 'fried rice', 'noodles', 'ramen',
      // Processed foods
      'canned tuna', 'processed meat', 'deli meat', 'hot dogs',
      'sausage', 'veggie burger', 'meat alternative',
      'protein bar', 'energy bar', 'nutrition bar',
      // Baked goods
      'bread', 'rolls', 'crackers', 'cookies', 'baked goods',
      // Other
      'margarine', 'shortening', 'vitamin e', 'tocopherol',
      'mayonnaise', 'salad dressing', 'sauce', 'gravy',
      'chocolate', 'candy', 'protein powder', 'meal replacement',
    ],
  ),

  // SHELLFISH ALLERGY PROFILE
  DietProfile(
    id: 'shellfish_allergy',
    name: 'Shellfish Allergy',
    avoidIngredients: [
      // Crustaceans
      'shrimp', 'prawns', 'crab', 'lobster', 'crayfish', 'crawfish',
      'langoustine', 'krill', 'barnacle',
      // Mollusks
      'clam', 'clams', 'mussel', 'mussels', 'oyster', 'oysters',
      'scallop', 'scallops', 'squid', 'calamari', 'octopus',
      'snail', 'escargot', 'cockle', 'periwinkle', 'whelk',
      'abalone', 'limpet', 'sea urchin', 'sea cucumber',
      // Shellfish products
      'shrimp paste', 'shrimp sauce', 'crab paste', 'oyster sauce',
      'fish sauce', 'clam juice', 'clam broth', 'seafood stock',
      'seafood broth', 'lobster bisque', 'crab bisque',
      'imitation crab', 'surimi', 'seafood flavoring',
      // Ingredients derived from shellfish
      'shellfish extract', 'crustacean extract', 'molluscan extract',
      'glucosamine', 'chitosan', 'chitin',
      // Asian ingredients
      'belacan', 'shrimp powder', 'dried shrimp', 'bonito flakes',
    ],
    cautionIngredients: [
      // Cross-contamination risks
      'may contain shellfish', 'processed in facility with shellfish',
      'manufactured on shared equipment with shellfish',
      // Fish (separate allergy but often cross-contaminated)
      'fish', 'seafood', 'anchovies', 'sardines',
      // Foods often containing shellfish
      'asian cuisine', 'chinese food', 'thai food', 'vietnamese food',
      'sushi', 'paella', 'bouillabaisse', 'jambalaya', 'gumbo',
      'fried rice', 'pad thai', 'seafood pasta', 'cioppino',
      // Ingredients that may have shellfish
      'seafood flavoring', 'natural seafood flavoring', 'fish stock',
      'dashi', 'bouillon', 'caesar dressing', 'worcestershire sauce',
      // Supplements
      'omega-3 supplement', 'fish oil', 'calcium supplement',
      'glucosamine supplement', 'chondroitin',
      // Other
      'roe', 'caviar', 'fish eggs', 'seaweed salad',
    ],
  ),

  // EGG ALLERGY PROFILE
  DietProfile(
    id: 'egg_allergy',
    name: 'Egg Allergy',
    avoidIngredients: [
      // Eggs and egg products
      'egg', 'eggs', 'egg white', 'egg whites', 'egg yolk', 'egg yolks',
      'whole egg', 'dried egg', 'powdered egg', 'egg powder',
      'egg solids', 'egg substitute',
      // Egg proteins
      'albumin', 'egg albumin', 'ovalbumin', 'ovomucoid', 'ovomucin',
      'ovovitellin', 'livetin', 'lysozyme', 'globulin', 'vitellin',
      // Egg-containing products
      'mayonnaise', 'aioli', 'hollandaise', 'bearnaise', 'custard',
      'meringue', 'marshmallow', 'nougat', 'divinity', 'macaroon',
      'eggnog', 'nog', 'quiche', 'souffle', 'frittata', 'omelette',
      // Baked goods typically with eggs
      'french toast', 'pancakes', 'waffles', 'crepes', 'muffins',
      'cake', 'cupcake', 'cookie', 'brownie', 'biscuit',
      // Pasta with eggs
      'egg noodles', 'fresh pasta', 'homemade pasta',
      // Other egg-containing foods
      'meatloaf', 'meatballs', 'breaded', 'battered', 'tempura',
    ],
    cautionIngredients: [
      // May contain eggs
      'may contain eggs', 'processed in facility that processes eggs',
      'manufactured on shared equipment with eggs',
      // Foods that often contain eggs
      'baked goods', 'pastries', 'bread', 'crackers', 'pretzels',
      'pasta', 'noodles', 'ice cream', 'sherbet', 'frozen desserts',
      'candy', 'chocolate', 'fudge', 'caramel',
      // Processed meats
      'sausage', 'hot dogs', 'deli meat', 'processed meat',
      'imitation crab', 'surimi',
      // Ingredients that may contain eggs
      'lecithin', 'natural flavoring', 'artificial flavoring',
      'albumin', 'globulin', 'lysozyme',
      // Sauces and dressings
      'salad dressing', 'caesar dressing', 'tartar sauce',
      'sauce', 'gravy', 'cream sauce',
      // Other
      'protein powder', 'meal replacement', 'nutrition bar',
      'malt', 'malted', 'malted milk', 'malted milk powder',
      'simplesse', 'egg replacer',
    ],
  ),

  // FISH ALLERGY PROFILE
  DietProfile(
    id: 'fish_allergy',
    name: 'Fish Allergy',
    avoidIngredients: [
      // Common fish
      'fish', 'cod', 'bass', 'flounder', 'halibut', 'salmon', 'tuna',
      'trout', 'haddock', 'pollock', 'catfish', 'tilapia', 'mahi mahi',
      'snapper', 'grouper', 'perch', 'pike', 'sole', 'mackerel',
      'sardine', 'sardines', 'anchovy', 'anchovies', 'herring',
      'swordfish', 'shark', 'tilefish', 'marlin', 'orange roughy',
      // Fish products
      'fish oil', 'fish sauce', 'fish stock', 'fish broth',
      'worcestershire sauce', 'caesar dressing', 'fish paste',
      'fish extract', 'fish protein', 'fish gelatin',
      'surimi', 'imitation crab', 'fish roe', 'caviar', 'roe',
      'fish eggs', 'bottarga', 'taramasalata',
      // Asian fish products
      'fish balls', 'fish cake', 'kamaboko', 'fish tofu',
      'bonito', 'bonito flakes', 'katsuobushi', 'dashi',
      'nam pla', 'nuoc mam', 'patis', 'bagoong',
      // Other
      'anchovies in caesar dressing', 'imitation seafood',
    ],
    cautionIngredients: [
      // Cross-contamination
      'may contain fish', 'processed in facility that processes fish',
      'manufactured on shared equipment with fish',
      // Shellfish (separate allergy)
      'shellfish', 'shrimp', 'crab', 'lobster', 'clam', 'oyster',
      'seafood', 'seafood stock', 'seafood broth',
      // Asian cuisines
      'asian cuisine', 'japanese food', 'thai food', 'vietnamese food',
      'chinese food', 'korean food', 'sushi', 'sashimi',
      // Sauces and seasonings
      'worcestershire sauce', 'oyster sauce', 'hoisin sauce',
      'barbecue sauce', 'steak sauce', 'salad dressing',
      // Supplements and ingredients
      'omega-3', 'omega-3 supplement', 'fish oil supplement',
      'dha', 'epa', 'vitamin d3', 'calcium supplement',
      'gelatin', 'marine gelatin',
      // Foods
      'caesar salad', 'tapenade', 'caponata', 'putanesca',
      'ethnic foods', 'soup', 'broth', 'stock',
    ],
  ),

  // WHEAT ALLERGY PROFILE
  DietProfile(
    id: 'wheat_allergy',
    name: 'Wheat Allergy',
    avoidIngredients: [
      // Wheat and wheat products
      'wheat', 'whole wheat', 'wheat flour', 'enriched flour',
      'white flour', 'all-purpose flour', 'bread flour', 'cake flour',
      'pastry flour', 'self-rising flour', 'wheat starch',
      'wheat bran', 'wheat germ', 'wheat gluten', 'vital wheat gluten',
      // Wheat varieties
      'durum', 'durum wheat', 'semolina', 'spelt', 'kamut', 'einkorn',
      'farro', 'emmer', 'bulgur', 'couscous', 'farina', 'graham flour',
      'seitan', 'wheat berries', 'cracked wheat',
      // Products made with wheat
      'bread', 'pasta', 'noodles', 'ramen', 'udon', 'soba',
      'crackers', 'pretzels', 'cookies', 'cake', 'pie crust',
      'breadcrumbs', 'panko', 'croutons', 'stuffing', 'batter',
      'breading', 'flour tortilla', 'pita bread', 'naan',
      // Wheat protein
      'wheat protein', 'hydrolyzed wheat protein', 'wheat gluten',
      'textured wheat protein',
      // Other wheat-containing ingredients
      'malt', 'malted', 'barley malt', 'wheat malt',
      'brewer\'s yeast', 'wheat-based beer',
    ],
    cautionIngredients: [
      // May contain wheat
      'may contain wheat', 'processed in facility that processes wheat',
      'manufactured on shared equipment with wheat',
      // Gluten-containing grains
      'barley', 'rye', 'triticale', 'malt', 'malt extract',
      'malt flavoring', 'malt syrup', 'malt vinegar',
      // Oats (cross-contamination)
      'oats', 'oat flour', 'oatmeal', 'granola',
      // Starches and flours
      'modified food starch', 'modified starch', 'food starch',
      'natural starch', 'vegetable starch', 'cereal',
      // Sauces and seasonings
      'soy sauce', 'teriyaki sauce', 'worcestershire sauce',
      'sauce', 'gravy', 'soup', 'broth', 'bouillon',
      'seasoning', 'spice blend', 'coating mix',
      // Processed foods
      'processed meat', 'hot dogs', 'sausage', 'deli meat',
      'imitation crab', 'surimi', 'veggie burger',
      // Baked goods and snacks
      'baked goods', 'snack foods', 'chips', 'crackers',
      'cereal bars', 'granola bars', 'energy bars',
      // Ingredients
      'natural flavoring', 'artificial flavoring', 'caramel color',
      'dextrin', 'maltodextrin', 'yeast extract',
      'hydrolyzed vegetable protein', 'textured vegetable protein',
      // Beer and alcohol
      'beer', 'ale', 'lager', 'wheat beer', 'grain alcohol',
    ],
  ),

  // SESAME ALLERGY PROFILE
  DietProfile(
    id: 'sesame_allergy',
    name: 'Sesame Allergy',
    avoidIngredients: [
      // Sesame products
      'sesame', 'sesame seed', 'sesame seeds', 'sesame oil',
      'sesame paste', 'sesame butter', 'sesame flour',
      'sesame salt', 'sesame sticks',
      // Tahini and derivatives
      'tahini', 'tahina', 'tehina', 'tehini',
      // Middle Eastern products
      'halva', 'halvah', 'halwa', 'hummus', 'baba ghanoush',
      'baba ganoush', 'za\'atar', 'zaatar', 'gomasio', 'gomashio',
      // Asian products
      'gingelly oil', 'til', 'til oil', 'benne', 'benne seed',
      'simsim', 'sesamol', 'sesamum indicum',
      // Foods often containing sesame
      'sesame bagel', 'sesame bun', 'sesame roll', 'sesame bread',
      'sesame cracker', 'sesame chicken', 'sesame shrimp',
      'tahini sauce', 'tahini dressing',
    ],
    cautionIngredients: [
      // May contain sesame
      'may contain sesame', 'processed in facility that processes sesame',
      'manufactured on shared equipment with sesame',
      // Baked goods
      'bread', 'bagel', 'bun', 'roll', 'hamburger bun', 'hot dog bun',
      'crackers', 'breadsticks', 'pretzels', 'chips',
      // Middle Eastern and Asian cuisines
      'middle eastern food', 'mediterranean food', 'lebanese food',
      'israeli food', 'greek food', 'turkish food',
      'asian cuisine', 'chinese food', 'japanese food', 'korean food',
      'sushi', 'stir fry', 'fried rice',
      // Dips and spreads
      'hummus', 'dip', 'spread', 'sauce', 'dressing',
      // Toppings and coatings
      'everything bagel', 'multi-grain bread', 'seed mix',
      'trail mix', 'granola', 'protein bar', 'energy bar',
      // Ingredients
      'vegetable oil', 'mixed oil', 'natural flavoring',
      'artificial flavoring', 'spice blend', 'seasoning',
      // Other
      'falafel', 'tabbouleh', 'baba ghanoush', 'mediterranean salad',
      'margarine', 'butter substitute', 'processed cheese',
      'processed foods', 'ethnic foods',
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
