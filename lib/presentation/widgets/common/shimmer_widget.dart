import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Widget de shimmer pour les états de chargement
/// Remplace les CircularProgressIndicator par des effets visuels attractifs
class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.baseColor,
    this.highlightColor,
  });

  /// Factory pour créer un shimmer circulaire (avatar, icônes)
  factory ShimmerWidget.circular({
    required double size,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return ShimmerWidget(
      width: size,
      height: size,
      shape: BoxShape.circle,
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }

  /// Factory pour créer un shimmer rectangulaire arrondi (cards, images)
  factory ShimmerWidget.rounded({
    required double width,
    required double height,
    double radius = 12,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return ShimmerWidget(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(radius),
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        widget.baseColor ??
        (isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBase);
    final highlightColor =
        widget.highlightColor ??
        (isDark ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlight);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.rectangle
                ? widget.borderRadius
                : null,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

/// Skeleton pour la liste d'exercices
class ExerciseListShimmer extends StatelessWidget {
  final int itemCount;

  const ExerciseListShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Icon placeholder
                  ShimmerWidget.circular(size: 48),
                  const SizedBox(width: 12),
                  // Text content placeholder
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget.rounded(
                          width: double.infinity,
                          height: 16,
                          radius: 4,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ShimmerWidget.rounded(
                              width: 80,
                              height: 24,
                              radius: 12,
                            ),
                            const SizedBox(width: 8),
                            ShimmerWidget.rounded(
                              width: 80,
                              height: 24,
                              radius: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Skeleton pour la liste de workouts
class WorkoutListShimmer extends StatelessWidget {
  final int itemCount;

  const WorkoutListShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.rounded(width: 200, height: 20, radius: 4),
                  const SizedBox(height: 12),
                  ShimmerWidget.rounded(
                    width: double.infinity,
                    height: 14,
                    radius: 4,
                  ),
                  const SizedBox(height: 8),
                  ShimmerWidget.rounded(width: 150, height: 14, radius: 4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Skeleton pour les détails de session
class SessionDetailsShimmer extends StatelessWidget {
  const SessionDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ShimmerWidget.rounded(width: double.infinity, height: 100),
          const SizedBox(height: 24),
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (index) => Column(
                children: [
                  ShimmerWidget.rounded(width: 60, height: 40, radius: 8),
                  const SizedBox(height: 8),
                  ShimmerWidget.rounded(width: 80, height: 12, radius: 4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Exercise list
          ...List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget.rounded(width: 150, height: 16, radius: 4),
                      const SizedBox(height: 12),
                      ...List.generate(
                        3,
                        (setIndex) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ShimmerWidget.rounded(
                            width: double.infinity,
                            height: 40,
                            radius: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton pour les cartes de stats
class StatsCardShimmer extends StatelessWidget {
  const StatsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget.rounded(width: 120, height: 14, radius: 4),
            const SizedBox(height: 16),
            ShimmerWidget.rounded(width: 100, height: 32, radius: 4),
            const SizedBox(height: 8),
            ShimmerWidget.rounded(width: double.infinity, height: 100),
          ],
        ),
      ),
    );
  }
}

/// Skeleton pour l'historique
class HistoryListShimmer extends StatelessWidget {
  final int itemCount;

  const HistoryListShimmer({super.key, this.itemCount = 10});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ShimmerWidget.rounded(width: 60, height: 60, radius: 8),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget.rounded(
                          width: double.infinity,
                          height: 16,
                          radius: 4,
                        ),
                        const SizedBox(height: 8),
                        ShimmerWidget.rounded(
                          width: 120,
                          height: 12,
                          radius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
