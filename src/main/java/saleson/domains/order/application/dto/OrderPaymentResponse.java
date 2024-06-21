package saleson.domains.order.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderPaymentResponse {

    private String orderCode;

    private int orderSequence;

    private int paymentSequence;

    private String paymentType;

    private String approvalType;

    private String approvalTypeLabel;
}
