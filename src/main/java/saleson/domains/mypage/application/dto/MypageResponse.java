package saleson.domains.mypage.application.dto;

import java.util.List;

import lombok.*;
import saleson.domains.mypage.application.dto.info.OrderResponse;
import saleson.domains.mypage.application.dto.info.WishListResponse;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MypageResponse {

    private List<WishListResponse> wishlists;

    private List<OrderResponse> orderList;

}
