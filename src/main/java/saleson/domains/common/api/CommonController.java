package saleson.domains.common.api;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.context.SalesonContextHolder;
import saleson.common.pagination.PaginationHandler;
import saleson.common.view.JsonView;
import saleson.domains.common.api.dto.StatusResponse;
import saleson.domains.common.application.CommonService;

@Controller
@Slf4j
@RequestMapping("/common")
@RequiredArgsConstructor
public class CommonController {
    private final CommonService commonService;
    private final SalesonContextHolder salesonContextHolder;
    private final PaginationHandler paginationHandler;

    @GetMapping("/island-info")
    public String deliveryInfo(Model model, HttpServletRequest request, Criteria criteria) {
        try {
            model.addAttribute("pageContent", commonService.getIslandInfo(salesonContextHolder.getSalesonContext(request), criteria));
            model.addAttribute("criteria", criteria);
            paginationHandler.setModelForUrl(model, "javascript:islandInfoModal([page])");
        } catch (Exception e) {
            log.error("error : {}", e);
        }
        return "common/island-info";
    }

}
