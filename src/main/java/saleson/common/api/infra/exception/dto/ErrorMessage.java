package saleson.common.api.infra.exception.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

@JsonIgnoreProperties(ignoreUnknown = true)
public class ErrorMessage {

    private int status;
    private String code;
    private String message;
    private String description;

    public ErrorMessage(String code, String message) {
        this.code = code;
        this.message = message;
    }
}
