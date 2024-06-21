package saleson.domains.display.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.PaginationResponse;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DisplayReviewPageResponse {

    private List<DisplayReviewResponse> content;
    private PaginationResponse pagination;

}
