package saleson.domains.order.application.dto;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BuyPaymentRequest {
    private String approvalType;

    private String serviceType;

    private int amount;

    private int taxFreeAmount;

    private String bankVirtualNo;

    private String bankInName;

    private List<AccountNumber> accountNumbers;

    private List<String> bankExpirationDate;

    private String mid;

    private String key;

    private String escrowStatus;
}
