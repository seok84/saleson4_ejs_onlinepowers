package saleson.domains.qna.application.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ItemQnaResponse extends QnaResponse {

    private String itemName;
    private String itemUserCode;
    private String itemImage;
    private String brand;

}
