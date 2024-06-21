package saleson.domains.customer.api.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FaqResponse {

    private String type;
    private String label;
    private String title;
    private String content;
    private int hit;

}
