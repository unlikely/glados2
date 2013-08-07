module ApplicationHelper
  def lease_total_payments(possession_contracts)
    @total = 0
    if possession_contracts.present?
      possession_contracts.each do | pos |
        if (pos.contract_type == "lease") && (pos.expires.present?)
          @total += pos.payment
        end
      end
      return @total
     else
        return 0
      end
    end
end
