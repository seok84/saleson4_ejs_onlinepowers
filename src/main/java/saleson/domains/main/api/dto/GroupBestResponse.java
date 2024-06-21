package saleson.domains.main.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.item.application.dto.ItemResponse;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GroupBestResponse {

    private String key;
    private String name;

    private List<ItemResponse> items;

}
