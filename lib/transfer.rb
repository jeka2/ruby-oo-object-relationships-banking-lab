class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount, status = 'pending')
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.status == 'pending'
      if self.amount > self.sender.balance || !self.sender.valid? || !self.receiver.valid?
        self.status = 'rejected'
        "Transaction rejected. Please check your account balance."
      else
        self.sender.balance -= amount
        self.receiver.balance += amount
        self.status = 'complete'
      end
    end
  end

  def reverse_transfer
    binding.pry
    if status == 'complete'
      self.sender.balance += amount
      self.receiver.balance -= amount
    end
    self.status = 'reversed'
  end
end
