package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ClaimApplyResponse {

	private String claimRefundType;
	private String refundCode;
	private String orderCode;
	private int orderSequence;
	private int itemSequence;
	private String claimType; // 1:취소, 2:환불, 3:교환
	private String claimStatus;
	private String claimReason;
	private String claimReasonDetail;

	private String returnBankName;
	private String returnBankInName;
	private String returnVirtualNo;
	private String claimReasonText;

	private List<OrderItemResponse> orderItems;
	private String[] id;
}
