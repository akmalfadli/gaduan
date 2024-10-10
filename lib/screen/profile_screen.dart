import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/network_utils/myposts_controller.dart';
import 'package:gaduan/network_utils/user_controller.dart';
import 'package:gaduan/screen/pengaturan_screen.dart';
import 'package:gaduan/screen/posting_screen.dart';
import 'package:gaduan/widget/expandable_text.dart';
import 'package:gaduan/widget/grid_view_post.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final userId;

  ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late MyPostController _mypost;
  late UserController _userctl;
  AuthController auth = Get.find<AuthController>();
  _ProfileScreenState();

  @override
  void initState() {
    _userctl = Get.put(UserController(id: widget.userId));
    _mypost = Get.put(MyPostController(widget.userId));
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => _userctl.isUserLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _userctl.user != null
                  ? NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context, value) {
                        return [
                          SliverToBoxAdapter(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    homePadding, 8, homePadding, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          ' Profile',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () => Get.to(
                                            PostScreen(user: _userctl.user!)),
                                        icon: const Icon(
                                            FontAwesomeIcons.squarePlus))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        homePadding, 0, homePadding, 8),
                                    child: _userctl.user!.imageProfile !=
                                                null &&
                                            _userctl.user!.imageProfile != ''
                                        ? CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                '$imageUrl${_userctl.user!.imageProfile}',
                                            imageBuilder:
                                                ((context, imageProvider) =>
                                                    CircleAvatar(
                                                        minRadius: 38,
                                                        maxRadius: 38,
                                                        child: Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .fill),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          80))),
                                                        ))),
                                          )
                                        : const CircleAvatar(
                                            minRadius: 38,
                                            maxRadius: 38,
                                            backgroundImage: ExactAssetImage(
                                                'assets/images/male_profile_placeholder.jpg'),
                                          ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: const [
                                      Text('01',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Text(
                                        'Id Gaduan',
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Obx(() => _mypost.isDataLoading.value
                                          ? Text("...")
                                          : Text(
                                              "${_mypost.postData.value.data!.length}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )),
                                      Text(
                                        'Postingan',
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    homePadding, 0, homePadding, 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(_userctl.user!.name!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 18)),
                                        SizedBox(width: 8),
                                        _userctl.user!.isGaduan == 1
                                            ? const Icon(
                                                FontAwesomeIcons.circleCheck,
                                                color: Colors.green,
                                                size: 16,
                                              )
                                            : Container()
                                      ],
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: _userctl.user!.bio!.isNotEmpty
                                            ? ExpandableText(
                                                _userctl.user!.bio!,
                                                trimLines: 3)
                                            : Container()),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        homePadding, 8, 8, homePadding),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      height: 30,
                                      child: Material(
                                        color: Colors.grey.shade200,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: InkWell(
                                            onTap: () => Get.to(() =>
                                                PengaturanScreen(
                                                    user: _userctl.user!)),
                                            child: const Center(
                                                child: Text('Edit Profil'))),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16.0, bottom: 8),
                                    child: Obx(() => GestureDetector(
                                          onTap: () {
                                            print(
                                                'my id: ${auth.user.value.id} following id ${_userctl.user!.id}');
                                            if (auth.user.value.id !=
                                                _userctl.user!.id) {
                                              _userctl.follow(
                                                  followingId: _userctl.id,
                                                  name: _userctl.user!.name);
                                            }
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0))),
                                            child: auth.user.value.id ==
                                                    _userctl.user!.id
                                                ? const Icon(
                                                    FontAwesomeIcons.userCheck,
                                                    color: Colors.grey,
                                                    size: 18,
                                                  )
                                                : const Icon(
                                                    FontAwesomeIcons.userPlus,
                                                    color: Colors.grey,
                                                    size: 18,
                                                  ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ],
                          )),
                          SliverToBoxAdapter(
                            child: TabBar(
                              indicatorColor: Colors.blue,
                              unselectedLabelColor: Colors.grey,
                              controller: _tabController,
                              labelColor: Colors.black,
                              tabs: [
                                Tab(
                                  icon: Icon(
                                    FontAwesomeIcons.th,
                                  ),
                                ),
                                Tab(
                                  icon: Icon(
                                    FontAwesomeIcons.heart,
                                  ),
                                ),
                                Tab(
                                  icon: Icon(
                                    FontAwesomeIcons.solidBookmark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              child: Obx(
                                () => _mypost.isDataLoading.value
                                    ? Container()
                                    : GridViewPost(
                                        posts: _mypost.postData.value.data!,
                                        user: _userctl.user),
                              ),
                            ),
                            Container(
                              child: Text("Articles Body"),
                            ),
                            Container(
                              child: Text("User Body"),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text('tidak terhubung ke server'),
                    ),
        ),
      ),
    );
  }
}

//  TabBar(
//                       indicatorColor: Colors.grey,
//                       labelColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                       tabs: [

//                       ],
//                     ),


