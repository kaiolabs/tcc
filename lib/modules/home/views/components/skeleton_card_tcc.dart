import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonCardTcc extends StatelessWidget {
  const SkeletonCardTcc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: SkeletonItem(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.1,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.1,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.15,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
