# Zentry 🧠📅

Zentry is a task management and productivity app inspired by **TickTick**, with additional gamification elements like points, badges, and premium features.  
The app is currently under active development using Flutter and follows professional software engineering practices.

---

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
    ├── core/
    │   ├── theme/           # AppTheme, styles, colors, fonts
    │   └── utils/           # Shared constants or helpers
    ├── features/
    │   └── splash/
    │       ├── presentation/
    │       │   ├── views/
    │       │   │   └── splash_view.dart
    │       │   └── widgets/
    │       │       └── splash_view_body.dart
    └── main.dart           # Entry point

```
