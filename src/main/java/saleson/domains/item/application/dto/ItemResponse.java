package saleson.domains.item.application.dto;

import java.util.ArrayList;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.*;
import org.springframework.util.ObjectUtils;
import saleson.common.utils.FrontUtils;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ItemResponse {
    private int itemId;
    private String itemName;
    private String itemSummary;
    private String itemImage;
    private String itemBigImage;
    private String itemSmallImage;
    private String itemUserCode;
    private String itemType;
    private int discountRate;
    private int presentPrice;
    private int salePrice;
    private String itemOptionFlag;
    private String itemSoldOutFlag;
    private String stockFlag;

    private String itemPrice;
    private String itemLabel;
    private String itemNewFlag;
    private boolean wishlistFlag;
    private String spotDateType;
    private boolean spotFlag;
    private String spotStartTime;
    private String spotEndTime;
    private String spotCountdownDate;
    private List<String> spotWeekDayList;
    private int spotEndDDay;
    private String brand;
    private int brandId;
    private String deliveryCompanyName;
    private String deliveryType;

    private String rank;

    private List<FrontItemLabelResponse> labels;

    private String nonmemberOrderType;

    private List<ItemOptionResponse> itemOptions = new ArrayList<>();

    private int spotDiscountAmount;
    private String sellerDiscountFlag = "N";
    private int sellerDiscountPrice;
    private int userLevelDiscountAmount;

    private int orderMinQuantity;
    private int orderMaxQuantity;

    private int totalDiscountAmount;

    private String eventViewUrl;

    public String getWeekDays() {

        if (!ObjectUtils.isEmpty(getSpotWeekDayList())) {
            return String.join(" · ",getSpotWeekDayList());
        }

        return "";
    }

    public String getDisplaySpotStartTime() {
        return getFormatTime(getSpotStartTime());
    }

    public String getDisplaySpotEndTime() {
        return getFormatTime(getSpotEndTime());
    }

    public String getDisplayItemName() {
        String itemName = getItemName();
        String brand = getBrand();

        if (!ObjectUtils.isEmpty(brand)) {
            return  "["+brand+"] " + itemName;
        }

        return itemName;
    }

    public boolean isActiveCartFlag() {
        return !"Y".equals(getItemSoldOutFlag())
                && !"Y".equals(getItemOptionFlag())
                && ("1".equals(getItemType()));
    }


    private String getFormatTime(String value) {
        try {
            if (!ObjectUtils.isEmpty(value) && value.length() >= 6) {
                return value.substring(0,2)+":"+value.substring(2,4);
            }
        } catch (Exception e) {}

        return value;
    }
}

