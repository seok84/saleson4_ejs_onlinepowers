package saleson.domains.customer.api.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.CodeResponse;
import saleson.common.api.infra.dto.PaginationResponse;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FaqPageResponse {

    private List<FaqResponse> content;
    private List<CodeResponse> types;
	private PaginationResponse pagination;

}
