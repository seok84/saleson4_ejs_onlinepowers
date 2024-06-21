package saleson.domains.category.api;

import jakarta.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.pagination.PaginationHandler;
import saleson.domains.category.api.handler.CategoryHandler;
import saleson.domains.category.application.dto.CurrentCategoryResponse;
import saleson.domains.item.application.dto.ItemListCriteria;
import saleson.domains.item.application.dto.ItemPageResponse;

@RequiredArgsConstructor
@Controller
@RequestMapping("/category")
public class CategoryController {

    private final PaginationHandler paginationHandler;
    private final AsyncDataService asyncDataService;
    private final SalesonApi salesonApi;
    private final CategoryHandler categoryHandler;

    @RequestMapping("/{categoryCode}")
    public String index(Model model, HttpServletRequest request,
                        @PathVariable("categoryCode") String categoryCode,
                        ItemListCriteria itemListCriteria) throws Exception {

        itemListCriteria.setCategoryCode(categoryCode);
        itemListCriteria.setSize(24);

        Map<String, Object> currentParams = new LinkedHashMap<>();
        currentParams.put("categoryCode", categoryCode);

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("pageContent", "/api/item", HttpMethod.GET, ItemPageResponse.class, salesonApi.convert(itemListCriteria)),
                new AsyncDataRequest<>("current", "/api/category/current", HttpMethod.GET, CurrentCategoryResponse.class, currentParams)
                );

        CurrentCategoryResponse current = (CurrentCategoryResponse) model.getAttribute("current");

        model.addAttribute("criteria", itemListCriteria);

        if (!ObjectUtils.isEmpty(current)) {
            model.addAttribute("childCategories", categoryHandler.getChildCategories(request, current.getCategoryUrls()));
        }

        paginationHandler.setModelForPaginationUrl(model, request);

        return "category/list";
    }

}
