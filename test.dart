// abstract class Employee {
//   String name;
//   int age;
//   int salary;
//   String id;
//   String address;

//   void work();
//   Employee(
//     this.name,
//     this.age,
//     this.salary,
//     this.id,
//     this.address,
//   );
// }

// class Engineer extends Employee {
//   String role;
//   Engineer(
//       super.name, super.age, super.salary, super.id, super.address, this.role);

//   @override
//   void work() {
//     print('Engineer is working');
//   }
// }

// class Manager extends Employee {
//   String role;
//   Manager(
//       super.name, super.age, super.salary, super.id, super.address, this.role);

//   @override
//   void work() {
//     print('Manager is working');
//   }
// }

// class Developer extends Employee {
//   String role;
//   Developer(
//       super.name, super.age, super.salary, super.id, super.address, this.role);

//   @override
//   void work() {
//     print('Developer is working');
//   }
// }

// void printButton(Employee employee) {
//   if (employee is Developer) {
//     print('${employee.name} the ${employee.role} is working');
//   } else if (employee is Engineer) {
//     print('${employee.name} the ${employee.role} is working');
//   } else if (employee is Manager) {
//     print('${employee.name} the ${employee.role} is working');
//   } else {
//     print('${employee.name} is working');
//   }
// }

// abstract class UseCase<T> {
//   T call();
// }

// class CreateToDo extends UseCase<String> {
//   @override
//   String call() {
//     return 'ToDo Created';
//   }
// }

// void main() {
//   printButton(Developer('ahmed', 25, 2500, '1', 'cairo', 'developer'));
//   printButton(Engineer('ahmed', 25, 2500, '1', 'cairo', 'Engineer'));
// }
class Task {
  String taskTitle;
  String taskDescription;
  String dateTime;
  String image;

  Task(this.dateTime, this.taskDescription, this.image, this.taskTitle);

  @override
  String toString() => 'Task: $taskTitle';
}

// Generic base UseCase
abstract class UseCase<T> {
  T call();
}

// 1. GetTasks returns List<Task>
class GetTasks extends UseCase<List<Task>> {
  @override
  List<Task> call() {
    // Return fake tasks
    return [
      Task("2025-08-11", "Complete math exercises", "math.png", "Math Task"),
      Task("2025-08-12", "Prepare science project", "science.png",
          "Science Project"),
    ];
  }
}

// 2. CreateTask returns String confirmation
class CreateTask extends UseCase<String> {
  final Task newTask;

  CreateTask(this.newTask);

  @override
  String call() {
    // Simulate adding task (e.g., print it)
    print("Creating task: ${newTask.taskTitle}");
    // Return confirmation message
    return "Task added successfully";
  }
}

// 3. EditTask returns int (1 success, 0 failure)
class EditTask extends UseCase<int> {
  final Task taskToEdit;
  final String newTitle;

  EditTask(this.taskToEdit, this.newTitle);

  @override
  int call() {
    // Simulate editing task title
    if (taskToEdit.taskTitle.isNotEmpty) {
      print("Editing task from '${taskToEdit.taskTitle}' to '$newTitle'");
      taskToEdit.taskTitle = newTitle;
      return 1; // success
    }
    return 0; // failure
  }
}

void main() {
  // 1. Get tasks
  final getTasks = GetTasks();
  final tasks = getTasks();
  print(tasks);

  // 2. Create a new task
  final createTask =
      CreateTask(Task("2025-08-15", "Write essay", "essay.png", "Essay Task"));
  print(createTask());

  // 3. Edit an existing task
  final editTask = EditTask(tasks[0], "Updated Math Task");
  final editResult = editTask();
  print("Edit completed successfully (code: $editResult)");
}
