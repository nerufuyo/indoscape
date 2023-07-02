import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';

class LoadingNewsNavigation extends StatelessWidget {
  const LoadingNewsNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3.5,
            height: 40,
            decoration: BoxDecoration(
              color: tertiaryColor.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const HorizontalGap5(),
          Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: tertiaryColor.withOpacity(.25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: tertiaryColor.withOpacity(.25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: tertiaryColor.withOpacity(.25),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: tertiaryColor.withOpacity(.25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingCurrentlyNewsList extends StatelessWidget {
  const LoadingCurrentlyNewsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: tertiaryColor.withOpacity(.25),
            ),
          ),
          const VerticalGap10(),
          Text(
            'Berita Terkini',
            style: jakartaH3.copyWith(
              color: textColor,
            ),
          ),
          const VerticalGap5(),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: textColor.withOpacity(.25),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const VerticalGap10(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              separatorBuilder: (context, index) => const VerticalGap10(),
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: tertiaryColor.withOpacity(.25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
