package saleson.domains.mypage.api;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.CodeListResponse;
import saleson.common.async.application.AsyncDataService;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.context.SalesonContextHolder;
import saleson.common.handler.FrontEventHandler;
import saleson.common.pagination.PaginationHandler;
import saleson.domains.mypage.application.MypageUserService;
import saleson.domains.review.application.dto.ReviewCriteria;
import saleson.domains.review.application.dto.ReviewListResponse;
import saleson.domains.qna.application.QnaEventHandler;
import saleson.domains.qna.application.dto.ItemQnaPageResponse;
import saleson.domains.qna.application.dto.QnaCriteria;

import java.time.LocalDate;

@Controller
@RequestMapping("/mypage/user")
@RequiredArgsConstructor
@Slf4j
public class MypageUserController {

    private final SalesonContextHolder salesonContextHolder;
    private final MypageUserService mypageUserService;
    private final PaginationHandler paginationHandler;
    private final FrontEventHandler frontEventHandler;
    private final SalesonApi salesonApi;
    private final AsyncDataService asyncDataService;
    private final QnaEventHandler qnaEventHandler;

    /**
     * 내 정보 관리
     *
     * @param model
     * @return
     */
    @GetMapping("/modify")
    public String modify(HttpServletRequest request, Model model) {


        int currentYear = LocalDate.now().getYear();
        model.addAttribute("userInfo",
            mypageUserService.getMe(salesonContextHolder.getSalesonContext(request)));
        model.addAttribute("years", currentYear);
        model.addAttribute("isSnsJoined", isSnsJoinedUser(
            salesonContextHolder.getSalesonContext(request).getUser().getLoginId()));
        frontEventHandler.setHeaderDetail(model, "내정보 관리");
        return "mypage/user/modify";
    }

    /**
     * 내 정보 관리
     *
     * @param model
     * @return
     */
    @GetMapping("/check-password")
    public String checkPassword(HttpServletRequest request, Model model) {
        model.addAttribute("isSnsJoined", isSnsJoinedUser(
            salesonContextHolder.getSalesonContext(request).getUser().getLoginId()));
        frontEventHandler.setHeaderDetail(model, "내정보 관리");
        return "mypage/user/check-password";
    }

    @GetMapping("/secede")
    public String secede(HttpServletRequest request, Model model) {
        model.addAttribute("secedeInfo",
            mypageUserService.getSecedeInfo(salesonContextHolder.getSalesonContext(request)));
        model.addAttribute("isSnsJoined", isSnsJoinedUser(
            salesonContextHolder.getSalesonContext(request).getUser().getLoginId()));
        frontEventHandler.setHeaderDetail(model, "탈퇴");
        return "mypage/user/secede";
    }


    /**
     * 비밀번호 변경
     *
     * @param model
     * @return
     */
    @GetMapping("/change-password")
    public String changePassword(Model model) {
        frontEventHandler.setHeaderDetail(model, "비밀번호 변경");
        return "mypage/user/change-password";
    }

    /**
     * SNS 연동관리
     *
     * @param model
     * @return
     */
    @GetMapping("/connect-sns")
    public String connectSns(HttpServletRequest request, Model model) {
        model.addAttribute("snsInfo",
        mypageUserService.getSnsInfo(salesonContextHolder.getSalesonContext(request)));
        frontEventHandler.setSocialConfig(model);
        frontEventHandler.setHeaderDetail(model, "SNS 연동관리");
        return "mypage/user/connect-sns";
    }

    /**
     * 상품문의
     *
     * @param model
     * @return
     */
    @GetMapping("/inquiry-item")
    public String inquiryItem(Model model, HttpServletRequest request, QnaCriteria criteria) {

        asyncDataService.setModelBy(request, model,
            new AsyncDataRequest<>("pageContent", "/api/qna/item-inquiry", HttpMethod.GET,
                ItemQnaPageResponse.class, salesonApi.convert(criteria)),
            new AsyncDataRequest<>("qnaGroups", "/api/qna/qna-groups", HttpMethod.GET,
                CodeListResponse.class)
        );

        ItemQnaPageResponse pageContent = (ItemQnaPageResponse) model.getAttribute("pageContent");

        qnaEventHandler.setConvertHtml(pageContent);

        model.addAttribute("pageContent", pageContent);
        model.addAttribute("criteria", criteria);

        paginationHandler.setModelForPaginationUrl(model, request);
        frontEventHandler.setHeaderDetail(model, "상품문의");

        return "mypage/user/inquiry-item";
    }

    /**
     * 이용후기
     *
     * @param model
     * @return
     */
    @GetMapping("/review")
    public String review(HttpServletRequest request, Model model, ReviewCriteria reviewCriteria) {
        ReviewListResponse reviewListResponse = mypageUserService.getReviewList(salesonContextHolder.getSalesonContext(request), reviewCriteria);

        model.addAttribute("criteria", reviewCriteria);
        model.addAttribute("reviewList", reviewListResponse);
        model.addAttribute("pagination", reviewListResponse.getReviewPageResponse().getPagination());
        paginationHandler.setModelForPaginationUrl(model, request);
        frontEventHandler.setHeaderDetail(model, "이용후기");
        return "mypage/user/review";
    }

    // 이용후기 팝업
//    @GetMapping("/popup/review")
//    public String getReviewPopup(
//        HttpServletRequest request, Model model, OrderRequest orderRequest) throws Exception{
//
//        frontEventHandler.setHeaderDetail(model,"이용후기 팝업");
//        model.addAttribute("content", mypageUserService.getReviewPopup(salesonContextHolder.getSalesonContext(request), itemUserCode));
//
//        return "mypage/user/popup/review";
//    }


    public boolean isSnsJoinedUser(String loginId) {
        return loginId.contains("n@") || loginId.contains("kakao-") || loginId.contains("a@") || loginId.contains("naver-");

    }
}

