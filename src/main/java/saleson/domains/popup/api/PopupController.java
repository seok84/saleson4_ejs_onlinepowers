package saleson.domains.popup.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContextHolder;
import saleson.domains.popup.application.dto.PopupResponse;

@Controller
@RequestMapping("/popup")
@RequiredArgsConstructor
@Slf4j
public class PopupController {

    private final SalesonApi salesonApi;
    private final SalesonContextHolder salesonContextHolder;

    @GetMapping("{popupId}")
    public String popupDetail(Model model, HttpServletRequest request,
                              @PathVariable("popupId") int popupId) {

        model.addAttribute("popup",
                salesonApi.get(salesonContextHolder.getSalesonContext(request), "/api/popup/"+popupId, PopupResponse.class));

        return "popup/view";
    }
}
