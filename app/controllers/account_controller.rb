require_relative './individual_transaction_controller'
require_relative './mutual_transaction_controller'
require_relative '../db_managers/account_manager'

class AccountController

  def initialize()
    @individual_transaction = IndividualTransactionController.new()
    @mutual_transaction = MutualTransactionController.new()
    @account_manager = AccountManager.new()
  end

  def consign_to_another_account(amount, origin_account_id, final_account_id)
    @mutual_transaction.consign_to_another_account(
      amount,
      origin_account_id,
      final_account_id
    )
  end

  def debit(amount, account_id, location)
    @individual_transaction.transaction_on_account(
      amount,
      account_id,
      'account',
      account_id,
      location
    )
  end

  def withdraw(amount, account_id, location)
    @individual_transaction.transaction_on_account(
      - amount,
      account_id,
      'account',
      account_id,
      location
    )
  end
  
  def find(id)
    @account_manager.find(id)
  end
  
  def insert(avaiable_balance, total_balance)
    date = DateTime.now
    account_map = {:available_balance => avaiable_balance, :total_balance => total_balance, :creation_date => date.strftime('%Y-%m-%d %H:%M:%S')}
    @account_manager.insert(account_map)
  end
    
  def delete(id)
    @account_manager.delete(id)
  end
end