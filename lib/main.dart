import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOKO ASTRO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const ShoppingCartPage(),
    );
  }
}

// MODEL PRODUCT
class Product {
  String name;
  String brand;
  String category;
  int price;
  String image;
  String description;

  // QUANTITY AWAL = 0
  int quantity;

  int likes;
  bool liked;
  bool selected;

  Product({
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    this.quantity = 0,
    this.likes = 0,
    this.liked = false,
    this.selected = false,
  });
}

// MODEL ACCOUNT
class Account {
  String name;
  String email;

  // DATA KERANJANG MASING-MASING AKUN
  List<int> quantities;

  // DATA WISHLIST MASING-MASING AKUN
  List<bool> liked;

  // DATA LIKE MASING-MASING AKUN
  List<int> likes;

  Account({
    required this.name,
    required this.email,
    List<int>? quantities,
    List<bool>? liked,
    List<int>? likes,
  })  : quantities = quantities ?? [0, 0, 0, 0, 0, 0, 0, 0],
        liked = liked ?? [false, false, false, false, false, false, false, false],
        likes = likes ?? [0, 0, 0, 0, 0, 0, 0, 0];
}

// SHOPPING CART PAGE
class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() =>
      _ShoppingCartPageState();
}

class _ShoppingCartPageState
    extends State<ShoppingCartPage> {

  // PAGE
  // 0 = Beranda
  // 1 = Kategori
  // 2 = Keranjang
  // 3 = Akun
  // 4 = Search
  // 5 = Pembayaran
  // 6 = Wishlist
  // 7 = Detail Produk
  // 8 = Ganti Akun

  int currentPage = 0;

  int selectedBottomMenu = 0;

  // NAVIGASI DETAIL
  int previousPage = 0;
  int previousBottomMenu = 0;

  // NAVIGASI KATEGORI
  int categoryPreviousPage = 0;
  int categoryPreviousBottomMenu = 0;

  // NAVIGASI GANTI AKUN
  int accountPreviousPage = 3;
  int accountPreviousBottomMenu = 4;

  // DATA
  String message = '';

  String searchQuery = '';

  String selectedCategory = 'Semua';

  String selectedPaymentMethod = 'Transfer Bank';

  Product? selectedProduct;

  bool paymentSuccess = false;

  // AKUN AKTIF
  int selectedAccountIndex = 0;

  // KATEGORI
  final List<String> categories = [
    'Semua',
    'Audio',
    'Laptop',
    'Mouse',
  ];

  // METODE PEMBAYARAN
  final List<String> paymentMethods = [
    'Transfer Bank',
    'QRIS',
    'COD',
  ];

  // LIST ACCOUNT
  final List<Account> accounts = [
    Account(
      name: 'Christian Yohanes',
      email: 'Christian.825230093@stu.untar.ac.id',
    ),

    Account(
      name: 'Justin Weiry Halim',
      email: 'Justin.825240023@stu.untar.ac.id',
    ),

    Account(
      name: 'USER DEMO',
      email: 'USER DEMO@gmail.com',
    ),

    Account(
      name: 'USER DEMO 1',
      email: 'USER DEMO 1@gmail.com',
    ),

  ];

  // LIST PRODUCT
  final List<Product> products = [
    Product(
      name: 'FONIX REXUS F80',
      brand: 'REXUS',
      category: 'Audio',
      price: 600000,
      image: 'images/Fonix F80.jpg',
      description:
      'FONIX REXUS F80 merupakan '
          'headphone nirkabel yang cocok digunakan untuk '
          'mendengarkan musik, menonton video, belajar, '
          'dan aktivitas sehari-hari. Produk memiliki '
          'desain ringan dan nyaman digunakan.',
    ),

    Product(
      name: 'Laptop ASUS Vivobook',
      brand: 'ASUS',
      category: 'Laptop',
      price: 7500000,
      image: 'images/ASUS VIVOBOOK.jpg',
      description:
      'Laptop ASUS Vivobook merupakan laptop yang '
          'dapat digunakan untuk kebutuhan perkuliahan, '
          'pekerjaan, pemrograman, browsing, dan aktivitas '
          'produktivitas sehari-hari.',
    ),

    Product(
      name: 'LOGITECH G304',
      brand: 'Logitech',
      category: 'Mouse',
      price: 600000,
      image: 'images/LOGITECH G304.jpg',
      description:
      'LOGITECH G304 merupakan mouse '
          'nirkabel yang praktis digunakan untuk laptop '
          'maupun komputer. Desainnya sederhana dan '
          'cocok untuk penggunaan sehari-hari.',
    ),

    Product(
      name: 'Laptop ASUS ROG',
      brand: 'ASUS',
      category: 'Laptop',
      price: 14000000,
      image: 'images/ASUS ROG.jpg',
      description:
      'Laptop ASUS ROG merupakan laptop yang '
          'dapat digunakan untuk kebutuhan perkuliahan, '
          'pekerjaan, pemrograman, browsing, dan aktivitas '
          'produktivitas sehari-hari.',
    ),

    Product(
      name: 'MONITOR POLYTRON',
      brand: 'POLYTRON',
      category: 'Laptop',
      price: 2000000,
      image: 'images/MONITOR GAMING POLYTRON.jpg',
      description:
      'MONITOR POLYTRON merupakan Monitor '
          'nirkabel yang praktis digunakan untuk Gaming '
          'maupun komputer. Desainnya sederhana dan '
          'cocok untuk penggunaan sehari-hari.',
    ),

    Product(
      name: 'MONITOR MSI',
      brand: 'MSI',
      category: 'Laptop',
      price: 2000000,
      image: 'images/MONITOR MSI.jpg',
      description:
      'MONITOR MSI merupakan layar '
          'nirkabel yang praktis digunakan untuk Gaming '
          'maupun komputer. Desainnya sederhana dan '
          'cocok untuk gaming.',
    ),

    Product(
      name: 'LOGITECH G306',
      brand: 'Logitech',
      category: 'Mouse',
      price: 1200000,
      image: 'images/LOGITECH G306.jpg',
      description:
      'LOGITECH G306 merupakan mouse '
          'nirkabel yang praktis digunakan untuk laptop '
          'maupun komputer. Desainnya sederhana dan '
          'cocok untuk penggunaan sehari-hari.',
    ),

    Product(
      name: 'HyperX Pulsefire Saga Pro',
      brand: 'Hyper X',
      category: 'Mouse',
      price: 1000000,
      image: 'images/HyperX Pulsefire Saga Pro.jpg',
      description:
      'HyperX Pulsefire Saga Pro merupakan mouse '
          'nirkabel yang praktis digunakan untuk laptop '
          'maupun komputer. Desainnya sederhana dan '
          'cocok untuk penggunaan sehari-hari.',
    ),

  ];

  // TOTAL QUANTITY
  int get totalQuantity {
    int total = 0;

    for (Product product in products) {
      total += product.quantity;
    }

    return total;
  }

  // TOTAL HARGA
  int get totalPrice {
    int total = 0;

    for (Product product in products) {
      total += product.price * product.quantity;
    }

    return total;
  }

  // ONGKIR
  int get shippingCost {
    if (totalQuantity == 0) {
      return 0;
    }

    return 15000;
  }

  // GRAND TOTAL
  int get grandTotal {
    return totalPrice + shippingCost;
  }

  // PRODUK KERANJANG
  List<Product> get cartProducts {
    return products
        .where(
          (product) => product.quantity > 0,
    )
        .toList();
  }

  // PRODUK WISHLIST
  List<Product> get wishlistProducts {
    return products
        .where(
          (product) => product.liked,
    )
        .toList();
  }

  // SEARCH
  List<Product> get filteredProducts {
    List<Product> result = products;

    if (selectedCategory != 'Semua') {
      result = result
          .where(
            (product) =>
        product.category ==
            selectedCategory,
      )
          .toList();
    }

    if (searchQuery.trim().isNotEmpty) {
      String query =
      searchQuery.toLowerCase().trim();

      result = result
          .where(
            (product) =>
        product.name
            .toLowerCase()
            .contains(query) ||
            product.brand
                .toLowerCase()
                .contains(query) ||
            product.category
                .toLowerCase()
                .contains(query),
      )
          .toList();
    }

    return result;
  }

  // FORMAT RUPIAH
  String formatRupiah(int value) {
    return value
        .toString()
        .replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    );
  }

  // SIMPAN DATA AKUN AKTIF
  void _saveCurrentAccountData() {
    Account account =
    accounts[selectedAccountIndex];

    for (int i = 0;
    i < products.length;
    i++) {
      account.quantities[i] =
          products[i].quantity;

      account.liked[i] =
          products[i].liked;

      account.likes[i] =
          products[i].likes;
    }
  }

  // LOAD DATA AKUN
  void _loadAccountData(int accountIndex) {
    Account account =
    accounts[accountIndex];

    for (int i = 0;
    i < products.length;
    i++) {
      products[i].quantity =
      account.quantities[i];

      products[i].liked =
      account.liked[i];

      products[i].likes =
      account.likes[i];

      products[i].selected = false;
    }
  }

  // SELECT PRODUCT
  void selectProduct(int index) {
    setState(() {
      for (int i = 0;
      i < products.length;
      i++) {
        products[i].selected = false;
      }

      products[index].selected = true;

      message = 'Produk dipilih!';
    });
  }

  // DOUBLE TAP
  void doubleTapProduct(int index) {
    setState(() {
      for (int i = 0;
      i < products.length;
      i++) {
        products[i].selected = false;
      }

      products[index].quantity += 1;

      products[index].selected = true;

      message =
      'Jumlah ${products[index].name} +1';
    });

    _saveCurrentAccountData();
  }

  // LONG PRESS
  void longPressProduct(int index) {
    setState(() {
      if (products[index].selected) {
        products[index].selected = false;
      } else {
        for (int i = 0;
        i < products.length;
        i++) {
          products[i].selected = false;
        }

        products[index].selected = true;
      }
    });
  }

  // TAMBAH QUANTITY
  void addQuantity(int index) {
    setState(() {
      products[index].quantity += 1;
      if (products[index].quantity == 0) {
        message =
        '${products[index].name} Berhasil dimasukan kedalam Keranjang';
      } else {
        message =
        '${products[index].name} ditambahkan +1';
      }
    });

    _saveCurrentAccountData();
  }

  // KURANGI QUANTITY
  void removeQuantity(int index) {
    setState(() {
      if (products[index].quantity > 0) {
        products[index].quantity -= 1;

        if (products[index].quantity == 0) {
          message =
          '${products[index].name} Dihapus Dari Keranjang';
        } else {
          message =
          '${products[index].name} dikurangkan -1';
        }
      }
    });

    _saveCurrentAccountData();
  }

  // LIKE → WISHLIST
  void toggleLike(int index) {
    setState(() {
      products[index].liked =
      !products[index].liked;

      if (products[index].liked) {
        products[index].likes += 1;

        message =
        '${products[index].name} Berhasil DiMasukan Ke Wishlist';
      } else {
        if (products[index].likes > 0) {
          products[index].likes -= 1;
        }

        message =
        '${products[index].name} Berhasil Dihapus Dari Wishlist';
      }
    });

    _saveCurrentAccountData();
  }

  // DETAIL PRODUK
  void openProductDetail(Product product) {
    setState(() {
      previousPage = currentPage;
      previousBottomMenu =
          selectedBottomMenu;

      selectedProduct = product;

      currentPage = 7;

      message = '';
    });
  }

  // BACK DETAIL
  void backFromDetail() {
    setState(() {
      currentPage = previousPage;
      selectedBottomMenu =
          previousBottomMenu;

      selectedProduct = null;

      message = '';
    });
  }

  // TAMBAH KE KERANJANG DARI DETAIL
  void addToCartFromDetail(int qty) {
    if (selectedProduct != null) {
      setState(() {
        selectedProduct!.quantity += qty;
        message = '${selectedProduct!.name} Ditambahkan ke keranjang';
        amount = 1;
      });
    }
    _saveCurrentAccountData();
    currentPage = 0;
  }

  // TAMBAH KE KERANJANG DARI WISHLIST
  void addToCartFromWishlist(
      Product product,
      ) {
    setState(() {
      product.quantity += 1;

      message = '${product.name} Ditambahkan ke keranjang';
    });

    _saveCurrentAccountData();
  }

  // MENU BOTTOM
  void changeBottomMenu(int index) {
    setState(() {
      selectedBottomMenu = index;

      message = '';

      searchQuery = '';

      if (index == 0) {
        currentPage = 0;

        selectedCategory = 'Semua';
      }

      else if (index == 1) {
        categoryPreviousPage = 0;
        categoryPreviousBottomMenu = 0;

        currentPage = 1;
      }

      else if (index == 2) {
        currentPage = 2;
      }

      else if (index == 3) {
        previousPage = 0;
        previousBottomMenu = 0;

        currentPage = 6;
      }

      else if (index == 4) {
        currentPage = 3;
      }
    });
  }

  // SEARCH
  void openSearch() {
    setState(() {
      currentPage = 4;

      selectedCategory = 'Semua';

      searchQuery = '';

      message = '';
    });
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  // PILIH KATEGORI
  void selectCategory(
      String category,
      ) {
    setState(() {
      if (currentPage != 1) {
        categoryPreviousPage =
            currentPage;

        categoryPreviousBottomMenu =
            selectedBottomMenu;
      }

      selectedCategory = category;

      currentPage = 1;

      selectedBottomMenu = 1;

      searchQuery = '';

      message = '';
    });
  }

  // BACK DARI KATEGORI
  void backFromCategory() {
    setState(() {
      int targetPage =
      categoryPreviousPage == 1
          ? 0
          : categoryPreviousPage;

      currentPage = targetPage;

      selectedBottomMenu =
          categoryPreviousBottomMenu;

      if (currentPage == 0) {
        selectedCategory = 'Semua';
      }

      searchQuery = '';

      message = '';
    });
  }

  // WISHLIST PAGE
  void openWishlist() {
    setState(() {
      previousPage = currentPage;

      previousBottomMenu =
          selectedBottomMenu;

      currentPage = 6;

      selectedBottomMenu = 3;

      message = '';
    });
  }

  // CHECKOUT
  void openPayment() {
    if (totalQuantity == 0) {
      setState(() {
        message =
        'Keranjang masih kosong';
      });

      return;
    }

    setState(() {
      currentPage = 5;

      paymentSuccess = false;

      message = '';
    });
  }

  // PILIH PAYMENT
  void selectPaymentMethod(
      String method,
      ) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  // PROSES PAYMENT
  void processPayment() {
    if (totalQuantity == 0) {
      setState(() {
        message =
        'Keranjang masih kosong';
      });

      return;
    }

    setState(() {
      for (Product product in products) {
        product.quantity = 0;

        product.selected = false;
      }

      paymentSuccess = true;

      message = '';
    });

    _saveCurrentAccountData();
  }

  // BUKA GANTI AKUN
  void openAccountSwitcher() {
    setState(() {
      accountPreviousPage =
          currentPage;

      accountPreviousBottomMenu =
          selectedBottomMenu;

      currentPage = 8;

      message = '';
    });
  }

  // BACK GANTI AKUN
  void backFromAccountSwitcher() {
    setState(() {
      currentPage =
          accountPreviousPage;

      selectedBottomMenu =
          accountPreviousBottomMenu;

      message = '';
    });
  }

  // GANTI AKUN
  void selectAccount(int index) {
    if (index ==
        selectedAccountIndex) {
      setState(() {
        currentPage = 3;
        selectedBottomMenu = 4;

        message =
        'Anda sudah menggunakan akun ini';
      });

      return;
    }

    setState(() {
      // Simpan akun lama
      _saveCurrentAccountData();

      // Ganti akun
      selectedAccountIndex = index;

      // Load data akun baru
      _loadAccountData(index);

      currentPage = 3;

      selectedBottomMenu = 4;

      selectedCategory = 'Semua';

      searchQuery = '';

      message =
      'WELCOME BACK ${accounts[index].name} ';
    });
  }

  // BUILD
  @override
  Widget build(
      BuildContext context,
      ) {
    double screenWidth =
        MediaQuery.of(context).size.width;

    bool isSmallScreen =
        screenWidth < 380;

    double imageSize =
    isSmallScreen
        ? 70
        : 82;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: Stack(
                children: [
                  _buildCurrentPage(
                    imageSize,
                  ),

                  if (message.isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 16,
                      right: 16,
                      child:
                      _buildMessage(),
                    ),
                ],
              ),
            ),

            // TOTAL HANYA PADA KERANJANG
            if (currentPage == 2)
              _buildTotalSection(),

            // BOTTOM NAVIGATION
            if (currentPage != 5 &&
                currentPage != 7 &&
                currentPage != 8)
              _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // CURRENT PAGE
  Widget _buildCurrentPage(
      double imageSize,
      ) {
    if (currentPage == 0) {
      return _buildHomePage(
        imageSize,
      );
    }

    if (currentPage == 1) {
      return _buildCategoryPage(
        imageSize,
      );
    }

    if (currentPage == 2) {
      return _buildCartPage(
        imageSize,
      );
    }

    if (currentPage == 3) {
      return _buildAccountPage();
    }

    if (currentPage == 4) {
      return _buildSearchPage(
        imageSize,
      );
    }

    if (currentPage == 5) {
      return _buildPaymentPage();
    }

    if (currentPage == 6) {
      return _buildWishlistPage(
        imageSize,
      );
    }

    if (currentPage == 8) {
      return _buildAccountSwitcherPage();
    }

    return _buildProductDetailPage();
  }

  // HEADER
  Widget _buildHeader() {
    String title =
        'ASTRO';

    if (currentPage == 1) {
      title = 'Kategori';
    }

    else if (currentPage == 2) {
      title = 'Keranjang';
    }

    else if (currentPage == 3) {
      title = 'Akun Saya';
    }

    else if (currentPage == 4) {
      title = 'Pencarian';
    }

    else if (currentPage == 5) {
      title = 'Pembayaran';
    }

    else if (currentPage == 6) {
      title = 'Wishlist';
    }

    else if (currentPage == 7) {
      title = 'Detail Produk';
    }

    else if (currentPage == 8) {
      title = 'Ganti Akun';
    }

    bool showBack =
        currentPage == 1 ||
            currentPage == 4 ||
            currentPage == 5 ||
            currentPage == 6 ||
            currentPage == 7 ||
            currentPage == 8;

    bool showSearch =
        currentPage != 4 &&
            currentPage != 5 &&
            currentPage != 7 &&
            currentPage != 8;

    return Container(
      padding:
      const EdgeInsets.fromLTRB(
        14,
        10,
        14,
        10,
      ),
      color: Colors.blue,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (currentPage == 1) {
                backFromCategory();
              }

              else if (currentPage == 5) {
                setState(() {
                  currentPage = 2;

                  selectedBottomMenu =
                  2;

                  message = '';
                });
              }

              else if (currentPage == 4) {
                setState(() {
                  currentPage = 0;

                  selectedBottomMenu =
                  0;

                  searchQuery = '';

                  message = '';
                });
              }

              else if (currentPage == 6) {
                setState(() {
                  currentPage =
                  previousPage == 6
                      ? 0
                      : previousPage;

                  selectedBottomMenu =
                  previousPage == 6
                      ? 0
                      : previousBottomMenu;

                  message = '';
                });
              }

              else if (currentPage == 7) {
                backFromDetail();
              }

              else if (currentPage == 8) {
                backFromAccountSwitcher();
              }
            },
            child: Icon(
              showBack
                  ? Icons.arrow_back
                  : Icons.shopping_cart,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  currentPage == 0
                      ? 'Belanja lebih mudah setiap hari'
                      : 'Pilih menu sesuai kebutuhan',
                  style:
                  const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          if (showSearch)
            GestureDetector(
              onTap: openSearch,
              child: const Padding(
                padding:
                EdgeInsets.all(3),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // HOME
  Widget _buildHomePage(
      double imageSize,
      ) {
    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: Column(
        children: [
          _buildHomeBanner(),

          const SizedBox(height: 14),

          _buildHomeCategories(),

          const SizedBox(height: 16),

          _buildSectionTitle(
            'List Product',
            'Produk yang tersedia di toko',
          ),

          const SizedBox(height: 8),

          _buildResponsiveProductList(
            products,
            imageSize,
          ),
        ],
      ),
    );
  }

  // BANNER HOME
  Widget _buildHomeBanner() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient:
        const LinearGradient(
          colors: [
            Color(0xFF1565C0),
            Color(0xFF42A5F5),
          ],
        ),
        borderRadius:
        BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 130,
              height: 130,
              decoration:
              const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                const Text(
                  'BELANJA MUDAH DENGAN ASTRO',
                  style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Temukan produk favoritmu',
                  style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      categoryPreviousPage =
                      0;

                      categoryPreviousBottomMenu =
                      0;

                      currentPage = 1;

                      selectedBottomMenu =
                      1;

                      selectedCategory =
                      'Semua';

                      message = '';
                    });
                  },
                  child: Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration:
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                    ),
                    child:
                    const Text(
                      'Lihat Produk',
                      style:
                      TextStyle(
                        color: Colors.blue,
                        fontSize: 11,
                        fontWeight:
                        FontWeight.bold,
                      ),
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

  // HOME CATEGORY
  Widget _buildHomeCategories() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategori',
          style:
          TextStyle(
            fontSize: 16,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 85,
          child: ListView(
            scrollDirection:
            Axis.horizontal,
            children: [
              _buildCategoryHomeItem(
                'Semua',
                Icons.apps,
              ),

              _buildCategoryHomeItem(
                'Audio',
                Icons.headphones,
              ),

              _buildCategoryHomeItem(
                'Laptop',
                Icons.laptop_mac,
              ),

              _buildCategoryHomeItem(
                'Mouse',
                Icons.mouse,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryHomeItem(
      String category,
      IconData icon,
      ) {
    return GestureDetector(
      onTap: () =>
          selectCategory(category),
      child: Container(
        width: 78,
        margin:
        const EdgeInsets.only(
          right: 8,
        ),
        decoration:
        BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(12),
          border: Border.all(
            color:
            selectedCategory ==
                category
                ? Colors.blue
                : Colors
                .grey
                .shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
              selectedCategory ==
                  category
                  ? Colors.blue
                  : Colors.grey,
              size: 27,
            ),

            const SizedBox(height: 5),

            Text(
              category,
              style:
              TextStyle(
                fontSize: 10,
                fontWeight:
                FontWeight.bold,
                color:
                selectedCategory ==
                    category
                    ? Colors.blue
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // KATEGORI PAGE
  Widget _buildCategoryPage(
      double imageSize,
      ) {
    List<Product>
    categoryProducts =
    selectedCategory ==
        'Semua'
        ? products
        : products
        .where(
          (product) =>
      product.category ==
          selectedCategory,
    )
        .toList();

    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Pilih Kategori',
            'Tekan kategori untuk melihat produknya',
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (String category
              in categories)
                GestureDetector(
                  onTap: () =>
                      selectCategory(
                        category,
                      ),
                  child: Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration:
                    BoxDecoration(
                      color:
                      selectedCategory ==
                          category
                          ? Colors.blue
                          : Colors.white,
                      borderRadius:
                      BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color:
                        selectedCategory ==
                            category
                            ? Colors.blue
                            : Colors
                            .grey
                            .shade300,
                      ),
                    ),
                    child: Text(
                      category,
                      style:
                      TextStyle(
                        color:
                        selectedCategory ==
                            category
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 12,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            selectedCategory ==
                'Semua'
                ? 'Semua Produk'
                : 'Produk $selectedCategory',
            style:
            const TextStyle(
              fontSize: 15,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          if (categoryProducts.isEmpty)
            _buildEmptyResult(
              icon:
              Icons.inventory_2_outlined,
              title:
              'Produk belum tersedia',
            )
          else
            _buildResponsiveProductList(
              categoryProducts,
              imageSize,
            ),
        ],
      ),
    );
  }

  // KERANJANG
  Widget _buildCartPage(
      double imageSize,
      ) {
    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: Column(
        children: [
          _buildSectionTitle(
            'Produk di Keranjang',
            'Produk dengan jumlah lebih dari 0',
          ),

          const SizedBox(height: 8),

          if (cartProducts.isEmpty)
            _buildEmptyCart()
          else
            _buildResponsiveProductList(
              cartProducts,
              imageSize,
            ),
        ],
      ),
    );
  }

  // WISHLIST
  Widget _buildWishlistPage(
      double imageSize,
      ) {
    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Wishlist Saya',
            'Produk yang Anda sukai',
          ),

          const SizedBox(height: 10),

          if (wishlistProducts.isEmpty)
            _buildEmptyWishlist()
          else
            for (Product product
            in wishlistProducts)
              _buildWishlistCard(
                product,
              ),
        ],
      ),
    );
  }

  // EMPTY WISHLIST
  Widget _buildEmptyWishlist() {
    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.all(30),
      decoration:
      BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.favorite_border,
            color: Colors.grey,
            size: 55,
          ),

          const SizedBox(height: 10),

          const Text(
            'Wishlist masih kosong',
            style: TextStyle(
              fontWeight:
              FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Tekan ikon hati pada produk',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 15),

          GestureDetector(
            onTap: () {
              setState(() {
                currentPage = 0;

                selectedBottomMenu = 0;

                selectedCategory =
                'Semua';
              });
            },
            child: Container(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration:
              BoxDecoration(
                color: Colors.blue,
                borderRadius:
                BorderRadius.circular(
                  8,
                ),
              ),
              child:
              const Text(
                'Mulai Belanja',
                style:
                TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WISHLIST CARD
  Widget _buildWishlistCard(
      Product product,
      ) {
    int index =
    products.indexOf(product);

    return GestureDetector(
      onTap: () =>
          openProductDetail(
            product,
          ),
      child: Container(
        margin:
        const EdgeInsets.only(
          bottom: 10,
        ),
        padding:
        const EdgeInsets.all(10),
        decoration:
        BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(12),
          border: Border.all(
            color:
            Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              padding:
              const EdgeInsets.all(7),
              decoration:
              BoxDecoration(
                color:
                const Color(
                  0xFFF1F4F8,
                ),
                borderRadius:
                BorderRadius.circular(
                  10,
                ),
              ),
              child: Image.asset(
                product.image,
                fit:
                BoxFit.contain,
                errorBuilder:
                    (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return Icon(
                    _productIcon(
                      index,
                    ),
                    color:
                    Colors.blueGrey,
                    size: 38,
                  );
                },
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style:
                    const TextStyle(
                      fontSize: 13,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    product.brand,
                    style:
                    const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Rp ${formatRupiah(product.price)}',
                    style:
                    const TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            addToCartFromWishlist(
                              product,
                            ),
                        child: Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration:
                          BoxDecoration(
                            color:
                            Colors.blue,
                            borderRadius:
                            BorderRadius
                                .circular(
                              7,
                            ),
                          ),
                          child:
                          const Text(
                            'Tambah ke Keranjang',
                            style:
                            TextStyle(
                              color:
                              Colors.white,
                              fontSize: 10,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      if (product
                          .quantity >
                          0)
                        Padding(
                          padding:
                          const EdgeInsets
                              .only(
                            left: 8,
                          ),
                          child:
                          Text(
                            '${product.quantity} di keranjang',
                            style:
                            const TextStyle(
                              color:
                              Colors.grey,
                              fontSize:
                              9,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 5,
            ),

            GestureDetector(
              onTap: () =>
                  toggleLike(index),
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DETAIL PRODUK
  int amount = 1;
  Widget _buildProductDetailPage() {
    if (selectedProduct == null) {
      return const Center(
        child:
        Text(
          'Produk tidak tersedia',
        ),
      );
    }

    Product product = selectedProduct!;

    int index = products.indexOf(product);

    // tambah produk dari menu detail
    void increaseDetailQuantity() {
      setState(() {
        amount++;
      });
    }

    // kurangi produk dari menu detail
    void decreaseDetailQuantity() {
      if (amount > 1) {
        setState(() {
          amount--;
        });
      }
    }

    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        14,
        14,
        14,
        20,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 260,
            padding:
            const EdgeInsets.all(
              20,
            ),
            decoration:
            BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(
                15,
              ),
            ),
            child: Image.asset(
              product.image,
              fit:
              BoxFit.contain,
              errorBuilder:
                  (
                  context,
                  error,
                  stackTrace,
                  ) {
                return Icon(
                  _productIcon(
                    index,
                  ),
                  color:
                  Colors.blueGrey,
                  size: 100,
                );
              },
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Text(
            product.name,
            style:
            const TextStyle(
              fontSize: 21,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            product.brand,
            style:
            const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              GestureDetector(
                onTap: () =>
                    toggleLike(
                      index,
                    ),
                child: Icon(
                  product.liked
                      ? Icons.favorite
                      : Icons
                      .favorite_border,
                  color:
                  product.liked
                      ? Colors.red
                      : Colors.black54,
                  size: 27,
                ),
              ),

              const SizedBox(
                width: 5,
              ),

              Text(
                '${product.likes} Like',
                style:
                const TextStyle(
                  fontSize: 12,
                ),
              ),

              const Spacer(),

              Container(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration:
                BoxDecoration(
                  color:
                  Colors.blue.shade50,
                  borderRadius:
                  BorderRadius.circular(
                    7,
                  ),
                ),
                child: Text(
                  product.category,
                  style:
                  const TextStyle(
                    color:
                    Colors.blue,
                    fontSize: 11,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),

          Text(
            'Rp ${formatRupiah(product.price)}',
            style:
            const TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          const Text(
            'Deskripsi Produk',
            style:
            TextStyle(
              fontSize: 17,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.all(
              14,
            ),
            decoration:
            BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),
            child:
            Text(
              product.description,
              style:
              const TextStyle(
                color:
                Colors.black87,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          const Text(
            'Jumlah Produk',
            style:
            TextStyle(
              fontSize: 15,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Row(
            children: [
              _buildQuantityButton(
                icon: Icons.remove,
                onTap: decreaseDetailQuantity,
              ),

              Container(
                width: 45,
                alignment: Alignment.center,
                child: Text(
                  '$amount',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              _buildQuantityButton(
                icon: Icons.add,
                onTap: increaseDetailQuantity,
                filled: true,
              ),
            ],
          ),

          const SizedBox(
            height: 18,
          ),

          if (amount > 0)
            Container(
              width: double.infinity,
              margin:
              const EdgeInsets.only(
                bottom: 12,
              ),
              padding:
              const EdgeInsets.all(
                12,
              ),
              decoration:
              BoxDecoration(
                color:
                Colors.blue.shade50,
                borderRadius:
                BorderRadius.circular(
                  10,
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child:
                    Text(
                      'Subtotal',
                      style:
                      TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  Text(
                    'Rp ${formatRupiah(product.price * amount)}',
                    style:
                    const TextStyle(
                      color:
                      Colors.blue,
                      fontSize: 13,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          GestureDetector(
            onTap: () => addToCartFromDetail(amount),
            child: Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(
                vertical: 14,
              ),
              alignment:
              Alignment.center,
              decoration:
              BoxDecoration(
                color:
                Colors.blue,
                borderRadius:
                BorderRadius.circular(
                  10,
                ),
              ),
              child:
              const Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  Icon(
                    Icons
                        .shopping_cart_outlined,
                    color:
                    Colors.white,
                    size: 20,
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Text(
                    'Tambah ke Keranjang',
                    style:
                    TextStyle(
                      color:
                      Colors.white,
                      fontSize: 14,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ACCOUNT
  Widget _buildAccountPage() {
    Account account =
    accounts[selectedAccountIndex];

    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        16,
        18,
        16,
        20,
      ),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration:
            const BoxDecoration(
              color:
              Colors.deepPurple,
              shape:
              BoxShape.circle,
            ),
            child:
            const Icon(
              Icons.person,
              color:
              Colors.white,
              size: 52,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            account.name,
            textAlign:
            TextAlign.center,
            style:
            const TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            account.email,
            textAlign:
            TextAlign.center,
            style:
            const TextStyle(
              color:
              Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          _buildAccountMenu(
            icon:
            Icons.receipt_long_outlined,
            title:
            'Pesanan Saya',
          ),

          GestureDetector(
            onTap: openWishlist,
            child:
            Container(
              width:
              double.infinity,
              margin:
              const EdgeInsets
                  .only(
                bottom: 10,
              ),
              padding:
              const EdgeInsets.all(
                14,
              ),
              decoration:
              BoxDecoration(
                color:
                Colors.white,
                borderRadius:
                BorderRadius.circular(
                  12,
                ),
                border:
                Border.all(
                  color:
                  const Color(
                    0xFFE0E0E0,
                  ),
                ),
              ),
              child:
              Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color:
                    Colors.red,
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child:
                    Text(
                      'Wishlist (${wishlistProducts.length})',
                      style:
                      const TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right,
                    color:
                    Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          _buildAccountMenu(
            icon:
            Icons.payment,
            title:
            'Saldo Saya',
          ),

          _buildAccountMenu(
            icon:
            Icons.settings_applications,
            title:
            'Info Version',
          ),

          const SizedBox(
            height: 5,
          ),

          // GANTI AKUN
          GestureDetector(
            onTap:
            openAccountSwitcher,
            child:
            Container(
              width:
              double.infinity,
              padding:
              const EdgeInsets.all(
                14,
              ),
              decoration:
              BoxDecoration(
                color:
                Colors.blue,
                borderRadius:
                BorderRadius.circular(
                  12,
                ),
              ),
              child:
              const Row(
                children: [
                  Icon(
                    Icons.swap_horiz,
                    color:
                    Colors.white,
                  ),

                  SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child:
                    Text(
                      'Ganti Akun',
                      style:
                      TextStyle(
                        color:
                        Colors.white,
                        fontSize:
                        13,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    color:
                    Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ACCOUNT MENU
  Widget _buildAccountMenu({
    required IconData icon,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          message =
          '$title dipilih';
        });
      },
      child: Container(
        width: double.infinity,
        margin:
        const EdgeInsets.only(
          bottom: 10,
        ),
        padding:
        const EdgeInsets.all(
          14,
        ),
        decoration:
        BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(
            12,
          ),
          border: Border.all(
            color:
            const Color(
              0xFFE0E0E0,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:
              Colors.blue,
            ),

            const SizedBox(
              width: 12,
            ),

            Expanded(
              child:
              Text(
                title,
                style:
                const TextStyle(
                  fontSize: 13,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color:
              Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // ACCOUNT SWITCHER
  Widget _buildAccountSwitcherPage() {
    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        14,
        14,
        14,
        20,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Pilih Akun',
            'Pilih akun yang ingin digunakan',
          ),

          const SizedBox(
            height: 15,
          ),

          for (int i = 0;
          i < accounts.length;
          i++)
            GestureDetector(
              onTap: () =>
                  selectAccount(i),
              child:
              Container(
                width:
                double.infinity,
                margin:
                const EdgeInsets
                    .only(
                  bottom: 10,
                ),
                padding:
                const EdgeInsets.all(
                  14,
                ),
                decoration:
                BoxDecoration(
                  color:
                  Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                  border:
                  Border.all(
                    color:
                    selectedAccountIndex ==
                        i
                        ? Colors.blue
                        : Colors
                        .grey
                        .shade300,
                    width:
                    selectedAccountIndex ==
                        i
                        ? 2
                        : 1,
                  ),
                ),
                child:
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration:
                      const BoxDecoration(
                        color:
                        Colors.deepPurple,
                        shape:
                        BoxShape.circle,
                      ),
                      child:
                      const Icon(
                        Icons.person,
                        color:
                        Colors.white,
                        size: 28,
                      ),
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    Expanded(
                      child:
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            accounts[i]
                                .name,
                            style:
                            const TextStyle(
                              fontSize:
                              14,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          Text(
                            accounts[i]
                                .email,
                            maxLines:
                            1,
                            overflow:
                            TextOverflow
                                .ellipsis,
                            style:
                            const TextStyle(
                              color:
                              Colors.grey,
                              fontSize:
                              11,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          if (selectedAccountIndex ==
                              i)
                            const Text(
                              'Akun sedang digunakan',
                              style:
                              TextStyle(
                                color:
                                Colors.blue,
                                fontSize:
                                10,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),

                    Icon(
                      selectedAccountIndex ==
                          i
                          ? Icons
                          .radio_button_checked
                          : Icons
                          .radio_button_off,
                      color:
                      selectedAccountIndex ==
                          i
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(
            height: 10,
          ),

          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.all(
              12,
            ),
            decoration:
            BoxDecoration(
              color:
              Colors.blue.shade50,
              borderRadius:
              BorderRadius.circular(
                10,
              ),
            ),
            child:
            const Row(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Icon(
                  Icons.info_outline,
                  color:
                  Colors.blue,
                  size: 20,
                ),

                SizedBox(
                  width: 8,
                ),

                Expanded(
                  child:
                  Text(
                    'Setiap akun memiliki data keranjang dan Wishlist sendiri selama aplikasi sedang berjalan.',
                    style:
                    TextStyle(
                      color:
                      Colors.blueGrey,
                      fontSize:
                      11,
                      height:
                      1.4,
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

  // SEARCH
  Widget _buildSearchPage(
      double imageSize,
      ) {
    List<Product> results =
        filteredProducts;

    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: Column(
        children: [
          Container(
            padding:
            const EdgeInsets
                .symmetric(
              horizontal: 12,
            ),
            decoration:
            BoxDecoration(
              color:
              Colors.white,
              borderRadius:
              BorderRadius.circular(
                10,
              ),
              border:
              Border.all(
                color:
                Colors.grey.shade300,
              ),
            ),
            child:
            Row(
              children: [
                const Icon(
                  Icons.search,
                  color:
                  Colors.grey,
                ),

                const SizedBox(
                  width: 8,
                ),

                Expanded(
                  child:
                  TextField(
                    autofocus:
                    true,
                    onChanged:
                    updateSearch,
                    decoration:
                    const InputDecoration(
                      hintText:
                      'Cari produk...',
                      border:
                      InputBorder.none,
                    ),
                  ),
                ),

                if (searchQuery
                    .isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        searchQuery =
                        '';
                      });
                    },
                    child:
                    const Icon(
                      Icons.close,
                      color:
                      Colors.grey,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          Align(
            alignment:
            Alignment.centerLeft,
            child: Text(
              searchQuery.isEmpty
                  ? 'Masukkan Nama Produk Yang anda Cari'
                  : 'Hasil pencarian: $searchQuery',
              style:
              const TextStyle(
                fontSize: 14,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          if (searchQuery
              .isNotEmpty &&
              results.isEmpty)
            _buildEmptyResult(
              icon:
              Icons.search_off,
              title:
              'Produk tidak ditemukan',
            )
          else if (searchQuery
              .isNotEmpty)
            _buildResponsiveProductList(
              results,
              imageSize,
            ),
        ],
      ),
    );
  }

  // PAYMENT
  Widget _buildPaymentPage() {
    if (paymentSuccess) {
      return _buildPaymentSuccessPage();
    }

    return SingleChildScrollView(
      padding:
      const EdgeInsets.fromLTRB(
        14,
        14,
        14,
        20,
      ),
      child:
      Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Pesanan',
            style:
            TextStyle(
              fontSize: 17,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Container(
            width:
            double.infinity,
            padding:
            const EdgeInsets.all(
              14,
            ),
            decoration:
            BoxDecoration(
              color:
              Colors.white,
              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),
            child:
            Column(
              children: [
                for (Product product
                in cartProducts)
                  Padding(
                    padding:
                    const EdgeInsets
                        .only(
                      bottom: 9,
                    ),
                    child:
                    Row(
                      children: [
                        Expanded(
                          child:
                          Text(
                            '${product.name} x${product.quantity}',
                            style:
                            const TextStyle(
                              fontSize:
                              12,
                            ),
                          ),
                        ),

                        Text(
                          'Rp ${formatRupiah(product.price * product.quantity)}',
                          style:
                          const TextStyle(
                            fontSize:
                            12,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                const Divider(),

                _buildPaymentRow(
                  'Subtotal',
                  totalPrice,
                ),

                const SizedBox(
                  height: 6,
                ),

                _buildPaymentRow(
                  'Ongkir',
                  shippingCost,
                ),

                const SizedBox(
                  height: 6,
                ),

                const Divider(),

                _buildPaymentRow(
                  'Total Pembayaran',
                  grandTotal,
                  highlight:
                  true,
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          const Text(
            'Metode Pembayaran',
            style:
            TextStyle(
              fontSize: 17,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          for (String method
          in paymentMethods)
            GestureDetector(
              onTap: () =>
                  selectPaymentMethod(
                    method,
                  ),
              child:
              Container(
                margin:
                const EdgeInsets
                    .only(
                  bottom: 9,
                ),
                padding:
                const EdgeInsets.all(
                  13,
                ),
                decoration:
                BoxDecoration(
                  color:
                  Colors.white,
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                  border:
                  Border.all(
                    color:
                    selectedPaymentMethod ==
                        method
                        ? Colors.blue
                        : Colors
                        .grey
                        .shade300,
                    width:
                    selectedPaymentMethod ==
                        method
                        ? 2
                        : 1,
                  ),
                ),
                child:
                Row(
                  children: [
                    Icon(
                      selectedPaymentMethod ==
                          method
                          ? Icons
                          .radio_button_checked
                          : Icons
                          .radio_button_off,
                      color:
                      selectedPaymentMethod ==
                          method
                          ? Colors.blue
                          : Colors.grey,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child:
                      Text(
                        method,
                        style:
                        const TextStyle(
                          fontSize:
                          13,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(
            height: 10,
          ),

          Container(
            width:
            double.infinity,
            padding:
            const EdgeInsets.all(
              13,
            ),
            decoration:
            BoxDecoration(
              color:
              Colors.blue.shade50,
              borderRadius:
              BorderRadius.circular(
                10,
              ),
            ),
            child:
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color:
                  Colors.blue,
                ),

                const SizedBox(
                  width: 8,
                ),

                Expanded(
                  child:
                  Text(
                    selectedPaymentMethod ==
                        'Transfer Bank'
                        ? 'Pembayaran dilakukan melalui transfer bank.'
                        : selectedPaymentMethod ==
                        'QRIS'
                        ? 'Scan QRIS untuk menyelesaikan pembayaran.'
                        : 'Pembayaran dilakukan ketika barang diterima.',
                    style:
                    const TextStyle(
                      color:
                      Colors.blueGrey,
                      fontSize:
                      11,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          GestureDetector(
            onTap:
            processPayment,
            child:
            Container(
              width:
              double.infinity,
              padding:
              const EdgeInsets
                  .symmetric(
                vertical: 14,
              ),
              alignment:
              Alignment.center,
              decoration:
              BoxDecoration(
                color:
                Colors.blue,
                borderRadius:
                BorderRadius.circular(
                  10,
                ),
              ),
              child:
              Text(
                'Bayar Rp ${formatRupiah(grandTotal)}',
                style:
                const TextStyle(
                  color:
                  Colors.white,
                  fontSize:
                  14,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PAYMENT ROW
  Widget _buildPaymentRow(
      String title,
      int value, {
        bool highlight = false,
      }) {
    return Row(
      children: [
        Expanded(
          child:
          Text(
            title,
            style:
            TextStyle(
              fontSize:
              highlight
                  ? 14
                  : 12,
              fontWeight:
              highlight
                  ? FontWeight
                  .bold
                  : FontWeight
                  .normal,
            ),
          ),
        ),

        Text(
          'Rp ${formatRupiah(value)}',
          style:
          TextStyle(
            color:
            highlight
                ? Colors.blue
                : Colors.black87,
            fontSize:
            highlight
                ? 15
                : 12,
            fontWeight:
            highlight
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // PAYMENT SUCCESS
  Widget _buildPaymentSuccessPage() {
    return SingleChildScrollView(
      padding:
      const EdgeInsets.all(
        20,
      ),
      child:
      Container(
        width:
        double.infinity,
        padding:
        const EdgeInsets.all(
          25,
        ),
        decoration:
        BoxDecoration(
          color:
          Colors.white,
          borderRadius:
          BorderRadius.circular(
            15,
          ),
        ),
        child:
        Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration:
              const BoxDecoration(
                color:
                Color(0xFFE8F5E9),
                shape:
                BoxShape.circle,
              ),
              child:
              const Icon(
                Icons.check_circle,
                color:
                Colors.green,
                size:
                60,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            const Text(
              'Pembayaran Berhasil',
              textAlign:
              TextAlign.center,
              style:
              TextStyle(
                fontSize:
                20,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              'Pembayaran menggunakan '
                  '$selectedPaymentMethod telah berhasil diproses.',
              textAlign:
              TextAlign.center,
              style:
              const TextStyle(
                color:
                Colors.grey,
                fontSize:
                12,
                height:
                1.4,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              width:
              double.infinity,
              padding:
              const EdgeInsets.all(
                13,
              ),
              decoration:
              BoxDecoration(
                color:
                Colors.blue.shade50,
                borderRadius:
                BorderRadius.circular(
                  10,
                ),
              ),
              child:
              const Text(
                'Pesanan telah dibuat dan keranjang sudah dikosongkan.',
                textAlign:
                TextAlign.center,
                style:
                TextStyle(
                  color:
                  Colors.blueGrey,
                  fontSize:
                  11,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = 0;

                  selectedBottomMenu =
                  0;

                  paymentSuccess =
                  false;

                  selectedProduct =
                  null;
                });
              },
              child:
              Container(
                width:
                double.infinity,
                padding:
                const EdgeInsets
                    .symmetric(
                  vertical: 13,
                ),
                alignment:
                Alignment.center,
                decoration:
                BoxDecoration(
                  color:
                  Colors.blue,
                  borderRadius:
                  BorderRadius.circular(
                    10,
                  ),
                ),
                child:
                const Text(
                  'Kembali ke Beranda',
                  style:
                  TextStyle(
                    color:
                    Colors.white,
                    fontWeight:
                    FontWeight.bold,
                    fontSize:
                    13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // RESPONSIVE PRODUCT LIST
  Widget _buildResponsiveProductList(
      List<Product> productList,
      double imageSize,
      ) {
    final double screenWidth =
        MediaQuery.of(context).size.width;

    // Narrow screen = normal vertical list.
    if (screenWidth < 700) {
      return Column(
        children: [
          for (Product product in productList)
            _buildProductCard(
              product: product,
              index: products.indexOf(product),
              imageSize: imageSize,
            ),
        ],
      );
    }

    // Wide screen = responsive grid.
    int columns = 2;
    if (screenWidth >= 1100) {
      columns = 3;
    }
    if (screenWidth >= 1450) {
      columns = 4;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final Product product = productList[index];

        return _buildProductCard(
          product: product,
          index: products.indexOf(product),
          imageSize: imageSize,
        );
      },
    );
  }

  // PRODUCT CARD
  Widget _buildProductCard({
    required Product product,
    required int index,
    required double imageSize,
  }) {
    final bool isGrid =
        MediaQuery.of(context).size.width >= 700;

    return GestureDetector(
      // TAP = DETAIL
      onTap: () => openProductDetail(product),

      // DOUBLE TAP = +1
      onDoubleTap: () => longPressProduct(index),

      // LONG PRESS = SELECT
      onLongPress: () => doubleTapProduct(index),

      child: Container(
        margin: EdgeInsets.only(
          bottom: isGrid ? 0 : 10,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: product.selected
                ? Colors.blue
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: isGrid
            ? _buildGridProductContent(
          product,
          index,
          imageSize,
        )
            : _buildListProductContent(
          product,
          index,
          imageSize,
        ),
      ),
    );
  }

  // NORMAL / PHONE PRODUCT CARD
  Widget _buildListProductContent(
      Product product,
      int index,
      double imageSize,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProductImage(product, index, imageSize),
        const SizedBox(width: 10),
        Expanded(
          child: _buildProductInfo(
            product,
            index,
            showQuantity: currentPage == 2,
          ),
        ),
      ],
    );
  }

  // GRID / DESKTOP PRODUCT CARD
  Widget _buildGridProductContent(
      Product product,
      int index,
      double imageSize,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: _buildProductImage(
              product,
              index,
              imageSize + 35,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildProductInfo(
          product,
          index,
          showQuantity: currentPage == 2,
        ),
      ],
    );
  }

  Widget _buildProductImage(
      Product product,
      int index,
      double size,
      ) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        product.image,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            _productIcon(index),
            color: Colors.blueGrey,
            size: 44,
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(
      Product product,
      int index, {
        required bool showQuantity,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          product.brand,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Rp ${formatRupiah(product.price)}',
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            GestureDetector(
              onTap: () => toggleLike(index),
              child: Icon(
                product.liked
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: product.liked
                    ? Colors.red
                    : Colors.black54,
                size: 20,
              ),
            ),

            const SizedBox(width: 4),

            Text(
              '${product.likes}',
              style: const TextStyle(fontSize: 12),
            ),

            if (showQuantity) ...[
              const Spacer(),
              _buildQuantityButton(
                icon: Icons.remove,
                onTap: () => removeQuantity(index),
              ),
              Container(
                width: 30,
                alignment: Alignment.center,
                child: Text(
                  '${product.quantity}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildQuantityButton(
                icon: Icons.add,
                onTap: () => addQuantity(index),
                filled: true,
              ),
            ],
          ],
        ),
      ],
    );
  }

  // QUANTITY BUTTON
  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
    bool filled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child:
      Container(
        width: 28,
        height: 28,
        decoration:
        BoxDecoration(
          color:
          filled
              ? Colors.blue
              : const Color(
            0xFFE8EEF5,
          ),
          borderRadius:
          BorderRadius.circular(
            7,
          ),
        ),
        child:
        Icon(
          icon,
          size: 16,
          color:
          filled
              ? Colors.white
              : Colors.blueGrey,
        ),
      ),
    );
  }

  // TOTAL SECTION
  Widget _buildTotalSection() {
    return Container(
      padding:
      const EdgeInsets.fromLTRB(
        14,
        10,
        14,
        12,
      ),
      decoration:
      const BoxDecoration(
        color:
        Colors.white,
        border:
        Border(
          top:
          BorderSide(
            color:
            Color(0xFFE0E0E0),
            width:
            1,
          ),
        ),
      ),
      child:
      Row(
        children: [
          Expanded(
            child:
            Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  'Total ($totalQuantity produk)',
                  style:
                  const TextStyle(
                    color:
                    Colors.black54,
                    fontSize:
                    11,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  'Rp ${formatRupiah(totalPrice)}',
                  style:
                  const TextStyle(
                    color:
                    Colors.blue,
                    fontSize:
                    15,
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap:
            totalQuantity == 0
                ? null
                : openPayment,
            child:
            Container(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal:
                20,
                vertical:
                11,
              ),
              decoration:
              BoxDecoration(
                color:
                totalQuantity ==
                    0
                    ? Colors.grey
                    : Colors.blue,
                borderRadius:
                BorderRadius.circular(
                  9,
                ),
              ),
              child:
              const Text(
                'Checkout',
                style:
                TextStyle(
                  color:
                  Colors.white,
                  fontWeight:
                  FontWeight.bold,
                  fontSize:
                  13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BOTTOM NAVIGATION
  Widget _buildBottomNavigation() {
    final List<IconData> icons = [
      Icons.home,
      Icons.grid_view,
      Icons.shopping_bag_outlined,
      Icons.favorite_border,
      Icons.person_outline,
    ];

    final List<String> labels = [
      'Beranda',
      'Kategori',
      'Keranjang',
      'Wishlist',
      'Akun',
    ];

    return Container(
      padding:
      const EdgeInsets.only(
        top: 6,
        bottom: 5,
      ),
      decoration:
      const BoxDecoration(
        color:
        Colors.white,
        border:
        Border(
          top:
          BorderSide(
            color:
            Color(0xFFE0E0E0),
            width:
            1,
          ),
        ),
      ),
      child:
      Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceAround,
        children: [
          for (int i = 0;
          i < icons.length;
          i++)
            GestureDetector(
              onTap: () =>
                  changeBottomMenu(
                    i,
                  ),
              child:
              Column(
                mainAxisSize:
                MainAxisSize
                    .min,
                children: [
                  Stack(
                    clipBehavior:
                    Clip.none,
                    children: [
                      Icon(
                        icons[i],
                        size:
                        21,
                        color:
                        selectedBottomMenu ==
                            i
                            ? Colors
                            .blue
                            : Colors
                            .black,
                      ),

                      // BADGE CART
                      if (i == 2 &&
                          totalQuantity >
                              0)
                        Positioned(
                          right:
                          -7,
                          top:
                          -7,
                          child:
                          Container(
                            width:
                            15,
                            height:
                            15,
                            alignment:
                            Alignment
                                .center,
                            decoration:
                            const BoxDecoration(
                              color:
                              Colors.red,
                              shape:
                              BoxShape
                                  .circle,
                            ),
                            child:
                            Text(
                              '$totalQuantity',
                              style:
                              const TextStyle(
                                color:
                                Colors.white,
                                fontSize:
                                8,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),
                          ),
                        ),

                      // BADGE WISHLIST
                      if (i == 3 &&
                          wishlistProducts
                              .isNotEmpty)
                        Positioned(
                          right:
                          -7,
                          top:
                          -7,
                          child:
                          Container(
                            width:
                            15,
                            height:
                            15,
                            alignment:
                            Alignment
                                .center,
                            decoration:
                            const BoxDecoration(
                              color:
                              Colors.red,
                              shape:
                              BoxShape
                                  .circle,
                            ),
                            child:
                            Text(
                              '${wishlistProducts.length}',
                              style:
                              const TextStyle(
                                color:
                                Colors.white,
                                fontSize:
                                8,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  Text(
                    labels[i],
                    style:
                    TextStyle(
                      fontSize:
                      8.5,
                      color:
                      selectedBottomMenu ==
                          i
                          ? Colors
                          .blue
                          : Colors
                          .grey,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // MESSAGE
  Widget _buildMessage() {
    return Container(
      padding:
      const EdgeInsets
          .symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration:
      BoxDecoration(
        color:
        const Color(
          0xFF263238,
        ),
        borderRadius:
        BorderRadius.circular(
          10,
        ),
      ),
      child:
      Row(
        children: [
          const Icon(
            Icons.check_circle,
            color:
            Colors.greenAccent,
            size:
            20,
          ),

          const SizedBox(
            width: 8,
          ),

          Expanded(
            child:
            Text(
              message,
              style:
              const TextStyle(
                color:
                Colors.white,
                fontSize:
                13,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                message = '';
              });
            },
            child:
            const Icon(
              Icons.close,
              color:
              Colors.white70,
              size:
              18,
            ),
          ),
        ],
      ),
    );
  }

  // EMPTY CART
  Widget _buildEmptyCart() {
    return Container(
      width:
      double.infinity,
      padding:
      const EdgeInsets.all(
        30,
      ),
      decoration:
      BoxDecoration(
        color:
        Colors.white,
        borderRadius:
        BorderRadius.circular(
          12,
        ),
      ),
      child:
      Column(
        children: [
          const Icon(
            Icons
                .shopping_cart_outlined,
            color:
            Colors.grey,
            size:
            55,
          ),

          const SizedBox(
            height: 10,
          ),

          const Text(
            'Keranjang masih kosong',
            style:
            TextStyle(
              fontWeight:
              FontWeight.bold,
              fontSize:
              14,
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          const Text(
            'Tambahkan produk dengan tombol +',
            style:
            TextStyle(
              color:
              Colors.grey,
              fontSize:
              12,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                currentPage = 0;

                selectedBottomMenu =
                0;

                selectedCategory =
                'Semua';
              });
            },
            child:
            Container(
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal:
                16,
                vertical:
                10,
              ),
              decoration:
              BoxDecoration(
                color:
                Colors.blue,
                borderRadius:
                BorderRadius.circular(
                  8,
                ),
              ),
              child:
              const Text(
                'Belanja Sekarang',
                style:
                TextStyle(
                  color:
                  Colors.white,
                  fontSize:
                  12,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // EMPTY RESULT
  Widget _buildEmptyResult({
    required IconData icon,
    required String title,
  }) {
    return Container(
      width:
      double.infinity,
      padding:
      const EdgeInsets.all(
        25,
      ),
      decoration:
      BoxDecoration(
        color:
        Colors.white,
        borderRadius:
        BorderRadius.circular(
          12,
        ),
      ),
      child:
      Column(
        children: [
          Icon(
            icon,
            size:
            48,
            color:
            Colors.grey,
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            title,
            style:
            const TextStyle(
              color:
              Colors.grey,
              fontSize:
              13,
            ),
          ),
        ],
      ),
    );
  }

  // SECTION TITLE
  Widget _buildSectionTitle(
      String title,
      String subtitle,
      ) {
    return Align(
      alignment:
      Alignment.centerLeft,
      child:
      Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,
        children: [
          Text(
            title,
            style:
            const TextStyle(
              fontSize:
              16,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 3,
          ),

          Text(
            subtitle,
            style:
            const TextStyle(
              color:
              Colors.grey,
              fontSize:
              11,
            ),
          ),
        ],
      ),
    );
  }

  // ICON FALLBACK
  IconData _productIcon(
      int index,
      ) {
    if (index == 0) {
      return Icons.headphones;
    }

    if (index == 1) {
      return Icons.laptop_mac;
    }

    return Icons.mouse;
  }
}