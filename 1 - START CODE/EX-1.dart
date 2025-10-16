enum Skill { FLUTTER, DART, OTHER }

class Employee {
  final String name;
  final double baseSalary;
  final List<Skill> skills;
  final Address address;
  final int yearOfExperience;

  Employee.regular({
    required this.name,
    required this.baseSalary,
    required this.skills,
    required this.address,
    required this.yearOfExperience,
  });

  Employee.mobileDeveloper({
    required String employeeName,
    required double employeeBaseSalary,
    required Address employeeAddress,
    required int employeeYearOfExperience,
  }) : this.name = employeeName,
       this.baseSalary = employeeBaseSalary,
       this.skills = [Skill.FLUTTER, Skill.DART],
       this.address = employeeAddress,
       this.yearOfExperience = employeeYearOfExperience;

  String get employeeName => name;
  double get employeeBaseSalary => baseSalary;
  List<Skill> get employeeSkill => skills;
  Address get employeeAddress => address;
  int get employeeYearOfExperience => yearOfExperience;

  double computeSalary() {
    double salary = baseSalary + (yearOfExperience * 2000);

    for (var skill in skills) {
      switch (skill) {
        case Skill.FLUTTER:
          salary += 5000;
          break;
        case Skill.DART:
          salary += 3000;
          break;
        case Skill.OTHER:
          salary += 1000;
          break;
      }
    }

    return salary;
  }

  void printDetails() {
    String skillName = skills.map((s) => s.name).join(', ');

    print('--- Employee Detail ---');

    print('Name: $name');
    print('Base Salary: $baseSalary');
    print('Skill: $skillName');
    print('Address: ${address.street}, ${address.city}, ${address.zipCode}');
    print('Year Of Experience: $yearOfExperience');
    print('Total Salary: \$${computeSalary()}');
  }
}

class Address {
  final String street;
  final String city;
  final String zipCode;

  Address(this.street, this.city, this.zipCode);
}

void main() {
  var address = Address('2004', 'Phnom Penh', 'AC1014');

  var emp1 = Employee.mobileDeveloper(
    employeeName: 'Sokea',
    employeeBaseSalary: 42000,
    employeeAddress: address,
    employeeYearOfExperience: 2,
  );
  emp1.printDetails();

  var emp2 = Employee.regular(
    name: 'Ronan',
    baseSalary: 45000,
    skills: [Skill.DART],
    address: address,
    yearOfExperience: 1,
  );
  emp2.printDetails();

  var emp3 = Employee.regular(
    name: 'Tola',
    baseSalary: 43000,
    skills: [Skill.OTHER],
    address: address,
    yearOfExperience: 3,
  );
  emp3.printDetails();
}
