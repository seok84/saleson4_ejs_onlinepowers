package saleson.common.view;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
public class JsonView {

    private boolean successFlag;
    private String errorMessage = "";
    private Object data;

    @Builder
    public JsonView(boolean successFlag, String errorMessage, Object data) {
        this.successFlag = successFlag;
        this.errorMessage = errorMessage;
        this.data = data;
    }
}
