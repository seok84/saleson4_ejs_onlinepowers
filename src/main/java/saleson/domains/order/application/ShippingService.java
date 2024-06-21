package saleson.domains.order.application;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.context.SalesonContext;
import saleson.domains.mypage.application.dto.info.ShippingItemPageResponse;
import saleson.domains.order.application.dto.PaymentResponse;
import saleson.domains.order.application.dto.ShippingCriteria;

@Service
@RequiredArgsConstructor
public class ShippingService {

    private final SalesonApi salesonApi;

    public ShippingItemPageResponse getShippingItemPageResponse (SalesonContext salesonContext, ShippingCriteria criteria) {
        return salesonApi.get(salesonContext, "/api/shipping", salesonApi.convert(criteria), ShippingItemPageResponse.class);
    }

}
