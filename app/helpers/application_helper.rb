module ApplicationHelper
  def cents_to_dollars(amount)
    number_to_currency(amount)
  end

  def dollars_to_cents(amount)
    if amount.present?
      amount * 100
    end
  end

  def count_equipment_owned(people)
    @count = 0
    people.each do | person |
      @count += person.equipment.count
    end
    return @count
  end

  def lease_total_payments(people)
    @total = 0
    people.each do | person |
      person.possession_contracts.each do | pos |
        if (pos.contract_type == "lease") && (pos.expires.present?)
          @total += pos.payment
        end
      end
    end
    return @total
  end
end
