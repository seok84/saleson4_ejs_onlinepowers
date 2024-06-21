package saleson.domains.order.application.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ConfigPgResponse {

    private Boolean useNpayPayment;

    private String useEscroow;

    private String useAutoCashReceipt;

    private String pgType;

    private String instalment;
}
