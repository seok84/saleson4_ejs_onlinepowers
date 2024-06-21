package saleson.domains.policy.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.handler.FrontEventHandler;
import saleson.common.utils.FrontUtils;
import saleson.domains.policy.api.dto.PolicyListResponse;
import saleson.domains.policy.api.dto.PolicyResponse;

@Controller
@RequestMapping("/policy")
@RequiredArgsConstructor
@Slf4j
public class PolicyController {

    private final AsyncDataService asyncDataService;
    private final FrontEventHandler frontEventHandler;

    @GetMapping("/agreement")
    public String agreement(HttpServletRequest request, Model model) {

        setModel(request, model, "POLICY_TYPE_AGREEMENT", "agreement", "이용약관");
        frontEventHandler.setHeaderDetail(model, "이용약관");
        return "policy/view";
    }

    @GetMapping("/protect")
    public String protect(HttpServletRequest request, Model model) {

        setModel(request, model, "POLICY_TYPE_PROTECT_POLICY","protect", "개인정보 처리방침");
        frontEventHandler.setHeaderDetail(model, "개인정보 처리방침");
        return "policy/view";
    }

    @GetMapping("/marketing")
    public String marketing(HttpServletRequest request, Model model) {

        setModel(request, model, "POLICY_TYPE_MARKETING_AGREEMENT", "marketing", "마케팅 수신동의");
        frontEventHandler.setHeaderDetail(model, "마케팅 수신동의");
        return "policy/view";
    }

    private void setModel(HttpServletRequest request, Model model, String type, String activeType, String title) {

        asyncDataService.setModelBy(request, model,
                new AsyncDataRequest<>("policy", "/api/policy/"+type, HttpMethod.GET, PolicyResponse.class),
                new AsyncDataRequest<>("policies", "/api/policy/"+type+"/list", HttpMethod.GET, PolicyListResponse.class)

                );
        model.addAttribute("policyType", type);
        model.addAttribute("activeType", activeType);
        model.addAttribute("title", title);
    }

    @GetMapping("/refuse-email")
    public String refuseEmail(Model model) {

        frontEventHandler.setHeaderDetail(model, "이메일 수신거부");
        return "policy/refuse-email";
    }

}
