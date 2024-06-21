package saleson.domains.cart.application;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContext;
import saleson.domains.cart.application.dto.CartListResponse;
import saleson.domains.cart.application.dto.CartRequest;
import saleson.domains.common.api.dto.StatusResponse;
import saleson.domains.order.application.dto.BuySetItemListResponse;

@Service
@RequiredArgsConstructor
public class CartService {

    private final SalesonApi salesonApi;

    public CartListResponse getCartItems(SalesonContext salesonContext) throws Exception {
        return salesonApi.get(salesonContext, "/api/cart",CartListResponse.class);
    }


    public StatusResponse deleteCartById(SalesonContext salesonContext, CartRequest cartRequest) throws Exception {
        return salesonApi.post(salesonContext, "/api/cart/delete", StatusResponse.class);
    }

    public BuySetItemListResponse getCartItemById(SalesonContext salesonContext, int cartId) {
        return salesonApi.get(salesonContext, "/api/cart/set-item-info/" + cartId, BuySetItemListResponse.class);
    }
}
