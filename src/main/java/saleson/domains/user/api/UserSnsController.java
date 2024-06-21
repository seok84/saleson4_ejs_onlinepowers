package saleson.domains.user.api;

import jakarta.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/user/sns")
public class UserSnsController {

    private final FrontEventHandler frontEventHandler;

    @GetMapping("/naver-callback")
    public String naverCallBack(HttpServletRequest request, Model model) {
        frontEventHandler.setSocialConfig(model);
        return "user/sns/naver-callback";
    }

    @GetMapping("/kakao-callback")
    public String kakaoCallBack(HttpServletRequest request, Model model) {
        frontEventHandler.setSocialConfig(model);
        return "user/sns/kakao-callback";
    }

    @GetMapping("/sns-auth-step1")
    public String snsJoinStep1(HttpServletRequest request, Model model) {
        frontEventHandler.setSocialConfig(model);
        return "user/sns/sns-auth-step1";
    }

    @GetMapping("/sns-auth-step2")
    public String snsJoinStep2(HttpServletRequest request, Model model) {
        return "user/sns/sns-auth-step2";
    }
    @GetMapping("/sns-join")
    public String snsJoin(HttpServletRequest request, Model model) {
        int currentYear = LocalDate.now().getYear();
        model.addAttribute("years", currentYear);

        frontEventHandler.setHeaderDetail(model, "회원가입");
        return "user/sns/sns-join";
    }

}
