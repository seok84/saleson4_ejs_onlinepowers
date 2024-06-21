package saleson.domains.brand.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.api.infra.exception.SalesonApiException;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.pagination.PaginationHandler;
import saleson.domains.brand.api.dto.BrandCriteria;
import saleson.domains.brand.api.dto.BrandResponse;
import saleson.domains.brand.api.dto.SimpleBrandListResponse;
import saleson.domains.brand.api.dto.SimpleBrandResponse;
import saleson.domains.item.application.dto.ItemPageResponse;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/brand")
@RequiredArgsConstructor
@Slf4j
public class BrandController {

    private final AsyncDataService asyncDataService;
    private final SalesonApi salesonApi;
    private final SalesonContextHolder salesonContextHolder;
    private final PaginationHandler paginationHandler;
    private final FrontEventHandler frontEventHandler;


    @GetMapping("")
    public String index(Model model, HttpServletRequest request, BrandCriteria criteria) {

        int apiBrandId = criteria.getBrandId();

        SimpleBrandListResponse simpleBrandListResponse
                = salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/brand", SimpleBrandListResponse.class);

        if (!ObjectUtils.isEmpty(simpleBrandListResponse)) {
            List<SimpleBrandResponse> brands = simpleBrandListResponse.getList();

            if (ObjectUtils.isEmpty(brands)) {
                brands = new ArrayList<>();
            } else {

                if (apiBrandId <= 0) {
                    apiBrandId = brands.get(0).getBrandId();
                }
            }


            model.addAttribute("brands", brands);
        }

        String apiUri = "/api/brand/" + apiBrandId;

        criteria.setBrandId(apiBrandId);
        model.addAttribute("criteria", criteria);

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("brand", apiUri, HttpMethod.GET, BrandResponse.class),
                new AsyncDataRequest<>("pageContent", apiUri + "/items", HttpMethod.GET, ItemPageResponse.class, salesonApi.convert(criteria))
        );

        paginationHandler.setModelForPaginationUrl(model, request);
        frontEventHandler.setHeaderDetail(model, "관심 집중 브랜드");
        return "brand/index";
    }

    @GetMapping("/{brandId}")
    public String list(Model model, HttpServletRequest request,
                       @PathVariable("brandId") int brandId, Criteria criteria) {


        String apiUri = "/api/brand/" + brandId;

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("brand", apiUri, HttpMethod.GET, BrandResponse.class),
                new AsyncDataRequest<>("pageContent", apiUri + "/items", HttpMethod.GET, ItemPageResponse.class, salesonApi.convert(criteria))
        );

        paginationHandler.setModelForPaginationUrl(model, request);


        return "brand/list";
    }

}
