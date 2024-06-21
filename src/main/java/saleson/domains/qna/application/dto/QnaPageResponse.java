package saleson.domains.qna.application.dto;


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
public class QnaPageResponse {

    private List<QnaResponse> content;
    private List<CodeResponse> qnaGroups;
	private PaginationResponse pagination;

}
