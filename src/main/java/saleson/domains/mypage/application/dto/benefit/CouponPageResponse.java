package saleson.domains.mypage.application.dto.benefit;

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
public class CouponPageResponse {

    private List<CouponResponse> content;
    private PaginationResponse pagination;
}
