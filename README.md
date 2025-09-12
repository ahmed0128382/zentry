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

| Category                | Tools / Libraries / Approaches                                 |
| ----------------------- | -------------------------------------------------------------- |
| UI Toolkit              | [Flutter](https://flutter.dev)                                 |
| State Management        | [Riverpod](https://riverpod.dev)                               |
| Architecture Pattern    | Clean Architecture + Domain-Driven Design (DDD)                |
| Routing                 | [GoRouter](https://pub.dev/packages/go_router)                 |
| Theming / Styling       | Custom `AppTheme`, `AppColors`, `AppFonts` in `core/theme`      |
| Reusable Components     | Shared widgets in `core/widgets`                               |
| Utilities & Helpers     | Common functions in `core/utils`                               |
| Feature Modularization  | Isolated feature folders in `features/` (e.g., `habits`, `focus`, `calendar`) |
| Shared Enums            | Centralized enums in `shared/enums`                            |
| Domain Layer Entities   | Defined in `main/domain/entities`                              |
| Version Control         | Git + GitHub (private main branch, public showcase branch later) |


---

## 📁 Project Structure (WIP)

```bash
lib
│   constants.dart
│   main.dart
│
└───src
    ├───app/
    │
    ├───config/
    │       app_routes.dart
    │       assets.dart
    │       permission_handler.dart
    │
    ├───core/
    │   ├───application/
    │   │   └───providers/
    │   │           app_database_provider.dart
    │   │           app_palette_provider.dart
    │   │
    │   ├───infrastucture/
    │   │   └───drift/
    │   │       │   app_database.dart
    │   │       │   app_database.g.dart
    │   │       │
    │   │       ├───mappers/
    │   │       └───tables/
    │   │               appearance_table.dart
    │   │               habits_table.dart
    │   │               habit_logs_table.dart
    │   │               habit_reminders_table.dart
    │   │               sections_table.dart
    │   │               tasks_table.dart
    │   │
    │   ├───reminders/
    │   │   ├───application/
    │   │   │   ├───controllers/
    │   │   │   │       reminders_controller.dart
    │   │   │   │
    │   │   │   ├───providers/
    │   │   │   │       notification_service_provider.dart
    │   │   │   │       reminder_controller_provider.dart
    │   │   │   │       reminder_repo_provider.dart
    │   │   │   │
    │   │   │   └───states/
    │   │   │           reminders_state.dart
    │   │   │
    │   │   ├───domain/
    │   │   │   ├───entities/
    │   │   │   │       reminder.dart
    │   │   │   │
    │   │   │   ├───repos/
    │   │   │   │       notification_service.dart
    │   │   │   │       reminder_repo.dart
    │   │   │   │
    │   │   │   ├───usecases/
    │   │   │   │       cancel_reminder.dart
    │   │   │   │       get_all_reminders.dart
    │   │   │   │       get_reminders_for_habit.dart
    │   │   │   │       schedule_reminder.dart
    │   │   │   │
    │   │   │   └───value_objects/
    │   │   │           reminder_time.dart
    │   │   │
    │   │   ├───infrastructure/
    │   │   │   └───repos/
    │   │   │           exact_alarm_helper.dart
    │   │   │           local_notification_service_impl.dart
    │   │   │           reminder_repo_impl.dart
    │   │   │
    │   │   └───presentation/
    │   │       ├───views/
    │   │       │       test_reminder_screen.dart
    │   │       │
    │   │       └───widgets/
    │   │               reminder_card.dart
    │   │               reminder_popup.dart
    │   │
    │   ├───routes/
    │   │       router.dart
    │   │
    │   ├───theme/
    │   │       app_theme.dart
    │   │
    │   ├───utils/
    │   │       app_colors.dart
    │   │       app_date_utils.dart
    │   │       app_decorations.dart
    │   │       app_fonts.dart
    │   │       app_images.dart
    │   │       app_styles.dart
    │   │       palette.dart
    │   │
    │   └───widgets/
    │           custom_card.dart
    │           custom_tag.dart
    │           search_text_field.dart
    │
    ├───features/
    │   ├───appearance/
    │   │   ├───application/
    │   │   │   ├───controllers/
    │   │   │   │       appearance_controller.dart
    │   │   │   │
    │   │   │   ├───providers/
    │   │   │   │       appearance_controller_provider.dart
    │   │   │   │       appearance_repo_provider.dart
    │   │   │   │
    │   │   │   └───usecases/
    │   │   │           load_appearance_settings_usecase.dart
    │   │   │           update_appearance_settings_usecase.dart
    │   │   │
    │   │   ├───domain/
    │   │   │   ├───entities/
    │   │   │   │       appearance_settings.dart
    │   │   │   │
    │   │   │   ├───enums/
    │   │   │   │       season.dart
    │   │   │   │
    │   │   │   └───repos/
    │   │   │           appearance_repo.dart
    │   │   │
    │   │   ├───infrastructure/
    │   │   │   └───repo/
    │   │   │           appearance_repo_impl.dart
    │   │   │
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   them_settings_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   color_grid.dart
    │   │                   color_option.dart
    │   │                   custom_section.dart
    │   │                   navigation_row.dart
    │   │                   season_grid.dart
    │   │                   theme_settings_view_body.dart
    │   │                   toggle_row.dart
    │   │
    │   ├───calender/
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   calender_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   calender.dart
    │   │                   calender_view_header.dart
    │   │                   day_cell.dart
    │   │                   habits_section.dart
    │   │                   habit_item.dart
    │   │                   section_divider.dart
    │   │                   task_item.dart
    │   │                   today_section.dart
    │   │
    │   ├───countdown/
    │   │   └───presentation/
    │   │       └───views/
    │   │               countdown_view.dart
    │   │
    │   ├───edit_bottom_nav_bar/
    │   │   ├───domain/
    │   │   │   └───entities/
    │   │   └───presentation/
    │   │       ├───controllers/
    │   │       └───views/
    │   │           │   edit_bottom_nav_bar_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   edit_bottom_nav_bar_item.dart
    │   │                   edit_nav_bar_tab_item.dart
    │   │                   max_tab_section.dart
    │   │
    │   ├───eisen_hower_matrix.dart/
    │   │   ├───application/
    │   │   │   ├───controllers/
    │   │   │   │       eisenhower_matrix_content_controller.dart
    │   │   │   │       eisenhower_matrix_controller.dart
    │   │   │   │       quadrant_overlay_controller.dart
    │   │   │   │
    │   │   │   └───providers/
    │   │   │           eisenhower_matrix_content_controller_provider.dart
    │   │   │           eisenhower_matrix_controller_provider.dart
    │   │   │           quadrant_overlay_controller_provider.dart
    │   │   │
    │   │   ├───domain/
    │   │   │   ├───entities/
    │   │   │   │       quadrant.dart
    │   │   │   │
    │   │   │   ├───enums/
    │   │   │   │       quadrant_type_enum.dart
    │   │   │   │
    │   │   │   └───repos/
    │   │   │           eisenhower_matrix_repository.dart
    │   │   │
    │   │   ├───infrastructure/
    │   │   │   ├───data_sources/
    │   │   │   └───repos/
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   eisen_hower_matrix_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   add_task_bottom_sheet.dart
    │   │                   eisenhower_matrix_header.dart
    │   │                   eisenhower_matrix_view_body.dart
    │   │                   overlay_dismiss.dart
    │   │                   quadrant_overlay.dart
    │   │                   quadrant_widget.dart
    │   │                   task_tile.dart
    │   │
    │   ├───focus/
    │   │   └───presentation/
    │   │       └───views/
    │   │               focus_view.dart
    │   │               pomodoro_view.dart
    │   │               stop_watch_view.dart
    │   │
    │   ├───habits/
    │   │   ├───application/
    │   │   │   ├───controllers/
    │   │   │   │       habits_controller.dart
    │   │   │   │       habit_logs_controller.dart
    │   │   │   │       habit_reminders_controller.dart
    │   │   │   │       sections_controller.dart
    │   │   │   │       sections_with_habits_controller.dart
    │   │   │   │
    │   │   │   ├───providers/
    │   │   │   │       habits_controller_provider.dart
    │   │   │   │       habit_logs_controller_provider.dart
    │   │   │   │       habit_logs_repo_provider.dart
    │   │   │   │       habit_reminders_controller_provider.dart
    │   │   │   │       habit_reminders_repo_provider.dart
    │   │   │   │       habit_repo_provider.dart
    │   │   │   │       habit_usecases_providers.dart
    │   │   │   │       sections_controller_provider.dart
    │   │   │   │       sections_repo_provider.dart
    │   │   │   │       sections_with_habits_controller_provider.dart
    │   │   │   │       sections_with_habits_provider.dart
    │   │   │   │
    │   │   │   └───states/
    │   │   │           sections_with_habits_state.dart
    │   │   │
    │   │   ├───domain/
    │   │   │   ├───entities/
    │   │   │   │       habit_details.dart
    │   │   │   │       habit_goal.dart
    │   │   │   │       habit_log.dart
    │   │   │   │       habit_reminder.dart
    │   │   │   │       section.dart
    │   │   │   │       section_with_habits.dart
    │   │   │   │
    │   │   │   ├───enums/
    │   │   │   │       habit_frequency.dart
    │   │   │   │       habit_goal_period.dart
    │   │   │   │       habit_goal_record_mode.dart
    │   │   │   │       habit_goal_type.dart
    │   │   │   │       habit_goal_unit.dart
    │   │   │   │       habit_status.dart
    │   │   │   │       section_type.dart
    │   │   │   │       weekday.dart
    │   │   │   │
    │   │   │   ├───repos/
    │   │   │   │       habit_logs_repo.dart
    │   │   │   │       habit_reminders_repo.dart
    │   │   │   │       sections_repo.dart
    │   │   │   │
    │   │   │   ├───usecases/
    │   │   │   │       add_habit.dart
    │   │   │   │       delete_habit.dart
    │   │   │   │       get_habits_for_day.dart
    │   │   │   │       get_sections_with_habits_for_day.dart
    │   │   │   │       log_habit_completion.dart
    │   │   │   │       move_habit_to_section.dart
    │   │   │   │       reorder_habits_within_section.dart
    │   │   │   │       toggle_habit_completion.dart
    │   │   │   │       update_habit.dart
    │   │   │   │
    │   │   │   └───value_objects/
    │   │   │           local_time.dart
    │   │   │           weekday_mask.dart
    │   │   │
    │   │   ├───infrastructure/
    │   │   │   ├───mappers/
    │   │   │   │       habit_log_mapper.dart
    │   │   │   │       habit_mapper.dart
    │   │   │   │       habit_reminder_mapper.dart
    │   │   │   │       habit_section_mapper.dart
    │   │   │   │
    │   │   │   └───repos/
    │   │   │           habits_repo_impl.dart
    │   │   │           habit_logs_repo_impl.dart
    │   │   │           habit_reminders_repo_impl.dart
    │   │   │           section_repo_impl.dart
    │   │   │
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   add_habit_view.dart
    │   │           │   edit_habit_view.dart
    │   │           │   habits_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   calender_day.dart
    │   │                   calender_header.dart
    │   │                   calender_header_widget.dart
    │   │                   date_button.dart
    │   │                   drop_down_widget.dart
    │   │                   habits_view_header.dart
    │   │                   habit_item.dart
    │   │                   habit_item_widget.dart
    │   │                   number_field.dart
    │   │                   reminders_section.dart
    │   │                   section_drop_down.dart
    │   │                   section_header.dart
    │   │                   section_header_widget.dart
    │   │                   section_list_widget.dart
    │   │                   section_widget.dart
    │   │                   text_field_widget.dart
    │   │                   week_days_selector.dart
    │   │
    │   ├───main/
    │   │   ├───application/
    │   │   │   ├───controllers/
    │   │   │   │       main_navigation_controller.dart
    │   │   │   │
    │   │   │   └───providers/
    │   │   │           current_tab_index_provider.dart
    │   │   │           main_nav_provider.dart
    │   │   │           more_menu_type_provider.dart
    │   │   │
    │   │   ├───domain/
    │   │   │   └───entities/
    │   │   │           main_view_page_index.dart
    │   │   │
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   main_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   bottom_bar_item.dart
    │   │                   custom_navigation_bottom_bar.dart
    │   │                   expandable_more_menu.dart
    │   │                   main_bottom_navigation_bar.dart
    │   │                   main_view_body.dart
    │   │                   main_view_pages.dart
    │   │                   quarter_circle_menu.dart
    │   │                   settings_menu_type_dropdown.dart
    │   │
    │   ├───on_boarding/
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   on_boarding_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   on_boarding_view_body.dart
    │   │
    │   ├───profile/
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   profile_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   achievement_score_widget.dart
    │   │                   badge_item.dart
    │   │                   badge_widget.dart
    │   │                   focus_statistics.dart
    │   │                   focus_text_stat.dart
    │   │                   habit_day.dart
    │   │                   profile_section.dart
    │   │                   profile_view_body.dart
    │   │                   profile_view_header.dart
    │   │                   task_statistics_widget.dart
    │   │                   weekly_habit_status_widget.dart
    │   │
    │   ├───search/
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   search_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   search_empty_state.dart
    │   │                   search_header.dart
    │   │                   search_input.dart
    │   │
    │   ├───settings/
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   settings_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   settings_header.dart
    │   │                   settings_integration_section.dart
    │   │                   settings_item.dart
    │   │                   settings_premium_section.dart
    │   │                   settings_section.dart
    │   │                   settings_user_profile.dart
    │   │
    │   ├───splash/
    │   │   └───presentation/
    │   │       └───views/
    │   │           │   splash_view.dart
    │   │           │
    │   │           └───widgets/
    │   │                   splash_view_body.dart
    │   │
    │   └───to_do_today/
    │       ├───application/
    │       │   ├───controllers/
    │       │   │       priority_overlay_controller.dart
    │       │   │       task_content_controller.dart
    │       │   │       task_details_controller.dart
    │       │   │       task_list_controller.dart
    │       │   │       to_do_today_controller.dart
    │       │   │
    │       │   ├───providers/
    │       │   │       priority_overlay_controller_provider.dart
    │       │   │       task_by_id_provider.dart
    │       │   │       task_details_controller_provider.dart
    │       │   │       task_list_controller_provider.dart
    │       │   │       task_repo_provider.dart
    │       │   │       to_do_today_controller_provider.dart
    │       │   │
    │       │   └───usecases/
    │       │           add_task.dart
    │       │           delete_task.dart
    │       │           edit_task.dart
    │       │           get_task.dart
    │       │
    │       ├───domain/
    │       │   ├───entities/
    │       │   ├───repos/
    │       │   ├───services/
    │       │   │       task_validation_service.dart
    │       │   │
    │       │   └───value_objects/
    │       │           due_date.dart
    │       │           task_title.dart
    │       │
    │       ├───infrastructure/
    │       │   ├───data_sources/
    │       │   │   └───drift/
    │       │   │       │   drift_database.dart
    │       │   │       │
    │       │   │       ├───mappers/
    │       │   │       │       task_mapper.dart
    │       │   │       │
    │       │   │       └───tables/
    │       │   └───repos/
    │       │           tasks_repo_impl.dart
    │       │
    │       └───presentation/
    │           └───views/
    │               │   add_section_view.dart
    │               │   task_details_view.dart
    │               │   to_do_today_view.dart
    │               │
    │               └───widgets/
    │                       add_task_bottom_sheet.dart
    │                       centered_progress.dart
    │                       completed_header.dart
    │                       completed_tasks.dart
    │                       confirm_dialogs.dart
    │                       custom_app_bar.dart
    │                       editable_text_field.dart
    │                       error_view.dart
    │                       meta_row.dart
    │                       more_overlay.dart
    │                       overlay_dismiss.dart
    │                       priority_overlay.dart
    │                       save_bar.dart
    │                       task_content.dart
    │                       task_header.dart
    │                       task_item.dart
    │                       task_list.dart
    │
    └───shared/
        ├───domain/
        │   ├───entities/
        │   │       habit.dart
        │   │       task.dart
        │   │
        │   ├───errors/
        │   │       failure.dart
        │   │       result.dart
        │   │
        │   └───repos/
        │           habits_repo.dart
        │           task_repo.dart
        │
        ├───enums/
        │       app_theme_mode.dart
        │       main_view_pages_index.dart
        │       menu_types.dart
        │       tasks_priority.dart
        │
        └───infrastructure/
            ├───errors/
            │       error_mapper.dart
            │
            └───utils/
                    guard.dart

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
