package saleson.domains.customer.api.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.common.api.infra.dto.PaginationResponse;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class NoticePageResponse {

    private List<NoticeResponse> content;
    private PaginationResponse pagination;

    @Builder
    public NoticePageResponse(List<NoticeResponse> content, PaginationResponse pagination) {
        this.content = content;
        this.pagination = pagination;
    }
}
