package saleson.common.async.application.dto;

import lombok.Getter;

@Getter
public class AsyncDataResponse {
    private String key;
    private Object object;

    public AsyncDataResponse(String key) {
        this.key = key;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
