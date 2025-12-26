import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/shopping_bloc.dart';
import '../bloc/shopping_event.dart';
import '../bloc/shopping_state.dart';
import 'widgets/grocery_item_tile.dart';
import 'widgets/total_header_delegate.dart';
import '../../../services/sound_service.dart';

class ShoppingHomePage extends StatelessWidget {
  const ShoppingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ShoppingBloc, ShoppingState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 140,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      // Hide subtitle when collapsed to avoid overlap with title.
                      final isExpanded =
                          constraints.biggest.height > (kToolbarHeight + 40);

                      return FlexibleSpaceBar(
                        title: const Text('Shopping List'),
                        background: isExpanded
                            ? Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                                child: Text(
                                  'Tap items to add/remove from total.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.75),
                                      ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),

                // Pinned total price display
                SliverPersistentHeader(
                  pinned: true,
                  delegate: TotalHeaderDelegate(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: Theme.of(context).textTheme.titleMedium),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Text(
                            currency.format(state.total),
                            key: ValueKey(state.total.toStringAsFixed(2)),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = state.items[index];
                      final selected = state.isSelected(item.id);

                      return GroceryItemTile(
                        name: item.name,
                        price: item.price,
                        selected: selected,
                        onTap: () {
                          // Update state first so UI always reacts, even if haptics/audio fail on web.
                          context
                              .read<ShoppingBloc>()
                              .add(ShoppingItemToggled(item.id));

                          try {
                            HapticFeedback.selectionClick();
                          } catch (_) {}

                          final sound = context.read<SoundService>();
                          try {
                            if (selected) {
                              sound.playDeselect();
                            } else {
                              sound.playSelect();
                            }
                          } catch (_) {}
                        },
                      );
                    },
                    childCount: state.items.length,
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            );
          },
        ),
      ),
    );
  }
}
