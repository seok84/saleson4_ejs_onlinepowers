package saleson.domains.common.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QuickInfoResponse {
    private int cartQuantity;
    private int wishlistCount;
}
