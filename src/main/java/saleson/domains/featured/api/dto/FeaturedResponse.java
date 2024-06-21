package saleson.domains.featured.api.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.ObjectUtils;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FeaturedResponse {
    private String link;
    private String title;
    private String image;
    private String startDate;
    private String endDate;
    private String type;
    private String simpleContent;
    private String linkTarget;
    private String linkRel;
    private String eventViewUrl;
    public String getLabel() {

        String label = "";

        switch (getType()) {
            case "EVENT": label = "Event"; break;
            case "FEATURED": label = "기획전"; break;
            default:
        }

        return label;
    }
    
    public String getDateText() {
        String startDate = getStartDate();
        String endDate = getEndDate();

        if (ObjectUtils.isEmpty(startDate) && ObjectUtils.isEmpty(endDate)) {
            return "상시";
        }

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
