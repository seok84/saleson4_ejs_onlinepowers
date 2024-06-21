package saleson.domains.order.application.dto;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BuyPaymentResponse {
    private String approvalType;
    private String serviceType;
    private int amount;
    private int taxFreeAmount;

    private String bankExpirationDate;
    private List<AccountNumber> accountNumbers;
    private List<String> expirationDates;

    private String mid;
    private String key;

    private String bankVirtualNo;
    private String bankInName;

    private String escrowStatus;
}
