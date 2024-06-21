package saleson.domains.popup.application.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PopupListResponse {

    private List<PopupResponse> list;

}
