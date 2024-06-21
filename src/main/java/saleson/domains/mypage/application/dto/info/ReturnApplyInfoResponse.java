package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import saleson.common.api.infra.dto.CodeResponse;
import saleson.domains.common.api.dto.BankInfoListResponse;

@Getter
@Setter
@Builder
public class ReturnApplyInfoResponse {

    List<DeliveryCompany> deliveryCompanyList;
    List<CodeResponse> claimReasons;
    ReturnApplyResponse returnApply;
    boolean paymentType;
    BankInfoListResponse banks;

}
