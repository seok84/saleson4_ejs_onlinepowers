package saleson.domains.common.application.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import saleson.domains.common.application.enumeration.IslandType;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IslandResponse {
    private String zipcode;
    private String address;
    private IslandType islandType;
}
