
import 'package:airtime2cash/theme/colors.dart';
import 'package:airtime2cash/theme/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class TransactionWidget extends StatefulWidget {
  final Image image;
  final String text;
  final String pageRoute;

  const TransactionWidget({
    Key? key,
    required this.image,
    required this.text,
    required this.pageRoute,
  }) : super(key: key);

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}


class _TransactionWidgetState extends State<TransactionWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: PhysicalModel(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(kDefaultBorderRadius * 1.8)),
        color: kWhite,
        elevation: 5,
        shadowColor: kBackgroundColor,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding * 0.6,
              horizontal: kDefaultPadding
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              SizedBox(
                height: 55,
                width: 55,
                child: widget.image,
              ),

              const SizedBox(
                width: 30,
              ),

              Expanded(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      fontFamily: kDefaultFontFamily,
                      fontSize: 22,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.25
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
          AutoRouter.of(context).pushNamed(widget.pageRoute);
      }
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeftWithFade,
        //     duration: const Duration(milliseconds: 800),
        //     child: const HomePage(),
        //   ),
        // );
    );
  }
}
