package saleson.domains.common.api.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class BankInfoResponse {

    private String key;
    private String label;

    @Builder
    public BankInfoResponse(String key, String label) {
        this.key = key;
        this.label = label;
    }

}
