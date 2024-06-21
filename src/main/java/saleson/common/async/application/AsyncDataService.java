package saleson.common.async.application;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.servlet.ModelAndView;
import saleson.common.api.infra.SalesonApi;
import saleson.common.api.infra.dto.ApiRequest;
import saleson.common.api.infra.exception.SalesonApiException;
import saleson.common.async.application.dto.AsyncDataRequest;
import saleson.common.async.application.dto.AsyncDataResponse;
import saleson.common.context.SalesonContext;
import saleson.common.context.SalesonContextHolder;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class AsyncDataService {

    private final SalesonApi salesonApi;
    private final SalesonContextHolder salesonContextHolder;
    private final ExecutorService asyncDataExecutorServicePool;

    private CompletableFuture<AsyncDataResponse> getFuture(HttpServletRequest request, AsyncDataRequest dataRequest) {

        SalesonContext salesonContext = salesonContextHolder.getSalesonContext(request);

        return CompletableFuture.supplyAsync(() -> {
                    AsyncDataResponse asyncData = new AsyncDataResponse(dataRequest.getKey());

                    asyncData.setObject(
                            salesonApi.request(
                                    ApiRequest.builder()
                                            .context(salesonContext)
                                            .url(dataRequest.getUrl())
                                            .method(dataRequest.getMethod())
                                            .params(dataRequest.getParams())
                                            .build(),
                                    (Class) dataRequest.getResponseType()
                            )
                    );

                    return asyncData;
                }
                ,asyncDataExecutorServicePool
        );
    }

    private CompletableFuture<List<AsyncDataResponse>> getResultFuture(HttpServletRequest request, AsyncDataRequest... dataRequests) {

        List<CompletableFuture<AsyncDataResponse>> futures = new ArrayList<>();

        if (!ObjectUtils.isEmpty(dataRequests)) {
            for (AsyncDataRequest dataRequest : dataRequests) {
                if (!ObjectUtils.isEmpty(dataRequest)) {
                    futures.add(getFuture(request, dataRequest));
                }
            }
        }

        if (ObjectUtils.isEmpty(futures)) {
            return null;
        }

        CompletableFuture<List<AsyncDataResponse>> result = CompletableFuture.allOf(futures.toArray(new CompletableFuture[futures.size()]))
                .thenApply(
                        v -> futures.stream()
                                .map(CompletableFuture::join)
                                .collect(Collectors.toList())
                );

        return result;
    }

    public void setModelAndViewBy(HttpServletRequest request, ModelAndView modelAndView, AsyncDataRequest... dataRequests) {

        if (!ObjectUtils.isEmpty(dataRequests)) {
            CompletableFuture<List<AsyncDataResponse>> result = getResultFuture(request, dataRequests);

            try {
                if (!ObjectUtils.isEmpty(result) && !ObjectUtils.isEmpty(result.get())) {
                    result.get().forEach(asyncData -> {
                        modelAndView.addObject(asyncData.getKey(), asyncData.getObject());
                    });
                }
            } catch (InterruptedException e) {
                throw new SalesonApiException(e.getCause());
            } catch (ExecutionException e) {
                throw new SalesonApiException(e.getCause());
            }
        }


    }

    public void setModelBy(HttpServletRequest request, Model model, AsyncDataRequest... dataRequests) {

        if (!ObjectUtils.isEmpty(dataRequests)) {
            CompletableFuture<List<AsyncDataResponse>> result = getResultFuture(request, dataRequests);

            try {
                if (!ObjectUtils.isEmpty(result) && !ObjectUtils.isEmpty(result.get())) {
                    result.get().forEach(asyncData -> {
                        model.addAttribute(asyncData.getKey(), asyncData.getObject());
                    });
                }
            } catch (InterruptedException e) {
                throw new SalesonApiException(e.getCause());
            } catch (ExecutionException e) {
                throw new SalesonApiException(e.getCause());
            }
        }


    }


}
