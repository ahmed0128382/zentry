# Zentry 🧠📅

Zentry is a task management and productivity app , with additional gamification elements like points, badges, and premium features.  
The app is currently under active development using Flutter and follows professional software engineering practices.

---
## 🚀 Features

- 🗓 **Calendar & Scheduling** – View daily, weekly, and monthly tasks.
- ✅ **To-Do Today** – Focus on only what matters for the day.
- ⏳ **Countdown Timers** – For events, deadlines, and focus sessions.
- 📊 **Eisenhower Matrix** – Prioritize tasks based on urgency and importance.
- 💡 **Habits Tracker** – Build and maintain daily habits.
- 🎨 **Custom Appearance** – Themes and UI customization.
- 🧭 **Customizable Bottom Navigation Bar** – Edit and arrange tabs.
- 🔍 **Search** – Quickly find tasks, notes, or habits.
- 👤 **Profile Management** – Track your progress and personalize your experience.
- 🪄 **Smooth Onboarding Flow** – Get started with an intuitive welcome experience.
- 🎯 **Focus Mode** – Eliminate distractions and work deeply.

  
## 🏗️ Project Architecture

Zentry is built using a combination of:

- ✅ **Domain-Driven Design (DDD)**: To deeply model business logic based on real-world domains.
- ✅ **Clean Architecture**: To separate concerns and ensure testability, scalability, and maintainability.
- ✅ **Riverpod** for scalable state management.

---

## 🔨 Technologies Used (So far)

| Category             | Tools / Libraries                                                |
| -------------------- | ---------------------------------------------------------------- |
| UI Toolkit           | Flutter                                                          |
| State Management     | Riverpod                                                         |
| Architecture Pattern | Clean Architecture + DDD                                         |
| Theming / Styling    | Custom `AppTheme`, `AppColors`, `AppFonts`, etc.                 |
| Routing              | [GoRouter](https://pub.dev/packages/go_router)                   |
| Git                  | Git + GitHub (private main branch, public showcase branch later) |

---

## 📁 Project Structure (WIP)

```bash
lib/
└── src/
    ├── app/                      # App-level setup (entry point, providers)
    ├── config/                   # App configuration
    ├── core/                     # Core utilities, routing, theming, base widgets
    │   ├── routes/
    │   ├── theme/
    │   ├── utils/
    │   └── widgets/
    ├── shared/                   # Shared enums, constants
    │   └── enums/
    ├── features/                 # Feature-based modules
    │   ├── appearance/           # Theme customization
    │   │   └── presentation/
    │   ├── calender/             # Calendar & scheduling
    │   │   └── presentation/
    │   ├── countdown/            # Countdown timers
    │   │   └── presentation/
    │   ├── edit_bottom_nav_bar/  # Navigation bar customization
    │   │   ├── domain/
    │   │   └── presentation/
    │   ├── eisen_hower_matrix.dart
    │   ├── focus/                # Focus mode
    │   │   └── presentation/views/
    │   ├── habits/               # Habit tracking
    │   │   └── presentation/views/
    │   ├── main/                  # Main dashboard
    │   │   ├── domain/entities/
    │   │   └── presentation/views/
    │   ├── on_boarding/           # Onboarding flow
    │   │   └── presentation/
    │   ├── profile/               # Profile & user settings
    │   │   └── presentation/
    │   ├── search/                # Search functionality
    │   │   └── presentation/views/
    │   ├── settings/              # App settings
    │   │   └── presentation/
    │   ├── splash/                 # Splash screen
    │   │   └── presentation/views/
    │   └── to_do_today/           # Today's tasks
    │       └── presentation/

```
## 🛠 Installation & Setup

1. **Clone the repository**
```bash
git clone https://github.com/ahmed0128382/zentry.git
cd zentry
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

---
