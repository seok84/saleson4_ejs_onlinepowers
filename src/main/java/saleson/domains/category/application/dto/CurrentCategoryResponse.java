package saleson.domains.category.application.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import saleson.common.api.infra.dto.CodeResponse;

@Slf4j
@Getter
@Setter
@NoArgsConstructor
public class CurrentCategoryResponse {
    private String categoryCode;
    private BreadcrumbResponse breadcrumb;
    private List<List<CodeResponse>> categories;

    public List<PathCategory> getPathCategories() {
        BreadcrumbResponse breadcrumb = getBreadcrumb();
        List<List<CodeResponse>> categories = getCategories();
        List<PathCategory> path = new ArrayList<>();

        try {
            if (!ObjectUtils.isEmpty(breadcrumb) && !ObjectUtils.isEmpty(breadcrumb.getBreadcrumbCategories())) {
                for (int i = 0; i < breadcrumb.getBreadcrumbCategories().size(); i++) {

                    BreadcrumbCategoryResponse breadcrumbCategory = breadcrumb.getBreadcrumbCategories().get(i);
                    List<CodeResponse> sibling = categories.get(i);

                    path.add(
                            PathCategory.builder()
                                    .categoryId(breadcrumbCategory.getCategoryId())
                                    .categoryName(breadcrumbCategory.getCategoryName())
                                    .categoryUrl(breadcrumbCategory.getCategoryUrl())
                                    .sibling(sibling)
                                    .build()
                    );
                }
            }
        } catch (Exception e) {
            log.error("make PathCategories error [{}] {}", getCategoryCode(), e.getMessage(), e);
        }

        return path;
    }

    public List<String> getCategoryUrls() {
        List<String> urls = new ArrayList<>();
        List<PathCategory> pathCategories = getPathCategories();

        if (!ObjectUtils.isEmpty(pathCategories)) {

            for (PathCategory pathCategory : pathCategories) {
                urls.add(pathCategory.getCategoryUrl());
            }
        }

        return urls;
    }

    public String getCategoryPath() {

        List<PathCategory> pathCategories = getPathCategories();
        String delimiter = "/";

        StringBuilder sb = new StringBuilder();
        if (!ObjectUtils.isEmpty(pathCategories)) {
            int index = 0;
            for (PathCategory pathCategory : pathCategories) {
                sb.append(pathCategory.getCategoryName());
                if (pathCategories.size() > (index + 1)) {
                    sb.append(delimiter);
                }
                index++;
            }
        }

        return sb.toString();
    }

    public String getCategoryName() {

        try {
            BreadcrumbResponse breadcrumb = getBreadcrumb();

            if (!ObjectUtils.isEmpty(breadcrumb)
                    && !ObjectUtils.isEmpty(breadcrumb.getBreadcrumbCategories())) {

                return breadcrumb.getBreadcrumbCategories().getLast().getCategoryName();

            }
        } catch (Exception e) {
            log.error("getCategoryName error [{}] {}", getCategoryCode(), e.getMessage(), e);
        }

        return "";
    }
}
