package saleson.common.api.infra;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestClient;
import org.springframework.web.util.UriComponentsBuilder;
import saleson.common.api.infra.dto.ApiRequest;
import saleson.common.api.infra.exception.SalesonApiException;
import saleson.common.configuration.saleson.SalesonUrlConfig;
import saleson.common.context.SalesonContext;

import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SalesonApi {

    private final SalesonUrlConfig salesonUrlConfig;
    private final ObjectMapper objectMapper;
    private final RestClient restClient;

    private MultiValueMap getDefaultParams(Map<String, ?> params) {

        if (ObjectUtils.isEmpty(params)) {
            return new LinkedMultiValueMap();
        }

        MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

        params.forEach((s, object) -> {
            Object o = params.get(s);

            if (!ObjectUtils.isEmpty(o)) {
                map.add(s, o);
            }
        });

        return map;
    }

    private void setDefaultHeaders(SalesonContext context, HttpHeaders headers) {
        headers.set("SALESONID", context.getSalesonId());
        if (context.isHasToken()) {
            headers.set("Authorization", "Bearer " + context.getToken());
        }
    }


    public <T> T request(ApiRequest apiRequest, Class<T> responseType) {

        if (HttpMethod.GET.equals(apiRequest.getMethod())) {
            return get(apiRequest.getContext(), apiRequest.getUrl(), apiRequest.getParams(), responseType);
        } else if (HttpMethod.POST.equals(apiRequest.getMethod())) {
            return post(apiRequest.getContext(), apiRequest.getUrl(), apiRequest.getParams(), responseType);
        } else {
            throw new IllegalArgumentException("Not Allow method " + apiRequest.getMethod());
        }
    }

    public <T> T get(SalesonContext context,
                     String uri,
                     Map<String, ?> params,
                     Class<T> responseType) {

        try {

            UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromUriString(salesonUrlConfig.getApi() + uri);

            if (!ObjectUtils.isEmpty(params)) {
                uriComponentsBuilder.queryParams(getDefaultParams(params));
            }

            ResponseEntity<T> entity = restClient.get()
                    .uri(uriComponentsBuilder.build().toUriString())
                    .headers(httpHeaders -> {setDefaultHeaders(context, httpHeaders);})
                    .retrieve()
                    .toEntity(responseType);

            if (HttpStatus.OK != entity.getStatusCode()) {
                throw new IllegalArgumentException("Response Not OK");
            }

            T response = entity.getBody();

            return ObjectUtils.isEmpty(response) ? null : response;
        } catch (HttpClientErrorException e) {
            throw new SalesonApiException(e);
        } catch (HttpServerErrorException e) {
            throw new SalesonApiException(e);
        } catch (Exception e) {
            throw new SalesonApiException(e);
        }
    }


    public <T> T post(SalesonContext context,
                      String uri,
                      Map<String, ?> params,
                      Class<T> responseType) {

        try {

            ResponseEntity<T> entity = restClient.post()
                    .uri(salesonUrlConfig.getApi() + uri)
                    .headers(httpHeaders -> {setDefaultHeaders(context, httpHeaders);})
                    .contentType(MediaType.APPLICATION_JSON)
                    .accept(MediaType.APPLICATION_JSON)
                    .acceptCharset(Charset.forName("UTF-8"))
                    .body(getDefaultParams(params))
                    .retrieve()
                    .toEntity(responseType);

            if (HttpStatus.OK != entity.getStatusCode()) {
                throw new IllegalArgumentException("Response Not OK");
            }

            T response = entity.getBody();

            return ObjectUtils.isEmpty(response) ? null : response;
        } catch (HttpClientErrorException e) {
            throw new SalesonApiException(e);
        } catch (HttpServerErrorException e) {
            throw new SalesonApiException(e);
        } catch (Exception e) {
            throw new SalesonApiException(e);
        }

    }

    public <T> T get(SalesonContext context,
                     String uri,
                     Class<T> responseType) {

        return get(context, uri, new HashMap<>(), responseType);
    }

    public <T> T post(SalesonContext context,
                      String uri,
                      Class<T> responseType){

        return post(context, uri, new HashMap<>(), responseType);
    }


    public Map<String, Object> convert(Object object) {
        return objectMapper.convertValue(object, Map.class);
    }
}
