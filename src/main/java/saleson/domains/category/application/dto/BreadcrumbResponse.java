package saleson.domains.category.application.dto;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
public class BreadcrumbResponse {
	private String teamId;
	private String teamName;
	private String teamUrl;
	private String groupId;
	private String groupName;
	private String groupUrl;
	private String categoryClass;
	
	private List<BreadcrumbCategoryResponse> breadcrumbCategories = new ArrayList<>();

}
