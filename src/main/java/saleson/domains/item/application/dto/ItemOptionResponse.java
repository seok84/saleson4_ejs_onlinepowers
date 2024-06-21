package saleson.domains.item.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ItemOptionResponse {

    private int itemOptionId;
    private int itemId;
    private String optionType = "";
    private String optionDisplayType = "";
    private String optionHideFlag = "";
    private String optionName1 = "";
    private String optionName2 = "";
    private String optionName3 = "";
    private String optionStockCode = "";
    private int optionPrice;
    private int optionPriceNonmember;
    private String optionStockFlag;
    private String optionSoldOutFlag;
    private int optionStockQuantity = -1;
    private String optionStockScheduleText = "";
    private String optionStockScheduleDate = "";
    private String optionDisplayFlag = "Y";
    private long createdUserId;
    private String createdDate;
    private int optionCostPrice;
    private int price;

    private boolean isSoldOut;
}
