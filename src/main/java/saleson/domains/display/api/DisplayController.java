package saleson.domains.display.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.context.SalesonContext;
import saleson.common.context.SalesonContextHolder;
import saleson.common.pagination.PaginationHandler;
import saleson.common.utils.FrontUtils;
import saleson.domains.category.application.CategoryService;
import saleson.domains.category.application.dto.CategoryResponse;
import saleson.domains.display.application.DisplayService;
import saleson.domains.display.application.dto.DisplayReviewPageResponse;
import saleson.domains.display.application.dto.DisplayTagCriteria;
import saleson.domains.display.application.dto.DisplayTagListResponse;
import saleson.domains.item.application.dto.ItemListResponse;
import saleson.domains.item.application.dto.ItemPageResponse;
import saleson.domains.item.application.dto.ItemResponse;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/display")
@RequiredArgsConstructor
@Slf4j
public class DisplayController {
    private final SalesonContextHolder salesonContextHolder;
    private final SalesonApi salesonApi;

    private final PaginationHandler paginationHandler;
    private final DisplayService displayService;
    private final CategoryService categoryService;

    @GetMapping("/new")
    public String newView(Model model, HttpServletRequest request, Criteria criteria){
        criteria.setSize(24);
        model.addAttribute("pageContent", displayService.getNewItems(salesonContextHolder.getSalesonContext(request), criteria));
        model.addAttribute("criteria", criteria);
        paginationHandler.setModelForPaginationUrl(model, request);


        return "/display/new";
    }

    @GetMapping("/best")
    public String best(Model model, HttpServletRequest request, DisplayTagCriteria criteria){

        criteria.setSize(100);
        criteria.setPage(1);

        List<CategoryResponse> categories  = categoryService.getShopCategories(request);

        if (ObjectUtils.isEmpty(categories)) {
            categories = new ArrayList<>();
        } else {
            if (ObjectUtils.isEmpty(criteria.getTag())) {
                criteria.setTag(categories.get(0).getUrl());
            }
        }

        ItemPageResponse pageContent;
        if (ObjectUtils.isEmpty(criteria.getTag())) {
            pageContent = new ItemPageResponse();
        } else {
            pageContent = displayService.getGroupBestItems(salesonContextHolder.getSalesonContext(request), criteria);
        }

        if (!ObjectUtils.isEmpty(pageContent.getContent())) {
            final int[] rank = {1};
            pageContent.getContent().forEach(itemResponse -> {
                itemResponse.setRank(FrontUtils.padZero(rank[0]));
                rank[0]++;
            });
        }

        model.addAttribute("criteria", criteria);
        model.addAttribute("categories", categories);
        model.addAttribute("pageContent", pageContent);

        return "/display/best";
    }

    @GetMapping("/best/top-100")
    public String bestTop100(Model model, HttpServletRequest request){

        ItemListResponse itemListResponse = displayService.getBestTop100Items(salesonContextHolder.getSalesonContext(request));

        List<ItemResponse> list = itemListResponse.getList();

        if (!ObjectUtils.isEmpty(list)) {
            final int[] rank = {1};
            list.forEach(itemResponse -> {
                itemResponse.setRank(FrontUtils.padZero(rank[0]));
                rank[0]++;
            });
        }

        model.addAttribute("itemList", list);
        return "/display/best-top-100";
    }


    @GetMapping("/md")
    public String md(Model model, HttpServletRequest request, DisplayTagCriteria criteria) {

        SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);

        DisplayTagListResponse tagListResponse = displayService.getMdTags(salesonContext);

        List<String> tags = new ArrayList<>();
        String firstTag = "";

        if (!ObjectUtils.isEmpty(tagListResponse) && !ObjectUtils.isEmpty(tagListResponse.getTags())) {
            tags.addAll(tagListResponse.getTags());

            firstTag = tagListResponse.getTags().getFirst();
        }

        if (ObjectUtils.isEmpty(criteria.getTag())) {
            criteria.setTag(firstTag);
        }

        criteria.setSize(24);

        model.addAttribute("pageContent", displayService.getMdItems(salesonContextHolder.getSalesonContext(request), criteria));
        model.addAttribute("tags", tags);
        model.addAttribute("criteria", criteria);
        paginationHandler.setModelForPaginationUrl(model, request);

        return "/display/md";
    }


    @GetMapping("/timedeal")
    public String timedeal(Model model, HttpServletRequest request, Criteria criteria){

        criteria.setSize(24);
        model.addAttribute("pageContent", displayService.getTimeDealItems(salesonContextHolder.getSalesonContext(request), criteria));
        model.addAttribute("criteria", criteria);
        paginationHandler.setModelForPaginationUrl(model, request);

        return "/display/timedeal";
    }

    @GetMapping("/review")
    public String review(Model model, HttpServletRequest request, DisplayTagCriteria criteria){

        criteria.setSize(24);
        criteria.setDataStatusCode("0");

        List<CategoryResponse> categories  = categoryService.getShopCategories(request);

        DisplayReviewPageResponse pageContent
                = salesonApi.get(salesonContextHolder.getSalesonContext(request),"/api/display/reviews", salesonApi.convert(criteria), DisplayReviewPageResponse.class);

        if (!ObjectUtils.isEmpty(pageContent) && !ObjectUtils.isEmpty(pageContent.getContent())) {
            pageContent.getContent().forEach(r -> {
                r.setContent(FrontUtils.nl2br(r.getContent()));
            });
        }

        model.addAttribute("pageContent", pageContent);
        model.addAttribute("criteria", criteria);
        model.addAttribute("categories", categories);
        
        paginationHandler.setModelForPaginationUrl(model, request);

        return "/display/review";
    }
}
