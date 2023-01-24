module TransactionHistoriesHelper
  def find_client_code_by_wallet_address(address)
    if address.present?
      wallet      = find_client_wallet(address)
      client_type = find_client_type_by_wallet(wallet)

      if client_type == User
        return wallet.user.code
      elsif client_type == Team
        return wallet.team.code
      elsif client_type == Stock
        return wallet.stock.code
      end
    end
  end

  def find_client_name_by_transaction_history(transaction_history)
    if transaction_history.receiver_id == "withdrawal" || transaction_history.receiver_id == "topup"
      wallet      = find_client_wallet(transaction_history.sender_id)
      client_code = find_client_code_by_wallet_address(transaction_history.sender_id)
    elsif transaction_history.receiver_id.present?
      wallet      = find_client_wallet(transaction_history.receiver_id)
      client_code = find_client_code_by_wallet_address(transaction_history.receiver_id)
    else
      return nil
    end

    client  = find_client_type_by_wallet(wallet)
    user    = client.find_by_code(client_code)
    return user.name
  end

  def find_client_type_by_wallet(wallet)
    if wallet.present?
      if wallet.user.present?
        return User
      elsif wallet.team.present?
        return Team
      elsif wallet.stock.present?
        return Stock
      end
    end
  end

  def find_client_wallet(address)
    wallet = Wallet.find_by_address(address)

    return wallet
  end

  def find_client_path(address)
    if address.present?
      wallet      = find_client_wallet(address)
      client_type = find_client_type_by_wallet(wallet)

      if client_type == User
        return "users/#{wallet.user.code}"
      elsif client_type == Team
        return "teams/#{wallet.team.code}"
      elsif client_type == Stock
        return "stocks/#{wallet.stock.code}"
      end
    end
  end

  def format_amount(transaction_history)
    if check_transaction_history_type(transaction_history)
      return number_to_currency(transaction_history.amount * -1, unit: "$")
    else
      return number_to_currency(transaction_history.amount, unit: "$")
    end
  end

  def check_transaction_history_type(transaction_history)
    return true if transaction_history.type == "Credit"
  end
end