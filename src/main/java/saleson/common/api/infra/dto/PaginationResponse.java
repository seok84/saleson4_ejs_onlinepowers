package saleson.common.api.infra.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PaginationResponse {
    private int currentPage;
    private boolean last;
    private int totalPages;
    private int totalElements;
    private boolean first;
}
