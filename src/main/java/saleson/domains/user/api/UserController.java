package saleson.domains.user.api;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.RequestContext;
import saleson.common.configuration.saleson.SalesonSocialConfig;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.view.JsonView;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/user")
public class UserController {

    private final SalesonContextHolder salesonContextHolder;
    private final FrontEventHandler frontEventHandler;

    @GetMapping("/login")
    public String login(Model model, HttpServletRequest request,
                        @RequestParam(name = "target", defaultValue = "") String target) {

        salesonContextHolder.removeSalesonContext(request);
        frontEventHandler.setHeaderDetail(model,"로그인");
        frontEventHandler.setSocialConfig(model);
        model.addAttribute("target", target);

        return "user/login";
    }


    @GetMapping("/find-id")
    public String findId(HttpServletRequest request, Model model) {
        frontEventHandler.setHeaderDetail(model, "아이디 찾기");
        return "user/find-id";
    }

    @GetMapping("/sms-certify")
    public String smsCertify(HttpServletRequest request, Model model) {
        frontEventHandler.setHeaderDetail(model, "SNS 인증");
        return "user/sms-certify";
    }

    @GetMapping("/find-id-complete")
    public String findIdComplete(HttpServletRequest request, Model model) {
        frontEventHandler.setHeaderDetail(model, "아이디 찾기");
        return "user/find-id-complete";
    }


    @GetMapping("/find-pw")
    public String findPw(HttpServletRequest request, Model model) {
        frontEventHandler.setHeaderDetail(model, "비밀번호 찾기");
        return "user/find-pw";
    }

    @GetMapping("/find-pw-complete")
    public String findPwComplete(HttpServletRequest request, Model model) {
        frontEventHandler.setHeaderDetail(model, "비밀번호 찾기");
        return "user/find-pw-complete";
    }

    @GetMapping("/join")
    public String join(HttpServletRequest request, Model model) {
        int currentYear = LocalDate.now().getYear();
        model.addAttribute("years", currentYear);

        frontEventHandler.setHeaderDetail(model, "회원가입");
        return "user/join";
    }

    @GetMapping("/certify-join")
    public String certifyJoin(HttpServletRequest request, Model model) {

        frontEventHandler.setHeaderDetail(model, "회원가입");

        return "user/certify-join";
    }


    @GetMapping("/join-complete")
    public String joinComplete(HttpServletRequest request, Model model) {


        frontEventHandler.setHeaderDetail(model, "회원가입");

        return "user/join-complete";
    }

    @GetMapping("/change-password")
    public String changePassword(HttpServletRequest request, Model model) {
        frontEventHandler.setHeaderDetail(model, "비밀번호 변경");
        return "user/change-pw";
    }

    @GetMapping("/expired-password")
    public String expiredPassword(HttpServletRequest request, Model model) {
        frontEventHandler.setHeaderDetail(model, "비밀번호 만료");
        return "user/expired-pw";
    }

}
