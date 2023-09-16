import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FinanceTransactionListShimmer extends StatelessWidget {
  const FinanceTransactionListShimmer({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 16,
                        width: 200, // Defina a largura desejada
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: Colors.white,
                        height: 16,
                        width: 100, // Defina a largura desejada
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 20,
                  width: 60, // Defina a largura desejada
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
