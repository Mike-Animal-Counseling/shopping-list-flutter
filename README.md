# Shopping List (Flutter)

A Flutter shopping list app built to demonstrate:

- **Sliver UI** with a collapsible `SliverAppBar` titled **“Shopping List”**
- **Pinned total price** that stays visible while scrolling (`SliverPersistentHeader`)
- **Interactive grocery list** with select/deselect and clear visual feedback
- Optional **sound** on toggle and light **haptics** (where supported)

---

## Demo

**GIF**

![Demo](demo.gif)

Note: Sound effect is implemented but not shown in GIF by its property.

---

**Prerequisites**

- Flutter SDK (stable channel)
- Google Chrome installed

---

## Setup Instructions (Chrome)

```bash
git clone https://github.com/Mike-Animal-Counseling/shopping-list-flutter.git
cd chunky_shopping_list

flutter pub get
flutter config --enable-web
flutter run -d chrome

```

---

## State management choice (and rationale)

- I used flutter_bloc (BLoC) to keep the UI (Slivers/widgets) separate from business logic (selected items + total calculation).
- The UI dispatches events (e.g., “toggle item”), the ShoppingBloc updates and emits a new immutable ShoppingState, and the UI rebuilds from that state.
- This gives predictable updates, keeps Sliver UI code focused on layout/interaction, and makes the app easier to extend later (e.g., persistence, filtering, remote data).

---

## Trade-offs / decisions

- Items are seeded in code (no persistence/API) to keep the scope on Flutter fundamentals instead of backend/storage.

- Selected items are tracked using a Set<String> of item IDs for fast toggling and stable logic even if list order changes.

- The total is derived from state rather than stored separately, preventing duplicated/unsynced values between UI and logic.

- Sound/haptics are optional polish and handled best-effort so the core app still works if audio/haptics are unavailable or blocked.

---

## Estimated time spent

- Total: ~5 hours

- Sliver UI + pinned header: 2 hours

- BLoC / state management: 1 hours

- Item UI + interaction / visual feedback: 1 hours

- Sound / haptics polish: 0.5 hours

- README + demo capture: 0.5 hours
