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
@NoArgsConstructor
@AllArgsConstructor
public class WishListPageResponse {

    private List<WishListResponse> content;
    private PaginationResponse pagination;
}
