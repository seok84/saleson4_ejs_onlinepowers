package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.PaginationResponse;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShippingItemPageResponse {

    private List<UserDeliveryResponse> content;
    private PaginationResponse pagination;

}
