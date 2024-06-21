package saleson.domains.mypage.application.dto.benefit;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.PaginationResponse;

@Getter @Setter @Builder @AllArgsConstructor @NoArgsConstructor
public class PointPageResponse {

    private List<PointResponse> content;
    private PaginationResponse pagination;

}
