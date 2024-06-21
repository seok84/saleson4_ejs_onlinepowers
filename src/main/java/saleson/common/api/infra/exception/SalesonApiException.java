package saleson.common.api.infra.exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;

@Getter
@Setter
public class SalesonApiException extends RuntimeException {

    private HttpStatusCode statusCode;
    private String statusText;
    private String redirect;


    public SalesonApiException(String message) {
        super(message);
    }

    public SalesonApiException(Throwable cause) {
        super(cause.getMessage(), cause);
    }

    public SalesonApiException(String message, HttpStatusCode statusCode, String statusText) {
        super(message);
        setStatusCode(statusCode);
        setStatusText(statusText);
    }

    public SalesonApiException(HttpClientErrorException e) {
        this(e.getResponseBodyAs(String.class), e.getStatusCode(), e.getStatusText());
    }

    public SalesonApiException(HttpServerErrorException e) {
        this(e.getResponseBodyAs(String.class), e.getStatusCode(), e.getStatusText());
    }

    public SalesonApiException(SalesonApiException e, String redirect) {
        this(e);
        setStatusText(e.getStatusText());
        setStatusCode(e.getStatusCode());
        setRedirect(redirect);
    }

    public SalesonApiException(Throwable cause, String redirect) {
        this(cause);
        setRedirect(redirect);
    }
}
