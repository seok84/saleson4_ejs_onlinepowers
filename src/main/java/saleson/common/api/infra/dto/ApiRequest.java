package saleson.common.api.infra.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpMethod;
import saleson.common.context.SalesonContext;

import java.util.Map;

@Getter
@Setter
public class ApiRequest {
    private SalesonContext context;
    private String url;
    private HttpMethod method;
    private Map<String, ?> params;

    @Builder
    public ApiRequest(SalesonContext context, String url, HttpMethod method, Map<String, ?> params) {
        this.context = context;
        this.url = url;
        this.method = method;
        this.params = params;
    }
}
