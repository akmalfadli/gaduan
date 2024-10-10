import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/network_utils/penerima_controller.dart';
import 'package:gaduan/screen/feed_screen.dart';
import 'package:gaduan/screen/market_place.dart';
import 'package:gaduan/screen/posting_screen.dart';
import 'package:gaduan/screen/pengaturan_screen.dart';
import 'package:gaduan/screen/profile_screen.dart';
import 'package:gaduan/screen/trending_screen.dart';
import 'package:gaduan/widget/list_person.dart';
import 'package:gaduan/widget/recent_update.dart';
import 'package:gaduan/const.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String name = '';
  PenerimaController penerima = Get.put(PenerimaController());
  late TabController tabController;
  AuthController auth = Get.find<AuthController>();

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    // _loadUserData();
    print('initstate user: ${auth.user.value.toJson()}');
    super.initState();
  }

  // _loadUserData() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   user = User.fromJson(jsonDecode(localStorage.getString('user')!));

  //   if (user != null) {
  //     setState(() {
  //       name = user.name!;
  //     });
  //   }
  // }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 4) {
        Get.to(() => ProfileScreen(userId: auth.user.value.id));
      } else {
        tabController.animateTo(_selectedIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: GetBuilder(
          init: auth,
          builder: (_) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.update),
                    label: 'Terbaru',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.fire, size: 20),
                    label: 'Trending',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.shop, size: 18),
                    label: 'Pasar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user, size: 20),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: false,
                unselectedLabelStyle: const TextStyle(color: Colors.grey),
                onTap: _onItemTapped,
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              homePadding, 16, homePadding, homePadding),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      auth.user.value.imageProfile != null &&
                                              auth.user.value.imageProfile != ''
                                          ? CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  '$imageUrl${auth.user.value.imageProfile}',
                                              imageBuilder:
                                                  ((context, imageProvider) =>
                                                      CircleAvatar(
                                                          minRadius: 25,
                                                          maxRadius: 25,
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .fill),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            80))),
                                                          ))),
                                            )
                                          : const CircleAvatar(
                                              backgroundImage: ExactAssetImage(
                                                  'assets/images/male_profile_placeholder.jpg'),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Selamat datang..',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              auth.user.value.name ?? '',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                                PopupMenuButton<int>(
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuItem<int>>[
                                          const PopupMenuItem<int>(
                                              value: 1,
                                              child: Text('Pengaturan')),
                                          const PopupMenuItem<int>(
                                              value: 2, child: Text('Tentang')),
                                          const PopupMenuItem<int>(
                                              value: 3, child: Text('Keluar')),
                                        ],
                                    onSelected: (int value) async {
                                      switch (value) {
                                        case 1:
                                          Get.to(PengaturanScreen(
                                              user: auth.user.value));
                                          break;
                                        case 2:
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text('Tentang')));
                                          break;
                                        case 3:
                                          await AuthController().logout();
                                          break;
                                        default:
                                      }
                                    })
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostScreen(
                                          user: auth.user.value,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: homePadding,
                                            right: homePadding),
                                        child: Icon(
                                          FontAwesomeIcons.images,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text("Apa yang anda pikirkan ?"),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Obx(() => penerima.isDataLoading.value
                            ? Container()
                            : Person(dataPenerima: penerima.penerima!)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            homePadding, 4, homePadding, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Terbaru',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => FeedScreen(user: auth.user.value));
                              },
                              child: Text(
                                'Lihat semua',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: RecentUpdate(user: auth.user.value),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            homePadding, 8, homePadding, 8),
                        child: Text(
                          'Berita',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                homePadding, 8, homePadding, 8),
                            child: Container(
                              child: ListView(children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.new_releases,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 8),
                                    Text('Kambing milik pak sabar melahirkan'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.new_releases,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                        'Kambing milik pak muji melahirkan 2 cempe'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.new_releases,
                                      size: 12,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                        'Kambing milik pak waras meninggal keracunan'),
                                  ],
                                ),
                              ]),
                            ),
                          ))
                    ],
                  ),
                  FeedScreen(user: auth.user.value),
                  TrendingScreen(),
                  MarketScreen(),
                  ProfileScreen(userId: auth.user.value.id),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
