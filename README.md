# RecipeBuddy

A small SwiftUI app for browsing recipes, marking favorites, and adding recipes to a weekly meal plan.  
Built using **SwiftUI + MVVM** with a **Repository pattern**, async/await networking, and a global snackbar notification system.

---

## How to Run

1. **Clone the repository**:
   ```bash
   git clone https://github.com/elmeeee/RecipeApp
   cd RecipeBuddy
   ```

2. **Open in Xcode**:
   - Open `RecipeBuddy.xcodeproj` or `.xcworkspace` in **Xcode 15+**.
   - Make sure your deployment target is iOS 17.0 or later.

3. **Build & Run**:
   - Select an iOS Simulator (e.g., iPhone 15).
   - Press `Cmd + R` to run the app.

---

## Architecture

The app follows **MVVM** with a **Repository protocol**:

```
View  <->  ViewModel  <->  Repository  <->  Local / Remote Data Sources
```

### Components
- **Views**: SwiftUI views responsible for UI rendering and user interaction.
- **ViewModels**: Manage state, filtering, search, and calling the repository.
- **Repository**: Abstracts the data source (local JSON, remote JSON).
- **Stores**: 
  - `FavoritesStore`: Manages favorite recipe IDs (persisted in `UserDefaults`).
  - `MealPlanStore`: Stores recipes planned for specific days (persisted in `UserDefaults`).
- **SnackbarManager**: Global snackbar for showing feedback anywhere in the app.

---

## Trade-offs

- **Persistence**: Using `UserDefaults` instead of SwiftData/Core Data.
  - Pros: Lightweight, no migration overhead, easy to debug.
  - ⚠Cons: Limited querying capability, not ideal for large datasets.

- **Remote Data Loading**: Basic JSON fetch from a provided URL.
  - Pros: Very flexible and quick to implement.
  - Cons: No offline caching for remote data.

- **Global Snackbar**:
  - Chose a single `SnackbarManager` injected via `.environmentObject` to avoid passing callback closures down the view hierarchy.

---

## What’s Completed

**Level 1:**
- Display local recipe data.
- Show recipe details including ingredients, method, and tags.

**Level 2:**
- Search recipes by title or ingredient.
- Filter recipes by tag.
- Sort recipes by preparation time.

**Level 3:**
- Mark recipes as favorites.
- Add recipes to a weekly meal plan.
- Persist favorites and meal plans in `UserDefaults`.

**Bonus:**
- Remote data loading via URL (e.g., JSON hosted on GitHub).
- Global snackbar notifications for user actions.
- Accessibility labels for interactive elements.


## What I Would Add with More Time

- Offline caching for remote data.
- Image caching & placeholders for smoother scrolling.
- Unit tests for ViewModels and Repository.
- Swipe actions for quickly favoriting or adding to meal plan.
- More advanced filtering (e.g., multiple tags AND search).

## ScreenShoot
<img src="https://github.com/elmeeee/RecipeApp/blob/main/RecipeApp/Data/Result.png" width="800" />

