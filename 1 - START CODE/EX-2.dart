class BankAccount {
  // TODO
  final int accountId;
  final String userName;
  double _balance = 0;

  BankAccount(this.accountId, this.userName);

  double get balance => _balance;

  void withdraw(double amount) {
    if (amount <= 0) {
      throw Exception("Withdrawal amount must be positive!");
    }

    if (amount > _balance) {
      throw Exception("Insufficient balance for withdrawal!");
    }

    _balance -= amount;
  }

  void credit(double amount) {
    if (amount <= 0) {
      throw Exception("Credit amount must be positive!");
    }

    _balance += amount;
  }
}

class Bank {
  // TODO
  final String bankName;
  final List<BankAccount> _accounts = [];

  Bank({required this.bankName});

  BankAccount createAccount(int accountId, String userName) {
    for (var acc in _accounts) {
      if (acc.accountId == accountId) {
        throw Exception("Account with ID $accountId already exists!");
      }
    }

    var newAccount = BankAccount(accountId, userName);
    _accounts.add(newAccount);

    return newAccount;
  }
}

void main() {
  Bank myBank = Bank(bankName: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
