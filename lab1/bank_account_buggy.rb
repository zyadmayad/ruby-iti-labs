# =============================================================================
# Phase 2 — The AI Audit: Bank Account
#
# This script was "written by AI." It has exactly 5 mistakes:
#   - 2 syntax errors  (Ruby won't even run until these are fixed)
#   - 3 logic flaws    (Ruby runs but produces wrong results)
#
# Your job: find all 5, add a comment above each bug, then fix them.
# Use this format for your comments:
#   # BUG [n]: [what is wrong] → FIX: [what it should be]
# =============================================================================

class BankAccount
  attr_reader :balance, :owner

  def initialize(owner, initial_balance)
    @owner   = owner
    @balance = initial_balance
    @rate    = 0.05
  end

  def deposit(amount)
    if amount > 0
      @balance += amount # BUG [4]: [Deposit was withdrawing] → FIX: [fixed -= to +=]
      puts "  New balance: $#{"%.2f" % @balance}"
    else
      puts "  Error: Deposit amount must be positive."
    end
  end

  def withdraw(amount)
    if amount > @balance # BUG [3]: [Previous code was withdrawing money even if balance wasn't enough] → FIX: [added a checker]
      puts "Error: Insufficient funds. Balance: $#{@balance}"
    else
      @balance -= amount
      puts "  New balance: $#{"%.2f" % @balance}"
    end
  end # BUG [1]: [Expected end here was missing] → FIX: [Added end back]

  def apply_interest
    @balance += @balance * @rate # BUG [5]: [this wasn't adding interest to balance, it was setting balance to interest] → FIX: [fixed = and made it +=]
    puts "  New balance: $#{"%.2f" % @balance}"
  end

  def display_info
    puts "Owner  : #{@owner}"
    puts "Balance: $#{@balance}" # BUG [2]: [AI Added ( instead { ] → FIX: [Fixed it from $#(@balance} to $#{@balance}]
  end
end

# --- Script entry point ---

account = BankAccount.new("Alice", 1000)

puts "=== Account Info ==="
account.display_info
puts

puts "Depositing $500..."
account.deposit(500)
puts

puts "Withdrawing $200..."
account.withdraw(200)
puts

puts "Applying 5% interest..."
account.apply_interest
puts

puts "Attempting to overdraw $2000..."
account.withdraw(2000)
puts
account.display_info
