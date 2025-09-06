import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/screens/profile/bloc/profile_bloc.dart';
import 'package:watch_store/screens/profile/order_list_screen.dart';
import 'package:watch_store/widgets/avatar.dart';
import 'package:watch_store/widgets/customized_appBar.dart';
import 'package:watch_store/widgets/shopping_state.dart';
import 'package:watch_store/widgets/surface_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomizedAppbar(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(AppStrings.profile, style: LightAppTextStyle.title),
          ),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileReceivedOrdersLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => OrderListScreen(
                        status: "لیست سفارشات ارسال شده",
                        orderList: state.orderList,
                      ),
                ),
              );
            } else if (state is ProfileCanceledOrdersLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => OrderListScreen(
                        status: "لیست سفارشات لغو شده",
                        orderList: state.orderList,
                      ),
                ),
              );
            } else if (state is ProfileprocessingOrdersLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => OrderListScreen(
                        status: "لیست سفارشات در حال پردازش",
                        orderList: state.orderList,
                      ),
                ),
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoadedState) {
                return Column(
                  children: [
                    Dimensions.large.height,
                    Avatar(
                      text: state.profile.userInfo.name,
                      onTap: () {},
                      file: null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.large),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.activeAddress,
                            style: LightAppTextStyle.title,
                          ),
                          Dimensions.small.height,
                          Text(
                            state.profile.userInfo.address.address,
                            style: LightAppTextStyle.title,
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            softWrap: true,
                          ),

                          Dimensions.small.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                state.profile.userInfo.address.postalCode,
                                style: LightAppTextStyle.title,
                              ),
                              Dimensions.small.width,
                              SvgPicture.asset(Assets.svg.postalCode),
                            ],
                          ),
                          Dimensions.small.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                state.profile.userInfo.mobile,
                                style: LightAppTextStyle.title,
                              ),
                              Dimensions.small.width,
                              SvgPicture.asset(Assets.svg.phone),
                            ],
                          ),
                          Dimensions.small.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                state.profile.userInfo.name,
                                style: LightAppTextStyle.title,
                              ),
                              Dimensions.small.width,
                              SvgPicture.asset(
                                Assets.svg.user,
                                height: Dimensions.large,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SurfaceContainer(
                      child: Text(
                        AppStrings.termOfService,
                        style: LightAppTextStyle.title,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SurfaceContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              debugPrint('>>> Delivered Tapped');
                              BlocProvider.of<ProfileBloc>(
                                context,
                              ).add(ProfileReceivedOrdersEvent());
                            },
                            child: ShoppingState(
                              imagePath: Assets.svg.delivered,
                              text:
                                  "${AppStrings.delivered} ${state.profile.userProcessingCount}",
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              debugPrint('>>> cancelled Tapped');
                              context.read<ProfileBloc>().add(
                                ProfileCancelledOrdersEvent(),
                              );
                            },
                            child: ShoppingState(
                              imagePath: Assets.svg.cancelled,
                              text:
                                  "${AppStrings.cancelled} ${state.profile.userCanceledCount}",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              debugPrint('>>> inProcess Tapped');
                              context.read<ProfileBloc>().add(
                                ProfileProcessingOrdersEvent(),
                              );
                            },
                            child: ShoppingState(
                              imagePath: Assets.svg.inProccess,
                              text:
                                  "${AppStrings.inProccess} ${state.profile.userProcessingCount}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is ProfileErrorState) {
                return Text('Error!');
              } else {
                return Center(child: Text('تلاش مجدد'));
              }
            },
          ),
        ),
      ),
    );

    // return SafeArea(
    //   child: Scaffold(
    //     appBar: CustomizedAppbar(
    //       child: Align(
    //         alignment: Alignment.centerRight,
    //         child: Text(AppStrings.profile, style: LightAppTextStyle.title),
    //       ),
    //     ),
    //     body: SingleChildScrollView(
    //       physics: BouncingScrollPhysics(),
    //       child: BlocBuilder<ProfileBloc, ProfileState>(
    //         builder: (context, state) {
    //           if (state is ProfileLoadingState) {
    //             return Center(child: CircularProgressIndicator());
    //           } else if (state is ProfileLoadedState) {
    //             return Column(
    //               children: [
    //                 Dimensions.large.height,
    //                 Avatar(
    //                   text: state.profile.userInfo.name,
    //                   onTap: () {},
    //                   file: null,
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(Dimensions.large),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Text(
    //                         AppStrings.activeAddress,
    //                         style: LightAppTextStyle.title,
    //                       ),
    //                       Dimensions.small.height,
    //                       Text(
    //                         state.profile.userInfo.address.address,
    //                         style: LightAppTextStyle.title,
    //                         textAlign: TextAlign.right,
    //                         maxLines: 2,
    //                         softWrap: true,
    //                       ),

    //                       Dimensions.small.height,
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: [
    //                           Text(
    //                             state.profile.userInfo.address.postalCode,
    //                             style: LightAppTextStyle.title,
    //                           ),
    //                           Dimensions.small.width,
    //                           SvgPicture.asset(Assets.svg.postalCode),
    //                         ],
    //                       ),
    //                       Dimensions.small.height,
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: [
    //                           Text(
    //                             state.profile.userInfo.mobile,
    //                             style: LightAppTextStyle.title,
    //                           ),
    //                           Dimensions.small.width,
    //                           SvgPicture.asset(Assets.svg.phone),
    //                         ],
    //                       ),
    //                       Dimensions.small.height,
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.end,
    //                         children: [
    //                           Text(
    //                             state.profile.userInfo.name,
    //                             style: LightAppTextStyle.title,
    //                           ),
    //                           Dimensions.small.width,
    //                           SvgPicture.asset(
    //                             Assets.svg.user,
    //                             height: Dimensions.large,
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SurfaceContainer(
    //                   child: Text(
    //                     AppStrings.termOfService,
    //                     style: LightAppTextStyle.title,
    //                     textAlign: TextAlign.right,
    //                   ),
    //                 ),
    //                 SurfaceContainer(
    //                   child: BlocListener<ProfileBloc, ProfileState>(
    //                     listener: (context, state) {
    //                       if (state is ProfileReceivedOrdersLoaded) {
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder:
    //                                 (context) => OrderListScreen(
    //                                   status: "لیست سفارشات ارسال شده",
    //                                   orderList: state.orderList,
    //                                 ),
    //                           ),
    //                         );
    //                       } else if (state is ProfileCanceledOrdersLoaded) {
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder:
    //                                 (context) => OrderListScreen(
    //                                   status: "لیست سفارشات لغو شده",
    //                                   orderList: state.orderList,
    //                                 ),
    //                           ),
    //                         );
    //                       } else if (state is ProfileprocessingOrdersLoaded) {
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder:
    //                                 (context) => OrderListScreen(
    //                                   status: "لیست سفارشات در حال پردازش",
    //                                   orderList: state.orderList,
    //                                 ),
    //                           ),
    //                         );
    //                       }
    //                     },
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         GestureDetector(
    //                           onTap: () {
    //                             debugPrint('>>> Delivered Tapped');
    //                             BlocProvider.of<ProfileBloc>(
    //                               context,
    //                             ).add(ProfileReceivedOrdersEvent());
    //                           },
    //                           child: ShoppingState(
    //                             imagePath: Assets.svg.delivered,
    //                             text:
    //                                 "${AppStrings.delivered} ${state.profile.userProcessingCount}",
    //                           ),
    //                         ),

    //                         GestureDetector(
    //                           onTap: () {
    //                             debugPrint('>>> cancelled Tapped');
    //                             context.read<ProfileBloc>().add(
    //                               ProfileCancelledOrdersEvent(),
    //                             );
    //                           },
    //                           child: ShoppingState(
    //                             imagePath: Assets.svg.cancelled,
    //                             text:
    //                                 "${AppStrings.cancelled} ${state.profile.userCanceledCount}",
    //                           ),
    //                         ),
    //                         GestureDetector(
    //                           onTap: () {
    //                             debugPrint('>>> inProcess Tapped');
    //                             context.read<ProfileBloc>().add(
    //                               ProfileProcessingOrdersEvent(),
    //                             );
    //                           },
    //                           child: ShoppingState(
    //                             imagePath: Assets.svg.inProccess,
    //                             text:
    //                                 "${AppStrings.inProccess} ${state.profile.userProcessingCount}",
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             );
    //           } else if (state is ProfileErrorState) {
    //             return Text('Error!');
    //           } else {
    //             return Center(child: Text('تلاش مجدد'));
    //           }
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}

// /////////////////////////////////////////////////////////////////////////////
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     BlocProvider.of<ProfileBloc>(context).add(ProfileInit());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: CustomizedAppbar(
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     BlocProvider.of<ProfileBloc>(context).add(ProfileInit());
//                   },
//                   icon: const Icon(CupertinoIcons.refresh),
//                 ),
//                 const Text(AppStrings.profile, style: LightAppTextStyle.title),
//               ],
//             ),
//           ),
//         ),
//         body: BlocBuilder<ProfileBloc, ProfileState>(
//           buildWhen: (previous, current) {
//             if (current is ProfileSuccess ||
//                 current is ProfileLoading ||
//                 current is ProfileError) {
//               return true;
//             } else {
//               return false;
//             }
//           },
//           builder: (context, state) {
//             if (state is ProfileSuccess) {

//               // return SingleChildScrollView(
//               //   child: SizedBox(
//               //     width: double.infinity,
//               //     child: Padding(
//               //       padding: const EdgeInsets.symmetric(
//               //         horizontal: Dimensions.large,
//               //       ),
//               //       child: Column(
//               //         crossAxisAlignment: CrossAxisAlignment.center,
//               //         children: [
//               //           Dimensions.large.height,
//               //           Align(
//               //             alignment: Alignment.centerRight,
//               //             child: Text(
//               //               AppStrings.activeAddress,
//               //               style: LightAppTextStyle.title,
//               //             ),
//               //           ),
//               //           Dimensions.small.height,
//               //           Align(
//               //             alignment: Alignment.centerRight,
//               //             child: Text(
//               //               "state.profileModel.userInfo?.address?.address??''",
//               //               textDirection: TextDirection.rtl,
//               //               maxLines: 1,
//               //               overflow: TextOverflow.ellipsis,
//               //               textAlign: TextAlign.right,
//               //               style: LightAppTextStyle.title,
//               //             ),
//               //           ),
//               //           const Divider(),
//               //           Dimensions.small.height,
//               //           Padding(
//               //             padding: const EdgeInsets.symmetric(
//               //               vertical: Dimensions.small,
//               //             ),
//               //             child: Align(
//               //               alignment: Alignment.centerRight,
//               //               child: Row(
//               //                 children: [
//               //                   Expanded(
//               //                     child: Text(
//               //                       "state.profileModel.userInfo.mobile",
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.title,
//               //                     ),
//               //                   ),
//               //                   Dimensions.small.width,
//               //                   const Icon(
//               //                     CupertinoIcons.device_phone_portrait,
//               //                   ),
//               //                 ],
//               //               ),
//               //             ),
//               //           ),
//               //           Padding(
//               //             padding: const EdgeInsets.symmetric(
//               //               vertical: Dimensions.small,
//               //             ),
//               //             child: Align(
//               //               alignment: Alignment.centerRight,
//               //               child: Row(
//               //                 children: [
//               //                   Expanded(
//               //                     child: Text(
//               //                       "state.profileModel.userInfo?.phone ",
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.title,
//               //                     ),
//               //                   ),
//               //                   Dimensions.small.width,
//               //                   SvgPicture.asset(Assets.svg.phone, height: 24),
//               //                 ],
//               //               ),
//               //             ),
//               //           ),
//               //           Padding(
//               //             padding: const EdgeInsets.symmetric(
//               //               vertical: Dimensions.small,
//               //             ),
//               //             child: Align(
//               //               alignment: Alignment.centerRight,
//               //               child: Row(
//               //                 children: [
//               //                   Expanded(
//               //                     child: Text(
//               //                       "state.profileModel.userInfo.name",
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.selectedTab,
//               //                     ),
//               //                   ),
//               //                   Dimensions.small.width,
//               //                   SvgPicture.asset(
//               //                     Assets.svg.userMenu,
//               //                     height: 24,
//               //                   ),
//               //                 ],
//               //               ),
//               //             ),
//               //           ),
//               //           Padding(
//               //             padding: const EdgeInsets.symmetric(
//               //               vertical: Dimensions.small,
//               //             ),
//               //             child: Align(
//               //               alignment: Alignment.centerRight,
//               //               child: Row(
//               //                 children: [
//               //                   Expanded(
//               //                     child: Text(
//               //                       'Address',
//               //                       style: LightAppTextStyle.selectedTab,
//               //                     ),
//               //                   ),
//               //                   Dimensions.small.width,
//               //                   const Icon(Icons.location_on_outlined),
//               //                 ],
//               //               ),
//               //             ),
//               //           ),
//               //           SurfaceContainer(
//               //             child: Row(
//               //               mainAxisSize: MainAxisSize.min,
//               //               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //               children: [
//               //                 const Spacer(),
//               //                 Column(
//               //                   mainAxisAlignment: MainAxisAlignment.center,
//               //                   crossAxisAlignment: CrossAxisAlignment.end,
//               //                   children: [
//               //                     Text(
//               //                       "سفارش",
//               //                       // '${state.profileModel.userProcessingCount}  سفارش',
//               //                       textDirection: TextDirection.rtl,
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.selectedTab,
//               //                     ),
//               //                     8.height,
//               //                     Text(
//               //                       "سفارش",
//               //                       // '${state.profileModel.userCancelCount}  سفارش',
//               //                       textDirection: TextDirection.rtl,
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.selectedTab,
//               //                     ),
//               //                     8.height,
//               //                     Text(
//               //                       "سفارش",
//               //                       // '${state.profileModel.userReceivedCount}  سفارش',
//               //                       textDirection: TextDirection.rtl,
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.selectedTab,
//               //                     ),
//               //                   ],
//               //                 ),
//               //                 12.width,
//               //                 Column(
//               //                   mainAxisAlignment: MainAxisAlignment.center,
//               //                   crossAxisAlignment: CrossAxisAlignment.end,
//               //                   children: [
//               //                     Text(
//               //                       'در حال پردازش:  ',
//               //                       textDirection: TextDirection.rtl,
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.selectedTab
//               //                           .copyWith(color: Colors.blue),
//               //                     ),
//               //                     8.height,
//               //                     Text(
//               //                       'لغو شده:  ',
//               //                       textDirection: TextDirection.rtl,
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.selectedTab
//               //                           .copyWith(color: Colors.red),
//               //                     ),
//               //                     8.height,
//               //                     Text(
//               //                       'تحویل شده:  ',
//               //                       textDirection: TextDirection.rtl,
//               //                       textAlign: TextAlign.right,
//               //                       style: LightAppTextStyle.selectedTab
//               //                           .copyWith(color: Colors.green),
//               //                     ),
//               //                   ],
//               //                 ),
//               //               ],
//               //             ),
//               //           ),
//               //           SurfaceContainer(
//               //             child: Padding(
//               //               padding: const EdgeInsets.all(Dimensions.medium),
//               //               child: Row(
//               //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //                 children: [
//               //                   GestureDetector(
//               //                     onTap: () {},
//               //                     child: Column(
//               //                       children: [
//               //                         SvgPicture.asset(Assets.svg.delivered),
//               //                         Dimensions.small.height,
//               //                         const Text(
//               //                           AppStrings.delivered,
//               //                           style: LightAppTextStyle.avatarText,
//               //                         ),
//               //                       ],
//               //                     ),
//               //                   ),
//               //                   GestureDetector(
//               //                     onTap: () {},

//               //                     child: Column(
//               //                       children: [
//               //                         SvgPicture.asset(Assets.svg.cancelled),
//               //                         Dimensions.small.height,
//               //                         const Text(
//               //                           AppStrings.cancelled,
//               //                           style: LightAppTextStyle.avatarText,
//               //                         ),
//               //                       ],
//               //                     ),
//               //                   ),
//               //                   GestureDetector(
//               //                     onTap: () {},
//               //                     child: Column(
//               //                       children: [
//               //                         SvgPicture.asset(Assets.svg.inProccess),
//               //                         Dimensions.small.height,
//               //                         const Text(
//               //                           AppStrings.inProccess,
//               //                           style: LightAppTextStyle.avatarText,
//               //                         ),
//               //                       ],
//               //                     ),
//               //                   ),
//               //                 ],
//               //               ),
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // );
//             } else if (state is ProfileLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is ProfileError) {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     state.error,
//                     maxLines: 3,
//                     style: LightAppTextStyle.selectedTab,
//                   ),
//                   Dimensions.medium.width,
//                   Icon(
//                     CupertinoIcons.exclamationmark_circle,
//                     color: Colors.red.shade400,
//                   ),
//                 ],
//               );
//             } else {
//               throw Exception("Invalid $state State");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
