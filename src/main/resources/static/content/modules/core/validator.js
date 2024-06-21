(function ($) {

    var BANNED_WORDS;
    var defaultOptions = {
        'requiredClass': 'required',
        'optionalClass': 'optional',
        'submitHandler': ''
    };

    var methods = {
        init: function (options) {

            return this.each(function () {

                var $this = $(this);
                var data = $this.data('options');

                if (!data) {
                    options = $.extend(defaultOptions, options);
                    $(this).data('options', options);
                }

                $.validator.init($this, options);
            });
        },


        submitHandler: function (submitHandler) {
            return this.each(function () {
                var $this = $(this);
                var data = $this.data('options');

                var options = $.extend({}, defaultOptions);
                if (!data) {
                    options.submitHandler = submitHandler;
                    $(this).data('options', options);
                }

                $.validator.init($this, options);
            });
        },


        option: function (options) {
            return this.each(function () {

                var $this = $(this);
                var data = $this.data('options');

                $(this).data('options', $.extend(data, options));
                $saleson.core.alert(options.requiredClass);
            });
        }

    };


    $.fn.validator = function (method) {

        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));

        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);

        } else if (typeof method === 'function' || !method) {
            return methods.submitHandler.apply(this, arguments);

        } else {
            $.error(method + '는 존재하지 않는 Method 입니다.');

        }
    };


    var VALIDATOR_MESSAGE = {
        'ko': {
            _number: '{0} 항목을 숫자로만 입력해 주세요.',
            _number_nagetive: '{0} 항목을 숫자로만 입력해 주세요.',
            _number_comma: '{0} 항목을 숫자로만 입력해 주세요.',
            _number_masking: '{0} 항목을 숫자로만 입력해 주세요.',
            _korean: '{0} 항목을 한글로만 입력해 주세요.',
            _minlength: '{0} 항목을 {1}글자 이상 입력해 주세요.',
            _length: '{0} 항목을 {1}글자로 입력해 주세요.',
            _min: '{0} 항목을 {1} 이상으로 입력해 주세요.',
            _max: '{0} 항목을 {1} 이하로 입력해 주세요.',
            _phone: '{0} 항목을 정확히 입력해 주세요.',
            _tel: '{0} 항목을 정확히 입력해 주세요.',
            _date: '{0} 항목의 날짜 형식을 YYYYMMDD 형태로 정확히 입력해 주세요.',
            _email: '이메일 주소를 정확히 입력해 주십시오.',
            _email_masking: '이메일 주소를 정확히 입력해 주십시오.',
            _first_email: '이메일 처음 부분에 한글을 입력할 수 없습니다.',
            _last_email: '이메일 마지막 부분에 한글을 입력할 수 없습니다.',
            //_id: '아이디는 6~20 글자로 영문(대,소문자), 숫자, 특수문자(-), 특수문자(_), 특수문자(.) 조합으로 입력해 주십시요.',
            _id: '아이디는 4~16 글자로 영문(대,소문자), 숫자 조합으로 입력해 주십시요.',
            _filter: '{0}에 사용할 수 없는 단어가 포함되어 있습니다.',
            _password: '비밀번호는 8~20 자리의 영문+숫자+특수 문자로 되어야 합니다.',
            _duplicated: '{0} 항목에 동일한 문자를 연속해서 사용할 수 없습니다. ({1}자 이상 사용 불가)',
            _emoji: '{0}에는 이모티콘을 추가할 수 없습니다.',
            _phone_number: '{0} 항목을 입력해 주세요.',
            text: '{0} 항목을 입력해 주세요.',
            checkbox: '{0} 항목을 체크해 주세요.',
            select: '{0} 항목을 선택해 주세요.'
        },
    };

    // 스태틱 메서드로 지정 (Static Method)
    $.validator = {
        currentClass: '',
        currentOptionalClass: '',  // 해당 값이 있는 경우에는 지정된 클래스에 해당하는 것만 체크한다.

        optionalKeys: ['_number', '_number_nagetive', '_number_comma', '_minlength', '_length', '_min', '_max', '_korean', '_phone', '_tel', '_date', '_email', '_first_email', '_last_email', '_id', '_filter', '_password', '_emoji', '_phone_number'],

        // _number_comma: /^[0-9]+[0-9\,]+[0-9]$/,
        // _id: /^[a-zA-Z0-9_\-.]{6,20}$/,
        // _password: /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,20}$/   ==> 영문 + 숫자1개 이상
        patterns: {
            _number: /^[\-|0-9]+$/,
            _number_nagetive: /^(0|[-]?[1-9][0-9]*)+$/,
            _number_comma: /^[0-9\,]+$/,
            _number_masking: /^[0-9\*]+$/,
            _minlength: /^[0-9]+$/,
            _length: /^[0-9]+$/,
            _min: /^[0-9]+$/,
            _max: /^[0-9]+$/,
            _korean: /^[가-힝]+$/,
            _phone: /^0\d{2}[-]{0,1}\d{3,4}[-]{0,1}\d{4}$/,
            _tel: /^\d{0,3}[-]{0,1}\d{3,4}[-]{0,1}\d{4}$/,
            _date: /^\d{1,4}\d((0?\d)|(1[012]))\d([012]?\d|30|31)$/,
            _email: /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,3}$/,
            _email_masking: /^([0-9a-zA-Z_\.\*-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,3}$/,
            _first_email: /^([0-9a-zA-Z_\.-]+)$/,
            _last_email: /^([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,3}$/,
            _id: /^[a-zA-Z0-9]{6,30}$/,
            _password: /(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,20}$/,
            _emoji: /^[^\uD83C-\uDBFF\uDC00-\uDFFF]+$/,
            _special: /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gim,
            _phone_number: /^[0-9]{11,12}$/
        },

        messages: (function () {
            var lang = typeof OP_LANGUAGE !== undefined || OP_LANGUAGE == '' ? 'ko' : OP_LANGUAGE;
            return $.extend({}, VALIDATOR_MESSAGE['ko'], VALIDATOR_MESSAGE[lang]);
        }()),


        init: function ($selector, options) {
            $.ajaxSetup({async: false});

            if ($selector.find('._filter').length > 0) {
                // 금지어 목록 조회
                const uri = $saleson.core.api.host + '/api/common/ban-word/list';
                $.get(uri, {}, function (response) {
                    BANNED_WORDS = response.banwords;
                }, 'json');

            }

            $selector.find("input[type=text], input[type=password], input[type=email], input[type=tel], input[type=number], input[type=checkbox], input[type=radio]").keypress(function (e) {
//				if (e.keyCode == 13) {
//					return $.validator.validate($selector, options);
//					return false;
//				}
            });

            $selector.find("input[type=image], input[type=submit], button[type=image], button[type=submit]").click(function () {
                return $.validator.validate($selector, options);
            });

            $selector.find(".submit").click(function () {
                return $.validator.validate($selector, options);
            });
        },


        isEmpty: function (value) {
            return $.trim(value) == "" ? true : false;
        },

        // array => '.class1, .class2, .class3' 형태의 스트링으로 변환
        arrayToCommaClassName: function (arr) {
            var classCount = 0;
            var commaClassNames = '';
            for (var i = 0; i < arr.length; i++) {
                var className = $.trim(arr[i]);
                if (className != '') {
                    if (classCount > 0) {
                        commaClassNames += ", ";
                    }
                    commaClassNames += "." + className;
                    classCount++;
                }
            }
            return commaClassNames;
        },

        // XXX항목을 입력해 주세요 형식.(static으로 사용)
        required: function ($selector, message) {
            if ($.validator.isEmpty($selector.val())) {
                var alertMessage = message;
                if (message == undefined) {
                    alertMessage = $.validator.messages['text'].format($selector.attr("title"));
                }

                $.validator.validatorAlert(alertMessage, $selector);
                $selector.focus();
                return false;
            }
            return true;
        },

        validate: function (selector, options) {

            var errors = 0;
            var requiredClassNames = options.requiredClass.split(',');
            var optionalClassNames = options.optionalClass.split(',');


            var requiredClassName = $.validator.arrayToCommaClassName(requiredClassNames);
            var optionalClassName = $.validator.arrayToCommaClassName(optionalClassNames);
            var currentRequiredClassName = $.validator.arrayToCommaClassName($.validator.currentClass.split(','));			// Dynamic Required Class
            var currentOptionalClassName = $.validator.arrayToCommaClassName($.validator.currentOptionalClass.split(','));	// Dynamic Optional Class

            var targetSelector = requiredClassName;
            if ($.trim(optionalClassName) != '') {
                targetSelector += ', ' + optionalClassName;
            }
            if ($.trim(currentRequiredClassName) != '') {
                targetSelector += ', ' + currentRequiredClassName;
            }
            if ($.trim(currentOptionalClassName) != '') {
                targetSelector += ', ' + currentOptionalClassName;
            }


            selector.find(targetSelector).each(function () {
                var tagName = $(this).get(0).tagName.toLowerCase();
                var tagType = "";
                var title = $(this).attr('title');
                var value = $(this).val();
                var name = $(this).attr('name');

                var classes = $(this).attr('class');
                var isRequired = false;

                title = title == undefined ? name : title;

                if (tagName == 'input') {
                    try {
                        tagType = $(this).attr("type").toLowerCase();
                    } catch (e) {
                        $saleson.core.alert('input 항목에 type 속성이 없습니다.(' + name + ')');
                        return false;
                    }

                }
                /*
                if (classes.indexOf('required') > -1) {
                    isRequired = true;
                }*/

                if ($.validator.currentClass != '') {

                    var currentClassNames = $.validator.currentClass.split(',');
                    for (var i = 0; i < currentClassNames.length; i++) {
                        var currentClass = $.trim(currentClassNames[i]);
                        if (currentClass != '' && $(this).hasClass(currentClass)) {
                            isRequired = true;
                            break;
                        }
                    }
                }

                // 문자 중복체크 (기본이 3)
                var isDuplicated = false;

                if ($(this).hasClass('_duplicated')) {
                    isDuplicated = true;
                }

                if (isDuplicated) {

                    if (value != '') {
                        var duplicateCount = 3;
                        var isCharDuplicated = false;
                        var cehcekedChar = [];
                        var arrayValue = value.split('');
                        var length = arrayValue.length;
                        for (var i = 0; i < length; i++) {
                            var char = arrayValue[i];
                            if ($.validator.patterns._special.test(char)) {
                                char = "\\" + char;
                            }

                            var pattern = '';
                            for (var j = 0; j < duplicateCount; j++) {
                                pattern += char;
                            }

                            cehcekedChar[char] = pattern;
                        }

                        var regExp;
                        for (var key in cehcekedChar) {
                            var pattern = cehcekedChar[key];
                            regExp = new RegExp(pattern);

                            isCharDuplicated = regExp.test(value);

                            if (isCharDuplicated) {
                                break;
                            }
                        }

                        if (isCharDuplicated) {
                            errors++;

                            $.validator.validatorAlert($.validator.messages['_duplicated'].format(title, duplicateCount), $(this));
                            $(this).focus();

                            return false;
                        }
                    }
                }

                if ($(this).hasClass('required')) {
                    isRequired = true;
                }

                if (isRequired) {
                    if (tagName == 'input') {

                        if (tagType == 'text' || tagType == "password" || tagType == "email" || tagType == "tel" || tagType == "number") {
                            //alert(tagType);
                            if (value == '') {
                                errors++;

                                $.validator.validatorAlert($.validator.messages['text'].format(title), $(this));
                                $(this).focus();
                                return false;
                            }
                        } else if (tagType == "file") {

                            if (value == '') {
                                errors++;

                                // 포커스 타겟 지정
                                var $focusTarget = $(this).find('> label');
                                if ($focusTarget.length == 0) {
                                    $focusTarget = $(this);
                                }
                                $.validator.validatorAlert($.validator.messages['select'].format(title), $focusTarget);
                                $(this).focus();
                                return false;
                            }
                        } else if (tagType == "radio") {

                            var $radio = $('input[name=' + name + ']');
                            var radioCheckedLength = $('input[name=' + name + ']:checked').length;

                            if (radioCheckedLength == 0) {
                                errors++;
                                $.validator.validatorAlert($.validator.messages['select'].format(title), $radio.eq(0));
                                $radio.eq(0).focus();
                                return false;
                            }

                        } else if (tagType == "checkbox") {

                            var $checkbox = $('input[name=' + name + ']');
                            var checkboxCheckedLength = $('input[name=' + name + ']:checked').length;
                            if (checkboxCheckedLength == 0) {
                                errors++;
                                $.validator.validatorAlert($.validator.messages['checkbox'].format(title), $checkbox);
                                $checkbox.focus();
                                return false;
                            }
                        }
                    } else if (tagName == 'select') {

                        if (value == '') {
                            errors++;
                            $.validator.validatorAlert($.validator.messages['select'].format(title), $(this));
                            $(this).focus();
                            return false;
                        }

                    } else if (tagName == 'textarea') {
                        if (value == '') {
                            errors++;
                            $.validator.validatorAlert($.validator.messages['text'].format(title), $(this));
                            $(this).focus();
                            return false;
                        }
                    }
                }


                //var keys = getKeys($.validator.messages);
                var keys = $.validator.optionalKeys;

                for (var i = 0; i < keys.length; i++) {

                    // 검증 대상인가?
                    var isCurrentOptionalFlag = false;


                    if (isRequired
                        || ($(this).hasClass('optional') && $.trim($(this).val()) != '')
                        || ($.validator.currentOptionalClass != '' && $(this).hasClass($.validator.currentOptionalClass) && $.trim($(this).val()) != '')) {
                        isCurrentOptionalFlag = true;

                    }

                    if (!isCurrentOptionalFlag) {
                        continue;
                    }


                    // 날짜(yyyymmdd)
                    if (keys[i] == "_date") {
                        if ($(this).hasClass(keys[i])) {
                            if (validateDate(value) == false) {
                                errors++;

                                $saleson.core.alert($.validator.messages[keys[i]].format(title));
                                $(this).focus();
                                return false;
                            }
                        }

                        // 금지어 필터링.
                    } else if (keys[i] == "_filter") {
                        if ($(this).hasClass(keys[i])) {
                            var bannedWord = $.validator.getBannedWord(value);


                            if (bannedWord != null) {
                                errors++;
                                //$saleson.core.alert('금지');
                                $saleson.core.alert($.validator.messages[keys[i]].format(title));
                                $(this).focus();
                                return false;
                            }
                        }

                    } else if (keys[i] == "_minlength" || keys[i] == "_length" || keys[i] == "_min" || keys[i] == "_max") {

                        var classes = $(this).attr("class").split(" ");
                        for (var j = 0; j < classes.length; j++) {

                            var cls = classes[j].substring(0, keys[i].length + 1);
                            if (cls == keys[i] + '_') {
                                var classText = classes[j].split("_");

                                try {
                                    var checkValue = parseInt(classText[2]);
                                    var hasError = false;

                                    if (keys[i] == "_minlength") {
                                        if (value.length < checkValue) {
                                            hasError = true;
                                        }
                                    } else if (keys[i] == "_length") {
                                        if (value.length != checkValue) {
                                            hasError = true;
                                        }
                                    } else if (keys[i] == "_min") {
                                        value = value.replace(/,/g, "");
                                        if (value < checkValue) {
                                            hasError = true;
                                        }
                                    } else if (keys[i] == "_max") {
                                        value = value.replace(/,/g, "");
                                        if (value > checkValue) {
                                            hasError = true;
                                        }
                                    }

                                    if (hasError) {
                                        errors++;
                                        //$saleson.core.alert('금지');
                                        $saleson.core.alert($.validator.messages[keys[i]].format(title, checkValue));
                                        $(this).focus();
                                        return false;
                                    }
                                } catch (e) {
                                }
                            }
                        }

                    } else {

                        if ($(this).hasClass(keys[i]) && value != "") {
                            if (!$.validator.patterns[keys[i]].test(value)) {
                                errors++;
                                $saleson.core.alert($.validator.messages[keys[i]].format(title));
                                $(this).focus();
                                return false;
                            }
                        }
                    }
                }


                // 이메일 검증 추가
                if ($(this).hasClass("_email1")) {
                    var $email = selector.find(targetSelector).filter('._email1');
                    if (checkEmail($email) == false) {
                        errors++;
                        return false;
                    }
                }


            });


            if (errors == 0) {
                if ($.isFunction(options.submitHandler)) {
                    try {
                        return options.submitHandler(selector);
                    } catch (e) {
                        //Common.exceptionHandler(e, "op.validator의 submitHandler 처리 시 오류가 발생하였습니다.");
                        return false;
                    }

                } else {
                    return true;
                }

            } else {

                return false;
            }

        },


        validatorAlert: function (message, selector) {

            const tooltip = $saleson.core.tooltip(selector);

            if (tooltip.valid()) {
                tooltip.show(message)
            } else {
                $saleson.core.alert(message);
            }
        },

        getBannedWord: function (value) {

            if (BANNED_WORDS == null) return null;

            for (var i = 0; i < BANNED_WORDS.length; i++) {
                if (value.indexOf(BANNED_WORDS[i]) > -1) {
                    return BANNED_WORDS[i];
                }
            }

            return null;
        },

        validateEditor: function (editors, id) {
            if (editors != undefined) {
                editors.getById[id].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용됩니다.

                var content = document.getElementById(id).value;


                if (content == "" || content == "<br>") {
                    $saleson.core.alert('내용을 입력해 주세요');
                    editors.getById["content"].exec("FOCUS");
                    return false;
                }


                if ($.validator.getBannedWord(content) != null) {
                    $saleson.core.alert('내용에 금지어가 포함되어 있습니다.');
                    editors.getById[id].exec("FOCUS");
                    return false;
                }
            }
            return true;
        },
        validatePassword: function (loginId, password) {
            var sameSize = 3;
            var duplicateCount = 3;
            var arrayValue = password.split('');
            var length = arrayValue.length;
            var regExp;

            if (loginId == '' || password == '') {
                $saleson.core.alert('아이디 또는 패스워드가 없습니다.');
                return false;
            }

            if (!$.validator.patterns._password.test(password)) {
                $saleson.core.alert($.validator.messages._password);
                return false;
            }

            for (var i = 0; i < length; i++) {
                var char = arrayValue[i];
                if ($.validator.patterns._special.test(char)) {
                    char = "\\" + char;
                }

                var pattern = '';
                for (var j = 0; j < duplicateCount; j++) {
                    pattern += char;
                }

                regExp = new RegExp(pattern);

                if (regExp.test(password)) {
                    $saleson.core.alert('패스워드에 반복되는 문자가 있습니다.');
                    return false;
                }
            }

            for (var i = 0; i <= password.length - sameSize; i++) {
                if (loginId.indexOf(password.substring(i, i + sameSize)) > -1) {
                    $saleson.core.alert('아이디와 중복되는 문자열이 있습니다.');
                    return false;
                }
            }

            const alphabet = 'abcdefghijklmnopqrstuvwxyz';
            const numbers = '0123456789';
            const custom = '1q2w3e4r5t6y7u8i9o0p1qaz2wsx';

            let isConsecutived = false;
            for (let i = 0; i < password.length - 3; i++) {
                let data = password.substr(i, 4);

                if (alphabet.indexOf(data) > -1) {
                    isConsecutived = true;
                    break;
                }

                if (numbers.indexOf(data) > -1) {
                    isConsecutived = true;
                    break;
                }
                if (custom.indexOf(data) > -1) {
                    isConsecutived = true;
                    break;
                }
            }

            if (isConsecutived) {
                $saleson.core.alert('비밀번호에 연속된 문자를 사용할 수 없습니다.');
                return false;
            }

            return true;
        }

    };

})(jQuery);


