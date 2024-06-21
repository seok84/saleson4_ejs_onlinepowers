package saleson.domains.mypage.application.dto.info;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.util.ObjectUtils;
import saleson.common.api.infra.dto.Criteria;

@Getter
@Setter
@NoArgsConstructor
public class OrderCriteria extends Criteria {

    private String searchStartDate;

    private String searchEndDate;

    private String statusType;

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

    @Override
    public String getWhere() {

        if (!ObjectUtils.isEmpty(getQuery())){
            setWhere("MYPAGE_ORDER");
        }

        return super.getWhere();
    }
}
