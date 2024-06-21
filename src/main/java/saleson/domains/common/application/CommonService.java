package saleson.domains.common.application;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.context.SalesonContext;
import saleson.domains.common.api.dto.StatusResponse;
import saleson.domains.common.application.dto.IslandPageResponse;

@Service
@RequiredArgsConstructor
@Slf4j
public class CommonService {
    private final SalesonApi salesonApi;

    public IslandPageResponse getIslandInfo(SalesonContext salesonContext, Criteria criteria) {
        return salesonApi.get(salesonContext, "/api/common/island-info",salesonApi.convert(criteria), IslandPageResponse.class);
    }
}
