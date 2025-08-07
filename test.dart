abstract class Employee {
  String name;
  int age;
  int salary;
  String id;
  String address;

  void work();
  Employee(
    this.name,
    this.age,
    this.salary,
    this.id,
    this.address,
  );
}

class Engineer extends Employee {
  String role;
  Engineer(
      super.name, super.age, super.salary, super.id, super.address, this.role);

  @override
  void work() {
    print('Engineer is working');
  }
}

class Manager extends Employee {
  String role;
  Manager(
      super.name, super.age, super.salary, super.id, super.address, this.role);

  @override
  void work() {
    print('Manager is working');
  }
}

class Developer extends Employee {
  String role;
  Developer(
      super.name, super.age, super.salary, super.id, super.address, this.role);

  @override
  void work() {
    print('Developer is working');
  }
}

void printButton(Employee employee) {
  if (employee is Developer) {
    print('${employee.name} the ${employee.role} is working');
  } else if (employee is Engineer) {
    print('${employee.name} the ${employee.role} is working');
  } else if (employee is Manager) {
    print('${employee.name} the ${employee.role} is working');
  } else {
    print('${employee.name} is working');
  }
}

abstract class UseCase<T> {
  T call();
}

class CreateToDo extends UseCase<String> {
  @override
  String call() {
    return 'ToDo Created';
  }
}

void main() {
  printButton(Developer('ahmed', 25, 2500, '1', 'cairo', 'developer'));
  printButton(Engineer('ahmed', 25, 2500, '1', 'cairo', 'Engineer'));
}
