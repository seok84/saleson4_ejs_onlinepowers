package saleson.domains.mypage.application.dto.info;

import java.util.List;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@Builder
public class ReturnApplyResponse {

    private String claimCode;
    private String returnShippingAskType = "1";
    private int shipmentReturnId;

    private OrderItemResponse orderItem;

    private int applyQuantity;
    private String orderCode;
    private int orderSequence;
    private int itemSequence;

    private String returnReserveName;
    private String returnReservePhone;
    private String returnReservePhone1;
    private String returnReservePhone2;
    private String returnReservePhone3;

    private String returnReserveMobile;
    private String returnReserveMobile1;
    private String returnReserveMobile2;
    private String returnReserveMobile3;

    private String returnReserveZipcode;
    private String returnReserveSido;
    private String returnReserveSigungu;
    private String returnReserveEupmyeondong;
    private String returnReserveAddress;
    private String returnReserveAddress2;

    private String returnShippingCompanyName;

    private String returnShippingNumber;

    private String claimReason;
    private String claimReasonText;
    private String claimReasonDetail;

    //환불정보
    private String returnBankName;
    private String returnBankInName;
    private String returnVirtualNo;

    private String setItemFlag;
    private String[] id;

    private List<OrderClaimImageResponse> orderClaimImages;

    // 클레임 이미지
    private MultipartFile orderClaimImageFile;
    private List<MultipartFile> orderClaimImageFiles;

    private String uploadPath;

}
