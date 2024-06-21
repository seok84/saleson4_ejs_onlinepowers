package saleson.domains.mypage.application.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserInfoResponse {

    private long userId;
    private String loginId;
    private String userName;
    private String levelName;
    private String email;
    private String phoneNumber;
    private String telNumber;
    private String post;
    private String newPost;
    private String address;
    private String addressDetail;
    private String birthdayYear;
    private String birthdayMonth;
    private String birthdayDay;
    private String birthdayType;
    private String gender;
    private String receiveSms;
    private String receiveEmail;

}
