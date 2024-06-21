package saleson.domains.common.application.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.PaginationResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IslandPageResponse {

    private List<IslandResponse> content;

    private PaginationResponse pagination;
}
