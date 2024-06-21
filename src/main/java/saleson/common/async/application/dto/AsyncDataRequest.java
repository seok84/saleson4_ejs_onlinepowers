package saleson.common.async.application.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpMethod;

import java.util.LinkedHashMap;
import java.util.Map;

@Getter
@Setter
public class AsyncDataRequest<T> {

    private String key;
    private String url;
    private HttpMethod method;
    private Map<String, ?> params;
    private T responseType;

    public AsyncDataRequest(String key, String url, HttpMethod method, T responseType, Map<String, ?> params) {
        this.key = key;
        this.url = url;
        this.method = method;
        this.params = params;
        this.responseType = responseType;
    }

    public AsyncDataRequest(String key, String url, HttpMethod method, T responseType) {
        this(key, url, method, responseType, new LinkedHashMap<>());
    }
}
