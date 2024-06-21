package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.CodeResponse;

@Getter
@Setter
@Builder
public class CancelApplyResponse {

    private String userClickItemStatus;
    private List<CodeResponse> claimReasons;
//    private ClaimApply claimApply; - response 생성필요

}
