package saleson.domains.mypage.application.dto.info;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class PaymentInfo {
    
    private String approvalType;

    private String approvalTypeLabel;

    private String paymentType;

    private int amount;

    private int remainingAmount;

    private int cancelAmount;
    
    private String payDate;

    private String bankVirtualNo;

    private String bankInName;

    private String payInfo;

    private String bankDate;

}
