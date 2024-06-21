package saleson.domains.display.application.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class DisplayImageListResponse {
    private List<DisplayImageResponse> list;
}
