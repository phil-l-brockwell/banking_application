# Definition of Controller Class
class Controller
  attr_reader :name, :accounts, :account_id, :holders, :holder_id

  def initialize
    @account_id = 0
    @holder_id  = 0
    @accounts   = {}
    @holders    = {}
  end

  def open_account(type, with:)
    return InvalidHolderMessage.new(with) unless holder = holder_exist?(with)
    new_account = create_account(type, holder)
    add_account new_account
    increment_account_id
    AccountSuccessMessage.new(new_account)
  end

  def create_holder(name)
    new_holder = Holder.new(name, @holder_id)
    increment_holder_id
    @holders[new_holder.id] = new_holder
    NewHolderSuccessMessage.new(new_holder)
  end

  def deposit(amount, into:)
    return InvalidAccountMessage.new(into) unless account = account_exist?(into)
    account.deposit amount
    DepositSuccessMessage.new(amount)
  end

  def withdraw(amount, from:)
    return InvalidAccountMessage.new(from) unless account = account_exist?(from)
    return InsufficientFundsMessage.new(account) unless check account, has: amount
    return OverLimitMessage.new(account) if check_limit_of account, with: amount
    account.withdraw amount
    WithdrawSuccessMessage.new(amount)
  end

  def get_balance_of(account_id)
    return InvalidAccountMessage.new(account_id) unless account = account_exist?(account_id)
    BalanceMessage.new(account)
  end

  def transfer(amount, from:, to:)
    return InvalidAccountMessage.new(from) unless donar = account_exist?(from)
    return InvalidAccountMessage.new(to)   unless recipitent = account_exist?(to)
    return InsufficientFundsMessage.new(donar) unless check donar, has: amount
    return OverLimitMessage.new(donar) if check_limit_of donar, with: amount
    donar.withdraw amount
    recipitent.deposit amount
    TransferSuccessMessage.new(amount)
  end

  def pay_interest_on(account_id)
    return InvalidAccountMessage.new(account_id) unless account = account_exist?(account_id)
    account.add_interest
  end

  def add_holder(id, to_account:)
    return InvalidHolderMessage.new(id) unless new_holder = holder_exist?(id)
    return InvalidAccountMessage.new(to_account) unless account = account_exist?(to_account)
    # Add check on account for holder
    account.add_holder new_holder
    AddHolderSuccessMessage.new(new_holder, account)
  end

  def get_transactions_of(account_id)
    return InvalidAccountMessage.new(account_id) unless account = account_exist?(account_id)
    transactions = account.transactions
    TransactionsMessage.new(transactions)
  end

  def get_accounts_of(holder_id)
    return InvalidHolderMessage.new(holder_id) unless holder = holder_exist?(holder_id)
    accounts = @accounts.select { |_, account| account.main_holder.id == holder.id }.values
    DisplayAccountsMessage.new(accounts)
  end

  ACCOUNT_CLASSES = { :Current  => CurrentAccount,
                      :Savings  => SavingsAccount,
                      :Business => BusinessAccount,
                      :IR       => IRAccount,
                      :SMB      => SMBAccount,
                      :Student  => StudentAccount }

  private

  def check(account, has:)
    account.balance >= has
  end

  def check_limit_of(account, with:)
    with > account.limit
  end

  def add_account(new_account)
    @accounts[new_account.id] = new_account
  end

  def holder_exist?(holder_id)
    @holders[holder_id]
  end

  def account_exist?(account_id)
    @accounts[account_id]
  end

  def create_account(type, holder)
    account_class = ACCOUNT_CLASSES[type]
    account_class.new(holder, @account_id)
  end

  def increment_account_id
    @account_id += 1
  end

  def increment_holder_id
    @holder_id += 1
  end
end
