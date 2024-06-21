package saleson.domains.main.api.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class MainBrandListResponse {
    private List<MainBrandResponse> list;
}
