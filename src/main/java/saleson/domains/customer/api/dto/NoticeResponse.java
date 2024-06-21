package saleson.domains.customer.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NoticeResponse {

    private int noticeId;
    private boolean noticeFlag;
    private String subject;
    private String content;
    private String createdDate;
    private String link;
    private String targetOption;
    private String relOption;

}
