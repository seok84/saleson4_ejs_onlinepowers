package saleson.common.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.TypeMismatchException;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingPathVariableException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.support.MissingServletRequestPartException;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.resource.NoResourceFoundException;
import saleson.common.api.infra.exception.SalesonApiException;
import saleson.common.api.infra.exception.dto.ErrorMessage;

import java.io.IOException;
import java.util.Map;

@ControllerAdvice
@Slf4j
@RequiredArgsConstructor
public class SalesonExceptionHandler {

    private final ObjectMapper objectMapper;

    @ExceptionHandler({
            HttpRequestMethodNotSupportedException.class
    })
    public String handleMethodNotAllowed(HttpServletRequest request, Exception e) {

        printErrorLog(request, e);

        return "error/404";
    }

    @ExceptionHandler({
            MissingServletRequestParameterException.class,
            ServletRequestBindingException.class,
            TypeMismatchException.class,
            HttpMessageNotReadableException.class,
            MethodArgumentNotValidException.class,
            MissingServletRequestPartException.class,
            BindException.class,
            IllegalArgumentException.class,
            IllegalStateException.class
    })
    public String handleBadRequest(HttpServletRequest request, Exception e) {

        printErrorLog(request, e);

        return "error/404";
    }

    @ExceptionHandler({
            MissingPathVariableException.class,
            ConversionNotSupportedException.class,
            HttpMessageNotWritableException.class,
            NullPointerException.class,
            NumberFormatException.class,
            IOException.class
    })
    public String handleInternalServerError(HttpServletRequest request, Exception e) {

        printErrorLog(request, e);

        return "error/500";

    }

    @ExceptionHandler(NoResourceFoundException.class)
    public String handleNoResourceFoundException(HttpServletRequest request, Exception ex, Model model) {
        return "error/404";
    }

    @ExceptionHandler(Exception.class)
    public String handleException(HttpServletRequest request, Exception ex, Model model) {

        printErrorLog(request, ex);
        return "error/500";
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handle404(HttpServletRequest request, NoHandlerFoundException ex, Model model) {
        return "error/404";
    }

    @ExceptionHandler(SalesonApiException.class)
    public String handleSalesonApiException(HttpServletRequest request,
                                            RedirectAttributes redirectAttributes,
                                            SalesonApiException ex,
                                            Model model) {

        ErrorMessage message = getErrorMessage(ex);

        model.addAttribute("errorCode", message.getCode());
        model.addAttribute("errorMessage", message.getMessage());

        printErrorLog(request, ex);

        if (!ObjectUtils.isEmpty(ex.getStatusCode())) {
            if (HttpStatus.UNAUTHORIZED.isSameCodeAs(ex.getStatusCode())) {
                log.error("Api Request Unauthorized ["+message.getCode()+"]");
                return "redirect:/user/login";
            }
        }

        if (!ObjectUtils.isEmpty(message)) {
            if (HttpStatus.UNAUTHORIZED.value() == message.getStatus()) {
                log.error("Api Request Unauthorized ["+message.getCode()+"]");
                return "redirect:/user/login";
            }
        }

        if (!ObjectUtils.isEmpty(ex.getRedirect())) {

            redirectAttributes.addFlashAttribute("errorCode", message.getCode());
            redirectAttributes.addFlashAttribute("errorMessage", message.getMessage());

            return "redirect:"+ex.getRedirect();
        }

        return "error/404";
    }

    private void printErrorLog(HttpServletRequest request, Exception e) {

        log.error("Error URI ->  {}",request.getRequestURI());
        log.error("Exception ->  {}",e.getClass().getSimpleName());
        log.error("Exception Message ->  {}",e.getMessage());
        log.error("ErrorLog", e);
    }


    private ErrorMessage getErrorMessage(SalesonApiException ex) {

        try {

            return objectMapper.readValue(ex.getMessage(), ErrorMessage.class);
        } catch (Exception e){
            log.error("errorMessage parse error {}", e.getMessage());
        }

        return new ErrorMessage("API_ERROR","통신에 오류가 발생했습니다.");
    }
}