$(function () {
    $("input[type=text], input[type=password], input[type=file]").keypress(function (e) {
        if (e.keyCode == 13) {
            //return false;
        }
    });
});


String.prototype.format = function () {
    var args = arguments;
    return this.replace(/\{\{|\}\}|\{(\d+)\}/g, function (m, n) {
        if (m == "{{") {
            return "{";
        }
        if (m == "}}") {
            return "}";
        }
        return args[n];
    });
};


function getKeys(obj) {
    var r = []
    for (var k in obj) {
        if (!obj.hasOwnProperty(k))
            continue;
        r.push(k)
    }
    return r
}


function checkEmail($email) {
    var email = "";
    var emailInputSize = $email.length;

    if (emailInputSize == 1) {
        email = $email.eq(0).val();
        if (validateEmail(email) == false) {
            $.validator.validatorAlert($.validator.messages._email, $email.eq(0));
            $email.eq(0).focus();
            return false;
        }
    } else if (emailInputSize == 2) {
        var email1 = $email.eq(0).val();
        var email2 = $email.eq(1).val();

        if (email1 != '' && email2 != '') {
            email = email1 + '@' + email2;

            if (validateEmail(email) == false) {
                $.validator.validatorAlert($.validator.messages._email, $email.eq(0));
                $email.eq(0).focus();
                return false;
            }
        }
    }
}


function validateEmail(email) {
    if ($.validator.patterns['_email'].test(email))
        return true;
    else
        return false;
}


/**
 * 날짜 정보를 입력 받아서 유효성 체크
 * @param inDate YYYYMMDD
 **/
function validateDate(inDate) {
    var END_OF_MONTH = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (isNaN(inDate)) {
        return false;
    }

    if (Number(inDate) / 10000000 <= 1) return false;

    var strDate = String(inDate);
    var nYear = Number(strDate.substring(0, 4));
    var nMonth = Number(strDate.substring(4, 6));
    var nDay = Number(strDate.substring(6, 8));

    //년 확인
    if (nYear <= 0)
        return false;

    //월 확인
    if (nMonth < 1 || nMonth > 12) return false;

    //윤달 확인
    if (nYear % 4 == 0)
        if (nYear % 100 != 0 || nYear % 400 == 0)
            END_OF_MONTH[2] = 29;

    //일 확인
    if (nDay < 1 || END_OF_MONTH[nMonth] < nDay)
        return false;

    return true;
}

