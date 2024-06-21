package saleson.domains.item.application.dto;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.ObjectUtils;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ItemDetailResponse extends ItemResponse {

    private String deliveryInfo;
    private List<ItemSetResponse> itemSets = new ArrayList<>();
    private List<String> images;

    private String shippingType;
    private int shipping;
    private int shippingFreeAmount;
    private int shippingItemCount;
    private int shippingExtraCharge1;
    private int shippingExtraCharge2;
    private String deliveryCompanyName;
    private String deliveryType;
    private String originCountry;
    private String detailContent;
    private String couponUseFlag;

    private int stockQuantity;

    private String itemOptionType;
    private String itemOptionTitle1;
    private String itemOptionTitle2;
    private String itemOptionTitle3;
    private String stockScheduleType;
    private String stockScheduleDate;
    private String stockScheduleText;

    //seller
    private String representativeName;
    private String businessNumber;
    private String businessLocation;

    private String reviewCount;
    private String reviewScore;

    // 세트
    private int exceptUserDiscountPresentPrice;

    //고시정보 목록
    private List<ItemInfoResponse> infos;

    public int getDisplayReviewScore() {
        try {
            BigDecimal decimal = new BigDecimal(getReviewScore());
            return decimal.intValue();
        } catch (Exception e) {
        }
        return 0;
    }

    /**
     * 조합형 옵션
     * @return
     */
    public List<CombineOption> getCombineOptions() {

        if (!"Y".equals(getItemOptionFlag())) {
            return new ArrayList<>();
        }

        List<ItemOptionResponse> options = getItemOptions();

        if (ObjectUtils.isEmpty(options)) {
            return new ArrayList<>();
        }

        CombineOption step1 = new CombineOption(1);
        CombineOption step2 = new CombineOption(2);
        CombineOption step3 = new CombineOption(3);

        options.forEach(i->{
            step1.addName(i.getOptionName1());
            step2.addName(i.getOptionName2());
            step3.addName(i.getOptionName3());
        });

        return List.of(step1,step2, step3);
    }

    /**
     * 선택형 옵션
     */
    public List<SelectedOption> getSelectedOption() {
        Set<String> optionNames = this.getItemOptions().stream().map(i-> i.getOptionName1()).collect(
            Collectors.toSet());
        List<SelectedOption> list= new ArrayList<>();
        if (!ObjectUtils.isEmpty(this.getItemOptions()) && !ObjectUtils.isEmpty(optionNames)) {
            for (String optionName : optionNames) {
                SelectedOption option1 = new SelectedOption();
                option1.setOptionName(optionName);
                List<ItemOptionResponse> optionList = new ArrayList<>();
                for (ItemOptionResponse option : this.getItemOptions()) {
                    if (optionName.equals(option.getOptionName1())) {
                        optionList.add(option);
                    }
                }
                option1.setOptions(optionList);
                list.add(option1);
            }
        }
        return list;
    }
}


