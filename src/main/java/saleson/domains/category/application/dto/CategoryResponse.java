package saleson.domains.category.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CategoryResponse {
    private String categoryId;
    private String url;
    private String name;
    private String code;
    private String link;
    private List<CategoryResponse> childCategories;
}
