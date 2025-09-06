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
  }
}
