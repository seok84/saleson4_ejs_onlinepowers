package saleson.domains.mypage.application.dto.benefit;

import lombok.Getter;
import lombok.Setter;
import org.springframework.util.ObjectUtils;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
public class PointCriteria extends Criteria {
    private String searchStartDate;
    private String searchEndDate;
    private String viewStartDate;
    private String viewEndDate;
    private String pointType;


    public String getSearchStartDate() {
        if (!ObjectUtils.isEmpty(searchStartDate)){
            searchStartDate = searchStartDate.replace("-","");
        }
        return searchStartDate;
    }

    public String getSearchEndDate() {
        if (!ObjectUtils.isEmpty(searchEndDate)){
            searchEndDate = searchEndDate.replace("-","");
        }
        return searchEndDate;
    }

    public String getViewStartDate(){
        String viewStartDate = "";
        if (!ObjectUtils.isEmpty(this.searchStartDate)){

            viewStartDate = this.searchStartDate.replaceAll("(\\d{4})(\\d{2})(\\d{2})", "$1-$2-$3");

        }
        return viewStartDate;
    }

    public String getViewEndDate(){
        String viewEndDate = "";
        if (!ObjectUtils.isEmpty(this.searchEndDate)){

            viewEndDate = this.searchEndDate.replaceAll("(\\d{4})(\\d{2})(\\d{2})", "$1-$2-$3");

        }
        return viewEndDate;
    }
}
