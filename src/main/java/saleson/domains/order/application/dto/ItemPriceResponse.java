package saleson.domains.order.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.math.MathContext;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ItemPriceResponse {


    private int purchasePrice;		// 매입가격
    private int costPrice;			// 원가
    private int supplyPrice;		// 공급
    private int price;				// 단가 (개당 가격)
    private int optionPrice;		// 옵션가 (개당 가격)
    private int quantity;

    private String taxType;

    private String spotSaleFlag;

    // 상품 쿠폰 적용 방식 (1 : 상품 구매 수량만큼 중복 적용)
    private String couponConcurrently = "";

    private int couponDiscountPrice;
    private int couponDiscountAmount;
    private String commissionType;

    private int sumPrice; 	// 옵션가 + 단가

    // 적립 포인트
    private double earnPoint;
    private String earnPointFlag = "N";

    private int commissionBasePrice;
    private int commissionPrice;
    private int sellerDiscountPrice;			// 즉시할인
    private int sellerDiscountAmount;			// 즉시할인 + 판매자 SPOT
    private String sellerDiscountDetail;

    private int adminDiscountPrice;				// 운영사 SPOT
    private int adminDiscountAmount;
    private String adminDiscountDetail;

    private int discountAmount; 			// 할인 총액 (운영자할인 + 판매자할인 + 쿠폰할인 + 등급할인 + 세트할인)

    private int sellerPoint;

    private int spotDiscountAmount;
    private int itemSalePrice;

    // 회원 등급 할인 금액
    private int userLevelDiscountAmount;

    // 상품 할인 - (즉시할인 + 스팟할인)
    private int itemDiscountAmount;

    // 세트 할인
    private int setDiscountPrice;
    private int setDiscountAmount;
    private String setDiscountType;			// 세트상품 할인구분 (1:금액, 2:비율)

    private int saleAmount;

    public BigDecimal getDiscountPrice() {
        try {

            BigDecimal discountAmount = new BigDecimal(getDiscountAmount());

            if (discountAmount.compareTo(BigDecimal.ZERO) != 0) {
                return discountAmount.divide(new BigDecimal(getQuantity()), MathContext.DECIMAL32);
            } else {
                return BigDecimal.ZERO;
            }
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    private int baseAmountForShipping;


}
