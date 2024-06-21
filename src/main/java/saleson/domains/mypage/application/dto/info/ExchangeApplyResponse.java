package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@Builder
public class ExchangeApplyResponse {

    private String claimCode;

    private String orderCode;

    private int orderSequence;

    private int itemSequence;

    private String exchangeReceiveName;
    private String exchangeReceivePhone;
    private String exchangeReceivePhone1;
    private String exchangeReceivePhone2;
    private String exchangeReceivePhone3;

    private String exchangeReceiveMobile;
    private String exchangeReceiveMobile1;
    private String exchangeReceiveMobile2;
    private String exchangeReceiveMobile3;

    private String exchangeReceiveZipcode;

    private String exchangeReceiveSido;

    private String exchangeReceiveSigungu;

    private String exchangeReceiveEupmyeondong;

    private String exchangeReceiveAddress;

    private String exchangeReceiveAddress2;

    private OrderItemResponse orderItem;

    private int shipmentReturnId;

    private String claimReason;
    private String claimReasonText;

    private String claimReasonDetail;

    private String exchangeShippingCompanyName;

    private String exchangeShippingNumber;
    private String exchangeShippingAskType = "1";

    private int applyQuantity;

    private String setItemFlag;
    private String[] id;

    private List<OrderClaimImageResponse> orderClaimImages;

    // 클레임 이미지
    private MultipartFile orderClaimImageFile;
    private List<MultipartFile> orderClaimImageFiles;

    private String uploadPath;

}
