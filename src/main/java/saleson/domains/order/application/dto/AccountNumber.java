package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountNumber {
    private int shopConfigId = 1;

    private int accountNumberId;

    private String bankName;

    private String accountNumber;

    private String accountHolder;

    private String useFlag;

    private long userId;

    private String created;
}
