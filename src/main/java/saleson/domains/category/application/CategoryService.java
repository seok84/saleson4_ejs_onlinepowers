package saleson.domains.category.application;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.servlet.ModelAndView;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContextHolder;
import saleson.domains.category.application.dto.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class CategoryService {

    public final String SESSION_KEY = "FRONT_CATEGORIES";
    public final String SHOP_CATEGORY_TEAM_KEY = "shop";
    public final String FRONT_SHOP_CATEGORY_GROUP_KEY = "saleson";

    private final SalesonApi salesonApi;
    private final SalesonContextHolder salesonContextHolder;

    public void setModelForFrontCategories(ModelAndView modelAndView, HttpServletRequest request) {
        HttpSession session = request.getSession();
        FrontCategoriesResponse frontCategories = (FrontCategoriesResponse) session.getAttribute(SESSION_KEY);

        try {

            boolean updated;

            if (ObjectUtils.isEmpty(frontCategories)) {
                updated = true;
            } else {
                Map<String, String> params = new HashMap<>();
                params.put("d", frontCategories.getUpdatedDate());

                UpdatedCheckResponse updatedCheck = salesonApi.get(salesonContextHolder.getSalesonContext(request),
                        "/api/category/updated-check",
                        params,
                        UpdatedCheckResponse.class);

                if (ObjectUtils.isEmpty(updatedCheck)) {
                    updated = true;
                } else {
                    updated = updatedCheck.isCategoryUpdateFlag();
                }
            }

            if (updated) {
                frontCategories = salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/category", FrontCategoriesResponse.class);

                session.setAttribute(SESSION_KEY, frontCategories);
            }

        } catch (Exception ignore) {
            log.error("setModelForFrontCategories api error {}", ignore.getMessage(), ignore);
        }

        modelAndView.addObject("shopCategories", getShopCategories(frontCategories));
    }

    public List<CategoryResponse> getShopCategories(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return getShopCategories((FrontCategoriesResponse) session.getAttribute(SESSION_KEY));
    }

    public List<CategoryResponse> getShopCategories(FrontCategoriesResponse frontCategories) {

        if (!ObjectUtils.isEmpty(frontCategories) && !ObjectUtils.isEmpty(frontCategories.getList())) {

            return frontCategories.getList();

        }
        return new ArrayList<>();
    }
}
