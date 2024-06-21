package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CashbillRequest {

    private Long id;

    private String orderCode;

    private String cashbillType;

    private String customerName;        // 고객명

    private String cashbillCode;

    private String pgService;

    private String createdDate;

    private String createdBy; 			// 신정자 - 이름 (loginId)

    private String cashbillPhone1;

    private String cashbillPhone2;

    private String cashbillPhone3;

    private String businessNumber1;

    private String businessNumber2;

    private String businessNumber3;
}
