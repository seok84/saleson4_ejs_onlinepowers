package saleson.domains.category.application.dto;

import lombok.*;

import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
public class BreadcrumbListResponse {
	private List<BreadcrumbResponse> list;
}
