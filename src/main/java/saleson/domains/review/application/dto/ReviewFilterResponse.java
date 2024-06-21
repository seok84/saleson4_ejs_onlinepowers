package saleson.domains.review.application.dto;

import java.util.List;
import java.util.Map;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewFilterResponse {

    private String label;
    private String description;
    private long id;

    private List<Map<String, Object>> codes;

}
