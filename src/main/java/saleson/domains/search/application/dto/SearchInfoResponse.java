package saleson.domains.search.application.dto;

import lombok.Getter;
import lombok.Setter;
import saleson.domains.keyword.application.dto.KeywordResponse;

import java.util.List;

@Getter
@Setter
public class SearchInfoResponse {

    List<KeywordResponse> keywords;
    SearchResponse recommend;

}
