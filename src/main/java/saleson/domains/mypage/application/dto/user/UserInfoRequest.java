package saleson.domains.mypage.application.dto.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
public class UserInfoRequest {
    private long userId;
    private String loginId;
    private String userName;
    private String email;
    private String phoneNumber;
    private String telNumber;
    private String post;
    private String newPost;
    private String address;
    private String addressDetail;
    private String gender;
    private String receiveSms;
    private String receiveEmail;

}
