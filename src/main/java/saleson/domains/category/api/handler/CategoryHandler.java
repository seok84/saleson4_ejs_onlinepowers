package saleson.domains.category.api.handler;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import saleson.domains.category.application.CategoryService;
import saleson.domains.category.application.dto.CategoryResponse;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class CategoryHandler {

    private final CategoryService categoryService;


    public List<CategoryResponse> getChildCategories(HttpServletRequest request, List<String> urls) {
        List<CategoryResponse> list = new ArrayList<>();
        List<CategoryResponse> shopCategories = categoryService.getShopCategories(request);

        if (!ObjectUtils.isEmpty(urls) && !ObjectUtils.isEmpty(shopCategories)) {

            CategoryResponse categoryResponse = null;

            for (int urlIndex = 0; urlIndex <= urls.size(); urlIndex++) {

                String url = urls.get(urlIndex);

                if (urlIndex == 0) {
                    categoryResponse =
                            shopCategories.stream()
                                    .filter(c -> url.equals(c.getUrl()))
                                    .findFirst().orElse(null);
                }

                if (!ObjectUtils.isEmpty(categoryResponse)) {

                    List<CategoryResponse> child = categoryResponse.getChildCategories();

                    if (ObjectUtils.isEmpty(child)) {
                        list = new ArrayList<>();
                        break;
                    }

                    if (urlIndex == urls.size() -1) {
                        list.addAll(child);
                        break;
                    } else {
                        categoryResponse =
                                child.stream()
                                        .filter(c -> url.equals(c.getUrl()))
                                        .findFirst().orElse(null);
                    }
                } else {
                    list = new ArrayList<>();
                    break;
                }
            }
        }

        return list;
    }
}
