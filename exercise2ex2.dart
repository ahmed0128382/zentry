class BankAccount {
  double _balance;

  BankAccount() : _balance = 0;

  // Getter for balance
  double get balance => _balance;

  // Deposit method
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited: \$${amount.toStringAsFixed(0)}');
      print('Balance: \$${_balance.toStringAsFixed(0)}');
    } else {
      print('Deposit amount must be positive!');
    }
  }

  // Withdraw method
  void withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      print('Withdrew: \$${amount.toStringAsFixed(0)}');
      print('Balance: \$${_balance.toStringAsFixed(0)}');
    } else {
      print('Insufficient funds!');
      print('Balance: \$${_balance.toStringAsFixed(0)}');
    }
  }
}

void main() {
  var account = BankAccount();

  account.deposit(1000);
  account.withdraw(500);
  account.withdraw(600); // Should print "Insufficient funds!"
}
