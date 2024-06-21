package saleson.domains.category.application.dto;

import lombok.*;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BreadcrumbCategoryResponse {
	private String categoryId;
	private String categoryName;
	private String categoryUrl;
	private String groupUrl;
	private String indexId;
}
