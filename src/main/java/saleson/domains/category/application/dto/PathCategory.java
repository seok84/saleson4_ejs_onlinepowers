package saleson.domains.category.application.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.CodeResponse;

import java.util.List;

@Getter
@Setter
@Builder
public class PathCategory {
    private String categoryId;
    private String categoryName;
    private String categoryUrl;
    private List<CodeResponse> sibling;
}
