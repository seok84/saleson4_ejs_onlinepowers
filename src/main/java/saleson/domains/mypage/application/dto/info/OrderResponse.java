package saleson.domains.mypage.application.dto.info;

import java.util.List;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class OrderResponse {

    private String createdDate;

    private String orderStatus;

    private int orderSequence;

    private String orderCode;

    List<OrderItemResponse> items;

}
