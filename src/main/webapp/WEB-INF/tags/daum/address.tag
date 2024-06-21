<%@ tag pageEncoding="utf-8" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<page:model>
    <div class="modal open-modal-address">
        <div class="dimmed-bg" onclick="salesOnUI.modal().show('.address-modal')"></div>
        <div class="modal-wrap">
            <button class="modal-close" onclick="salesOnUI.modal().show('.address-modal')">닫기</button>
            <div class="modal-header">
                주소찾기
            </div>
            <div class="modal-body" id="daumAddr"></div>
        </div>
    </div>
</page:model>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function openDaumAddress(tagNames, callBack) {

        var defaultTagNames = {
            'zipcodeAddress'		: 'zipcodeAddress',
            'newZipcode'			: 'newZipcode',
            'zipcode1' 				: 'zipcode1',
            'zipcode2' 				: 'zipcode2',
            'zipcode' 				: 'zipcode',
            'sido'					: 'sido',
            'sigungu'				: 'sigungu',
            'eupmyeondong'			: 'eupmyeondong',
            'jibunAddress'			: 'address',
            'jibunAddressDetail' 	: 'addressDetail',
            'roadAddress'			: 'address',
            'buildingCode'			: 'buildingCode'
        }

        if (tagNames != undefined) {
            $.each(defaultTagNames, function(key, value) {
                if (tagNames[key] != undefined) {
                    defaultTagNames[key] = tagNames[key];
                }
            });
        }
        let address_layer = document.getElementById('daumAddr');

    new daum.Postcode({
        oncomplete(data) {
            try {

                var post = data.postcode;
                if (post == '') {
                    post = data.zonecode;
                }
                //우편번호 값 입력
                if($("#newPostStr").length && $("#newPostSubStr").length){
                    $("#newPostStr").text(data.zonecode);
                    $("#newPostSubStr").text("");
                }
                $('input[name="'+ defaultTagNames.newZipcode +'"]').val(data.zonecode);
                $('input[name="'+ defaultTagNames.zipcode +'"]').val(post);
                $('input[name="'+ defaultTagNames.zipcode1 +'"]').val(data.postcode1);
                $('input[name="'+ defaultTagNames.zipcode2 +'"]').val(data.postcode2);

                $('input[name="'+ defaultTagNames.sido +'"]').val(data.sido);
                $('input[name="'+ defaultTagNames.sigungu +'"]').val(data.sigungu);
                $('input[name="'+ defaultTagNames.eupmyeondong +'"]').val(data.bname);

                var jibunAddress = data.jibunAddress;
                if (jibunAddress == '') {
                    jibunAddress = data.autoJibunAddress;
                }

                var roadAddress = data.roadAddress;
                if (roadAddress == '') {
                    roadAddress = data.autoRoadAddress;
                }

                var addr = jibunAddress;
                if(data.userSelectedType == 'R'){
                    addr = roadAddress;
                }

                if(data.buildingName != ''){
                    addr += ' ('+data.buildingName+')';
                    roadAddress += ' ('+data.buildingName+')';
                }

                $('input[name="'+ defaultTagNames.jibunAddress +'"]').val(addr);
                $('input[name="'+ defaultTagNames.jibunAddressDetail +'"]').val("");
                $('input[name="'+ defaultTagNames.jibunAddressDetail +'"]').focus();

                $('input[name="'+ defaultTagNames.zipcodeAddress +'"]').val('[' + data.zonecode + '] ' + roadAddress);
                $('input[name="'+ defaultTagNames.roadAddress +'"]').val(roadAddress);
                $('input[name="'+ defaultTagNames.buildingCode +'"]').val(data.buildingCode);

                if ($.isFunction(callBack)) {
                    callBack(data);
                }
            } catch (e) {
                alert(e.message);
            }
            salesOnUI.modal().show('.address-modal');
        },
        width : '100%',
        height : '100%'
    }).embed(address_layer);
        address_layer.style.display = 'block';

        let height = window.innerHeight*0.7; //우편번호서비스가 들어갈 element의 height

        address_layer.style.width = 100 + '%';
        address_layer.style.height = height + 'px';
        address_layer.style.maxHeight = height + 'px';
        address_layer.style.borderBottom = 1 + 'px solid';
        address_layer.style.padding = 0;

        salesOnUI.modal().show(".open-modal-address");
    }



/*function openDaumAddress(tagNames, callBack) {

	var defaultTagNames = {
        'zipcodeAddress'		: 'zipcodeAddress',
		'newZipcode'			: 'newZipcode',
		'zipcode1' 				: 'zipcode1',
		'zipcode2' 				: 'zipcode2',
		'zipcode' 				: 'zipcode',
		'sido'					: 'sido',
		'sigungu'				: 'sigungu',
		'eupmyeondong'			: 'eupmyeondong',
		'jibunAddress'			: 'address',
		'jibunAddressDetail' 	: 'addressDetail',
		'roadAddress'			: 'address',
		'buildingCode'			: 'buildingCode'
	}
	
	if (tagNames != undefined) {
		$.each(defaultTagNames, function(key, value) {
			if (tagNames[key] != undefined) {
				defaultTagNames[key] = tagNames[key];
			}
		});
	}
	new daum.Postcode({
	    oncomplete: function(data) {	        	
	    	try {
	    		
	    		var post = data.postcode;
	    		if (post == '') {
	    			post = data.zonecode;
	    		}
                //우편번호 값 입력
                if($("#newPostStr").length && $("#newPostSubStr").length){
                    $("#newPostStr").text(data.zonecode);
                    $("#newPostSubStr").text("");
                }
		        $('input[name="'+ defaultTagNames.newZipcode +'"]').val(data.zonecode);
		        $('input[name="'+ defaultTagNames.zipcode +'"]').val(post);
		        $('input[name="'+ defaultTagNames.zipcode1 +'"]').val(data.postcode1);
		        $('input[name="'+ defaultTagNames.zipcode2 +'"]').val(data.postcode2);
		        
		        $('input[name="'+ defaultTagNames.sido +'"]').val(data.sido);
		        $('input[name="'+ defaultTagNames.sigungu +'"]').val(data.sigungu);
		        $('input[name="'+ defaultTagNames.eupmyeondong +'"]').val(data.bname);
				
		        var jibunAddress = data.jibunAddress;
		        if (jibunAddress == '') {
		        	jibunAddress = data.autoJibunAddress;
		        }
		        
		        var roadAddress = data.roadAddress;
		        if (roadAddress == '') {
		        	roadAddress = data.autoRoadAddress;
		        }
		        
		        var addr = jibunAddress;
		        if(data.userSelectedType == 'R'){
		        	addr = roadAddress;
		        }

                if(data.buildingName != ''){
                    addr += ' ('+data.buildingName+')';
                    roadAddress += ' ('+data.buildingName+')';
                }

		        $('input[name="'+ defaultTagNames.jibunAddress +'"]').val(addr);
		        $('input[name="'+ defaultTagNames.jibunAddressDetail +'"]').val("");
		        $('input[name="'+ defaultTagNames.jibunAddressDetail +'"]').focus();

                $('input[name="'+ defaultTagNames.zipcodeAddress +'"]').val('[' + data.zonecode + '] ' + roadAddress);
                $('input[name="'+ defaultTagNames.roadAddress +'"]').val(roadAddress);
		        $('input[name="'+ defaultTagNames.buildingCode +'"]').val(data.buildingCode);
		        
		        if ($.isFunction(callBack)) {
		        	callBack(data);
		        }
		        
		        
		        
	    	} catch (e) {
				alert(e.message);
			}
	    	
	    }
	}).open();
}*/
</script>