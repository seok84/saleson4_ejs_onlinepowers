package saleson.domains.featured.api.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.ObjectUtils;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FeaturedDetailResponse {

    private int id;
    private String url;
    private String link;
    private String title;
    private String image;
    private String simpleContent;
    private String content;
    private boolean replyUsedFlag;
    private String prodState;
    private List<FeaturedItemListResponse> itemLists;
    private String startDate;
    private String endDate;
    private String eventViewUrl;

    public String getDateText() {
        String startDate = getStartDate();
        String endDate = getEndDate();

        if (!ObjectUtils.isEmpty(startDate) && !ObjectUtils.isEmpty(endDate)) {
            return startDate + "~" + endDate;
        }

        if (ObjectUtils.isEmpty(startDate) && !ObjectUtils.isEmpty(endDate)) {
            return endDate + "까지";
        }

        if (!ObjectUtils.isEmpty(startDate) && ObjectUtils.isEmpty(endDate)) {
            return startDate + "부터";
        }

        return "";
    }
}
