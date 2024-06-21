package saleson.domains.featured.api.dto;

import lombok.*;
import saleson.common.api.infra.dto.PaginationResponse;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FeaturedReplyPageResponse {

    private List<FeaturedReplyResponse> content;
    private PaginationResponse pagination;

}
