package saleson.domains.mypage.application.dto.info;

import java.util.ArrayList;
import java.util.List;

import lombok.*;
import org.springframework.util.ObjectUtils;
import saleson.common.utils.FrontUtils;
import saleson.domains.item.application.dto.FrontItemLabelResponse;
import saleson.domains.item.application.dto.ItemOptionResponse;
import saleson.domains.item.application.dto.ItemResponse;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WishListResponse {

    private int wishlistId;

    private int wishlistGroupId;

    private int itemId;

    private String itemOption;

    private String itemOptionGroupName;

    private String itemOptionName;

    private String createdDate;

    private ItemResponse item;
}
