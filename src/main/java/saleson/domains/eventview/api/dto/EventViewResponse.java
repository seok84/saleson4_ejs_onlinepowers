package saleson.domains.eventview.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventViewResponse {
    private String url;
    private String uid;
    private String queryString;
}
