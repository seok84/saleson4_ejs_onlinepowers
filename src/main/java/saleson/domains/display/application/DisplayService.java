package saleson.domains.display.application;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.Criteria;
import saleson.common.context.SalesonContext;
import saleson.domains.display.application.dto.DisplayTagCriteria;
import saleson.domains.display.application.dto.DisplayTagListResponse;
import saleson.domains.item.application.dto.ItemListResponse;
import saleson.domains.item.application.dto.ItemPageResponse;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class DisplayService {

    private final SalesonApi salesonApi;

    public ItemPageResponse getNewItems(SalesonContext salesonContext, Criteria criteria) {
        return salesonApi.get(salesonContext, "/api/display/new",salesonApi.convert(criteria), ItemPageResponse.class);
    }

    public ItemListResponse getBestTop100Items(SalesonContext salesonContext) {
        return salesonApi.get(salesonContext, "/api/display/best", ItemListResponse.class);
    }

    public ItemPageResponse getGroupBestItems(SalesonContext salesonContext, DisplayTagCriteria criteria) {
        return salesonApi.get(salesonContext, "/api/display/group-best/item-list", salesonApi.convert(criteria), ItemPageResponse.class);
    }


    public ItemPageResponse getTimeDealItems(SalesonContext salesonContext, Criteria criteria) {
        return salesonApi.get(salesonContext, "/api/event/spot",salesonApi.convert(criteria), ItemPageResponse.class);
    }

    public ItemPageResponse getMdItems(SalesonContext salesonContext, DisplayTagCriteria criteria) {
        return salesonApi.get(salesonContext, "/api/display/md", salesonApi.convert(criteria), ItemPageResponse.class);
    }

    public DisplayTagListResponse getMdTags(SalesonContext salesonContext) {
        return salesonApi.get(salesonContext, "/api/display/md-tags", DisplayTagListResponse.class);
    }
}
