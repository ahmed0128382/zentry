// Base Employee class
class Employee {
  String id;
  String name;
  String phone;
  String address;
  String position;

  Employee(this.id, this.name, this.phone, this.address, this.position);

  void info() {
    print('Name: $name');
    print('ID: $id');
    print('Phone: $phone');
    print('Position: $position');
  }
}

// Subclasses
class HR extends Employee {
  HR(String id, String name, String phone, String address)
      : super(id, name, phone, address, 'HR');
}

class Security extends Employee {
  Security(String id, String name, String phone, String address)
      : super(id, name, phone, address, 'Security');
}

class Instructor extends Employee {
  Instructor(String id, String name, String phone, String address)
      : super(id, name, phone, address, 'Instructor');
}

// Function to show employee info
void showEmployeeInfoButton(Employee employee) {
  employee.info();
}

void main() {
  // Creating instances of each subclass
  var employee1 = HR('123', 'Ahmed', '01012345678', '123 Street');
  var employee2 = Security('456', 'Mona', '01087654321', '456 Avenue');
  var employee3 = Instructor('789', 'Omar', '01011223344', '789 Boulevard');

  // Show their info
  showEmployeeInfoButton(employee1);
  print(''); // just for spacing
  showEmployeeInfoButton(employee2);
  print('');
  showEmployeeInfoButton(employee3);
}
