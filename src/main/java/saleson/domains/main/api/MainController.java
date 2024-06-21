package saleson.domains.main.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.utils.FrontUtils;
import saleson.common.view.JsonView;
import saleson.domains.common.api.dto.AboutUsResponse;
import saleson.domains.display.application.DisplayService;
import saleson.domains.display.application.dto.DisplayReviewListResponse;
import saleson.domains.display.application.dto.DisplayTagCriteria;
import saleson.domains.display.application.dto.PromotionResponse;
import saleson.domains.featured.api.dto.FeaturedPageResponse;
import saleson.domains.item.application.dto.ItemPageResponse;
import saleson.domains.main.api.dto.DisplayPopupResponse;
import saleson.domains.main.api.dto.MainBrandListResponse;
import saleson.domains.popup.application.dto.PopupListResponse;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {

    private final SalesonApi salesonApi;
    private final SalesonContextHolder salesonContextHolder;
    private final DisplayService displayService;
    private final FrontEventHandler frontEventHandler;
    private final AsyncDataService asyncDataService;

    @GetMapping("/")
    public String index(Model model, HttpServletRequest request) throws Exception {

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("promotion", "/api/display/promotion", HttpMethod.GET, PromotionResponse.class)
        );

        try {
            PromotionResponse promotionResponse = (PromotionResponse) model.getAttribute("promotion");
            if (!ObjectUtils.isEmpty(promotionResponse)) {
                frontEventHandler.setPreloadImageLinkTag(model, promotionResponse.getPromotionItemList());
            }

        } catch (Exception e) {
        }

        return "main/index";
    }

    @GetMapping("/footer")
    public String footer(Model model, HttpServletRequest request) {

        try {

            asyncDataService.setModelBy(request, model,
                    new AsyncDataRequest<>("aboutUs", "/api/common/about-us", HttpMethod.GET, AboutUsResponse.class)
            );

        } catch (Exception e) {
            log.error("footer error {}", e.getMessage(), e);
        }

        return "include/footer/footer";
    }

    @GetMapping("/main/group-best/item-list")
    public String groupBestItemList(Model model, HttpServletRequest request, DisplayTagCriteria criteria) {

        criteria.setSize(5);
        criteria.setPage(1);

        ItemPageResponse itemPageResponse;
        if (ObjectUtils.isEmpty(criteria.getTag())) {
            itemPageResponse = new ItemPageResponse();
        } else {
            itemPageResponse = displayService.getGroupBestItems(salesonContextHolder.getSalesonContext(request), criteria);
        }

        model.addAttribute("groupBestItems", itemPageResponse);

        return "main/include/best-item-list-container";
    }

    @GetMapping("/main/brand-list")
    public String brandList(Model model, HttpServletRequest request) {

        model.addAttribute("brandList",
                salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/brand/main", MainBrandListResponse.class));

        return "main/include/brand-list";
    }

    @GetMapping("/main/md-list")
    public String mdItemList(Model model, HttpServletRequest request, DisplayTagCriteria criteria) {

        criteria.setSize(5);
        criteria.setPage(1);

        ItemPageResponse itemPageResponse;
        if (ObjectUtils.isEmpty(criteria.getTag())) {
            itemPageResponse = new ItemPageResponse();
        } else {
            itemPageResponse = displayService.getMdItems(salesonContextHolder.getSalesonContext(request), criteria);
        }

        model.addAttribute("mdItems", itemPageResponse.getContent());

        return "main/include/md-item-list-container";
    }

    @GetMapping("/main/review-list")
    public String reviewList(Model model, HttpServletRequest request) {

        DisplayReviewListResponse reviewList
                = salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/display/main-reviews", DisplayReviewListResponse.class);

        if (!ObjectUtils.isEmpty(reviewList) && !ObjectUtils.isEmpty(reviewList.getList())) {
            reviewList.getList().forEach(r -> {
                r.setContent(FrontUtils.nl2br(r.getContent()));
            });
        }

        model.addAttribute("reviewList", reviewList);
        return "main/include/review-list";
    }

    @GetMapping("/main/new-item-list")
    public String newItemList(Model model, HttpServletRequest request) {

        Criteria criteria = new Criteria();
        criteria.setPage(1);
        criteria.setSize(6);

        model.addAttribute("newItems",
                salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/display/new", salesonApi.convert(criteria), ItemPageResponse.class)
        );

        return "main/include/new-item-list";
    }

    @GetMapping("/main/timedeal-item-list")
    public String timedealItemList(Model model, HttpServletRequest request) {

        Criteria criteria = new Criteria();
        criteria.setPage(1);
        criteria.setSize(6);

        model.addAttribute("timedealItems",
                salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/event/spot", salesonApi.convert(criteria), ItemPageResponse.class)
        );

        return "main/include/timedeal-item-list";
    }

    @GetMapping("/main/featured-list")
    public String featuredList(Model model, HttpServletRequest request) {

        int limit = 4;

        FeaturedPageResponse pageContent = salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/event?limit=" + limit, FeaturedPageResponse.class);
        model.addAttribute("featuredList", pageContent.getContent());

        return "main/include/featured-list";
    }

    @GetMapping("/main/popup")
    @ResponseBody
    public JsonView popup(HttpServletRequest request) {

        DisplayPopupResponse displayPopupResponse = new DisplayPopupResponse();

        try {
            PopupListResponse listResponse
                    = salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/popup/list", PopupListResponse.class);

            if (!ObjectUtils.isEmpty(listResponse)) {
                displayPopupResponse.set(request, listResponse.getList());
            }

        } catch (Exception e) {
            log.error("main popup list error {}", e.getMessage(), e);
        }

        return JsonView.builder()
                .successFlag(true)
                .data(displayPopupResponse)
                .build();
    }

    @ResponseBody
    @GetMapping("/healthcheck")
    public String healthcheck() {
        return "Server is alive.";
    }

    @GetMapping("/maintenance")
    public String maintenance() {
        return "maintenance/index";
    }


}
