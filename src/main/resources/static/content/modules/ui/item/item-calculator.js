function ItemCalculator() {
    this.$optionTop = $(".option-top");
    this.$optionBottom = $(".option-bottom");
    this.isSet = ITEM.itemType == '3';
    this.$parent;

    this.category;
    this.itemId;
    this.itemOptionType;
    this.dropdownArea;

    this.selectedOptions = [];

    let that = this;

    this.initEvent = function() {
        this.calculate(this.$optionTop);
        this.calculate(this.$optionBottom);
    }

    /**
     * 옵션 토글
     * @param $parent
     * @param paramThis
     */
    this.dropdownTitle = function(paramThis, target) {
        this.$parent = this.myParent($(paramThis));
        const index = this.$parent.find(target).index(paramThis);
        $dropdownTitle = this.$parent.find(target).eq(index);
        $dropdownTitle.parent().addClass('active');
        this.initOption();
    }
    /**
     * 옵션 토글
     * @param $parent
     * @param paramThis
     */
    this.selectWrap = function(paramThis, target) {
        this.$parent = this.myParent($(paramThis));
        this.$parent.find(target).removeClass('active');
        this.initOption();
    }
    this.optionTitle = function(paramThis, target) {
        this.$parent = this.myParent($(paramThis)); //선택한 옵션 제목 index
        const index = this.$parent.find(target).index(paramThis);
        const $this = this.$parent.find(target).eq(index); //선택한 옵션 제목 element
        this.category = $this.data("index"); //사이즈(1차), 색상(2차), 스타일(3차) - 조합형 옵션의 경우
        this.itemId = this.isSet ? $this.closest(".item-list").data("item-id") : ITEM.itemId; // 클릭한 옵션의 상품ID
        this.itemOptionType = this.isSet ? $this.closest(".item-list").data("option-type") : ITEM.itemOptionType;
        this.dropdownArea = this.isSet ? this.$parent.find(`div[data-item-id=${this.itemId}] .dropdown-area`) : this.$parent.find(".dropdown-area");
        this.selectedOptions = this.isSet ? optionState.selectedOptions.filter(option => option.itemId == this.itemId)[0]?.selectedOptions : optionState.selectedOptions;
        this.openOptionItems();
    }

    /**
     * 상세 옵션창 열기
     * @param category
     * @param itemOptionType
     * @param $parent
     * @param itemId
     */
    this.openOptionItems = function() {
        if (this.itemOptionType == 'S2' || this.itemOptionType == 'S3') {
            if (this.validateOption()) {
                //옵션제목별로 필터링
                if (this.category > 0) {
                    let filteredOptions = this.filterOptions();

                    // filteredOptions의 길이와 기존 옵션의 개수가 다를 경우, 다시 옵션 출력
                    if (this.dropdownArea.eq(this.category).find(".option-btn").length != filteredOptions.length) {
                        this.remakeOptionsHtml(filteredOptions);
                    }
                }
                this.dropdownArea?.eq(this.category)?.toggleClass('active');
            }
        } else if (this.itemOptionType == 'S') {
            this.dropdownArea?.eq(this.category)?.toggleClass('active');
        }
    }
    /**
     * 조합형 옵션 순차적으로 선택했는지 검증
     * @param category
     * @param itemId
     * @returns {boolean}
     */
    this.validateOption = function() {
        if (this.category == 0) return true;
        if (this.category == null || typeof this.category == 'undefined' || this.category == '') {
            console.log(this.category, 'validateOption index');
            return false;
        }

        for (let i = 0; i < this.category; i++) {
            if (this.isSet) {
                let selectedOption = optionState.selectedOptions?.filter(option => option.itemId == this.itemId);
                if (selectedOption.length == 0) {
                    $saleson.core.alert("위의 정보를 먼저 선택해 주세요.");
                    return false;
                } else {
                    if (selectedOption.length == 0 || !selectedOption[0].selectedOptions[i]) {
                        $saleson.core.alert("위의 정보를 먼저 선택해 주세요.");
                        return false;
                    }
                }
            } else {
                if (optionState?.selectedOptions?.length == 0 || !optionState?.selectedOptions[i]) {
                    $saleson.core.alert("위의 정보를 먼저 선택해 주세요.");
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * 실원본 데이터를 이용해 실제 존재하는 데어티 필터처리 및 중복 제거
     * @param category
     * @param itemOptionType
     * @param itemId
     * @returns {*[]}
     */
    this.filterOptions = function() {
        let originItemOptions = this.isSet ? itemSets.filter(set => set.item.itemId == this.itemId)[0]?.item?.itemOptions : itemOptions;
        let filteredOptions = [];
        if (this.itemOptionType == 'S2' || this.itemOptionType == 'S3') {
            //ex) 사이즈 - S, M, L 색상 - R, G, B
            //실제 데이터 - L, B 재고 없음
            //초기 데이터 - 모든 옵션 재고가 존재한다는 가정하에 출력됨. L, B도 재고가 없지만 출력됨.
            // 위 문제를 방지하기 위해 필터처리
            let that = this;
            filteredOptions = originItemOptions.filter((value, index, self) => {
                if (that.category == 1) {
                    return (that.selectedOptions[0] == value.optionName1);
                } else if (that.category == 2) {
                    return (that.selectedOptions[0] == value.optionName1) && (that.selectedOptions[1] == value.optionName2);
                }
            });

            //중복 제거
            filteredOptions = filteredOptions.filter((value, index, self) => {
                if (that.category == 1) {
                    return self.findIndex(item => item.optionName2 === value.optionName2) === index;
                } else if (that.category == 2) {
                    return self.findIndex(item => item.optionName3 === value.optionName3) === index;
                }
            });
        }
        return filteredOptions;
    };
    //옵션 목록 재 마크업
    this.remakeOptionsHtml = function(filteredOptions) {
        let categoriesContainer = this.dropdownArea?.eq(this.category)?.find(".option-item");
        if (categoriesContainer) {
            let optionHtml = "";
            if (this.itemOptionType == 'S2' || this.itemOptionType == 'S3') {
                for (filteredOption of filteredOptions) {
                    if (this.category == 1) {
                        categoriesContainer.empty();
                        optionHtml += `<button type="button" class="option-btn" data-index="${this.category}"><span data-index="${this.category}" class="option-label">${filteredOption.optionName2}</span></button>`;
                    } else if(this.category == 2) {
                        categoriesContainer.empty();
                        optionHtml += `<button type="button" class="option-btn" data-index="${this.category}"><span data-index="${this.category}" class="option-label">${filteredOption.optionName3}</span></button>`;
                    }
                }
            }
            categoriesContainer.append(optionHtml);
        }
    }
    // 선택형 옵션, 조합형 옵션 이벤트
    this.optionBtn = function(paramThis) {
        this.$parent = this.myParent($(paramThis)); //선택한 옵션 제목 index

        const setOptionLength = itemSets.filter(set => set.item.itemOptionFlag == 'Y').length;
        switch (this.itemOptionType) {
            case 'S' :
                this.category = 0;
                break;
            case 'S2' :
            case 'S3' :
                this.category = $(paramThis).data("index"); //0:1차, 1:2차, 2:3차
                break;
        }
        const thisOptionValue = $(paramThis).find('.option-label').text().trim();
        if (this.isSet) {
            if (this.selectedOptions && this.selectedOptions.length > 0) {
                this.selectedOptions[this.category] = thisOptionValue;
            } else {
                let option = {
                    itemId : this.itemId,
                    selectedOptions : []
                };
                option.selectedOptions[this.category] = thisOptionValue;
                optionState.selectedOptions.push(option);
            }
        } else {
            optionState.selectedOptions[this.category] = thisOptionValue;
        }

        const finalOption = getFinalOption();

        this.dropdownArea.removeClass('active');

        if (finalOption) {
            if (this.isSet) {
                finalOption.itemId = this.itemId;
                rebaseSetOption(finalOption);
                const optionStateLength = optionState.setSelectedOptions.filter(option => option != "").length;
                if (optionStateLength == setOptionLength) {
                    if (validSetOption()) {
                        optionState.completedOptions.push(optionState.setSelectedOptions);

                        let optionContent = [];
                        for (let i = 0; i < itemSets.length; i++) {
                            let content = this.completedOptionText(optionState.setSelectedOptions.filter(option=>option.itemId == itemSets[i].item.itemId)[0], itemSets[i].item);
                            optionContent.push(content);
                        }
                        if (optionContent.length > 0) {
                            this.printCompletedOptions(optionContent);
                            this.calculate(this.$optionTop);
                            this.calculate(this.$optionBottom);
                            optionState.setSelectedOptions = [];
                        }
                    }
                }
            } else {
                //이미 구매 리스트로 등록되었는지 검사
                if (this.validOption(finalOption)) {
                    optionState.completedOptions.push(finalOption);
                    let content = this.completedOptionText(finalOption, ITEM);
                    if (content) {
                        this.printCompletedOptions(content);
                        this.calculate(this.$optionTop);
                        this.calculate(this.$optionBottom);
                    }
                }
            }
            this.selectedOptions = [];
            this.$parent.find(".option-dropdown").removeClass('active');
            this.initOption();
        } else {
            //다음 카테고리 아코디언 open
            if (this.itemOptionType == 'S2' || this.itemOptionType == 'S3') {
                this.category += 1;
                this.openOptionItems();
            }
        }

        function getFinalOption(){
            let finalOption = '';
            that.selectedOptions = that.isSet ? optionState.selectedOptions.filter(option => option.itemId == that.itemId)[0]?.selectedOptions : optionState.selectedOptions;
            const options = that.isSet ? itemSets.filter(set => set.item.itemId == that.itemId)[0]?.item?.itemOptions : itemOptions;
            if (that.itemOptionType == 'S2' && that.selectedOptions.length == 2) {
                finalOption = options.filter((option, index) => {
                    return (that.selectedOptions[0] == option.optionName1) && (that.selectedOptions[1] == option.optionName2);
                });
            } else if(that.itemOptionType == 'S3' && that.selectedOptions.length == 3) {
                finalOption = options.filter((option, index) => {
                    return (that.selectedOptions[0] == option.optionName1) && (that.selectedOptions[1] == option.optionName2) && (that.selectedOptions[2] == option.optionName3);
                });
            } else if(that.itemOptionType == 'S') {
                finalOption = options.filter((option, index) => {
                    return that.selectedOptions[0] == option.optionName2;
                });
            }
            if (finalOption.length == 0){
                return "";
            } else {
                return finalOption[0];
            }
        }
        // optionState.setSelectedOptions안에 finalOption 상품 id가 이미 존재할 경우 덮어씌우기
        function rebaseSetOption(finalOption) {
            let options = optionState.setSelectedOptions;
            for (let i = 0; i < optionState.setSelectedOptions.length; i++) {
                if (options[i] && options[i].itemId == finalOption.itemId) {
                    options[i] = "";
                    break;
                }
            }

            itemSets.forEach((el, i) => {
                if (el.item.itemId == finalOption.itemId) {
                    options[i] = finalOption;
                }
            });
        }
        // 이미 구매 리스트에 존재하는지 검사
        function validSetOption() {
            for (let i = 0; i < optionState.completedOptions.length; i++) {
                let k = 0;
                for (let j = 0; optionState.completedOptions[i] && j < optionState.completedOptions[i].length; j++) {
                    if (optionState.completedOptions[i][j] && optionState.setSelectedOptions[j]) {
                        if (optionState.completedOptions[i][j].itemOptionId == optionState.setSelectedOptions[j].itemOptionId) k++;
                    }
                }
                if (k == optionState.setSelectedOptions.filter(i => i != '').length) {
                    $saleson.core.alert("해당 상품은 이미 존재합니다.");
                    optionState.setSelectedOptions = [];
                    return false;
                }
            }
            return true;
        }
    }
    // 텍스트형 옵션 이벤트
    this.textOption = function(paramThis) {
        $parent = this.myParent($(paramThis));
        const textOptionElements = $parent.find(".text-option");

        let selectedOptions = [];

        let copiedOptions = JSON.parse(JSON.stringify(itemOptions));
        let i = 0;
        for (let option of copiedOptions) {
            let textOption = textOptionElements.eq(i).val().trim();
            if (textOption) {
                option.optionName2 = textOption;
            } else {
                $saleson.core.alert("모두 입력해주세요.");
                return;
            }

            selectedOptions.push(option);
            i++;
        };
        if (this.validOption(selectedOptions)) {
            optionState.completedOptions.push(selectedOptions);
            let optionText = this.completedOptionText(selectedOptions, ITEM);
            this.printCompletedOptions(optionText);
            let j = 0;
            //입력값 초기화
            copiedOptions.forEach((option, index) => {
                textOptionElements.eq(j).val("");
                j++;
            });
            this.calculate(this.$optionTop);
            this.calculate(this.$optionBottom);
        }
    }

    //이미 구매 리스트로 등록되었는지 검사
    this.validOption = function(finalOption) {

        if (optionState?.completedOptions?.length == 0) return true;
        let i = 0;
        for (option of optionState.completedOptions) {
            if (ITEM.itemOptionType == 'S2') {
                return !(option.optionName1 == finalOption.optionName1 && option.optionName2 == finalOption.optionName2);
            } else if (ITEM.itemOptionType == 'S3') {
                return !(option.optionName1 == finalOption.optionName1 && option.optionName2 == finalOption.optionName2 && option.optionName3 == finalOption.optionName3);
            } else if (ITEM.itemOptionType == 'S') {
                return !(option.optionName2 == finalOption.optionName2 && option.optionName1 == finalOption.optionName1);
            } else if (ITEM.itemOptionType == 'T') {
                if ( option && option.length > 0) {
                    let sameLength = 0;
                    for (let j = 0; j < option[i].length; j++) {
                        if (option[i][j].optionName2 == finalOption[j].optionName2 && option[i][j].optionName1 == finalOption[j].optionName1) {
                            sameLength++;
                            if (option[i].length == sameLength) return false;
                        }
                    }
                }
            }
        }
        return true;
    }
    this.completedOptionText = function(finalOption, item) {
        const optionType = item.itemOptionType;
        const optionTitle1 = item.itemOptionTitle1;
        const optionTitle2 = item.itemOptionTitle2;
        const optionTitle3 = item.itemOptionTitle3;
        let optionContent = "";
        if (item.itemOptionFlag == 'Y'){
            if (optionType == 'S3' || optionType == 'S2') {
                let categories = [optionTitle1, optionTitle2, optionTitle3];
                let names = [finalOption.optionName1, finalOption.optionName2, finalOption.optionName3];

                optionContent =
                    `
                        [${categories[0]}] : ${names[0]}
                        [${categories[1]}] : ${names[1]}
                        ${item.itemOptionType == 'S3' ? "["+ categories[2]+"] : " + names[2] : ""}
                        ${finalOption.optionPrice > 0 ? "(+"+finalOption.optionPrice+"원)" : "" } ${finalOption.isSoldOut == true ? "(품절)" : ""}
                    `;
                if (this.isSet) {
                    optionContent = item.itemName + " " + optionContent;
                }

            } else if (optionType == 'S'){
                optionContent = `
                    [${finalOption.optionName1}] : ${finalOption.optionName2}
                    ${finalOption.optionPrice > 0 ? "(+"+finalOption.optionPrice+"원)" : "" } ${finalOption.isSoldOut == true ? "(품절)" : ""}
                `;
                if (this.isSet) {
                    optionContent = item.itemName + " " + optionContent;
                }
            } else if (optionType == 'T') {

                for (let i = 0; i < finalOption.length; i++) {
                    optionContent += `
                        [${finalOption[i].optionName1}] : ${finalOption[i].optionName2}  
                    `;
                }
            }
        } else {
            optionContent =
                `
                        ${item.itemName} ${item.isSoldOut == true ? "(품절)" : ""}
                    `;
        }

        return optionContent;
    }
    this.printCompletedOptions = function(optionContent) {
        const optionContainer = $(".option-list-container");
        let optionIndex = optionState.completedOptions.length;

        if (optionContent) {
            //세트 옵션상품으로 세팅
            let template = "";
            if (Array.isArray(optionContent)) {
                for (let i = 0; i < optionContent.length; i++) {
                    template += ` 
                            <div class="item-list">
                                <!-- 아이템 상품 번호 -->
                                <div class="option-number">구성상품 ${i+1}</div>
                                <!-- 아이템 정보 영역 -->
                                <div class="info-container">
                                    <div class="title-main paragraph-ellipsis">
                                        ${optionContent[i]}
                                    </div>
                                </div>
                            </div>
                        `;
                }
            } else if (typeof optionContent === 'string') {
                template = ` 
                            <div class="item-list">
                                <!-- 아이템 상품 번호 -->
                                <div class="option-number">상품 ${optionIndex}</div>
                                <!-- 아이템 정보 영역 -->
                                <div class="info-container">
                                    <div class="title-main paragraph-ellipsis">
                                        ${optionContent}
                                    </div>
                                </div>
                            </div>
                        `;
            }
            optionHtml = htmlOptions(template, optionIndex);
            optionContainer.append(optionHtml);
        }
        function htmlOptions(optionContent, optionIndex) {
            const optionHtml = `
                    <li class="option-list">
                        <i class="btn-close" data-index="${optionIndex - 1}"></i>
                        <div class="item-list-container horizon">
                            <!-- 반복요소 item-list -->
                            ${optionContent}
                        </div>
                        <div class="option-price-wrap">
                            <div class="quantity-box">
                                <button type="button" class="btn-quantity btn-minus"></button>
                                <input type="number" title="수량" value="1" readonly maxlength="999"
                                       class="quantity number">
                                <button type="button" class="btn-quantity btn-plus"></button>
                            </div>
                            <div class="option-price">
                                <span class="option-price-value">0</span>
                                <span>원</span>
                            </div>
                
                        </div>
                    </li>
                `;
            return optionHtml;
        }
    }
    this.optionClose = function(paramThis) {
        const $parent = this.myParent($(paramThis));
        const index = $parent.find(".option-list .btn-close").index(paramThis);
        this.$optionTop.find(".option-list .btn-close").eq(index).parent().remove();
        this.$optionBottom.find(".option-list .btn-close").eq(index).parent().remove();

        optionState.completedOptions.splice(index, 1);
        this.calculate(this.$optionTop);
        this.calculate(this.$optionBottom);
    }
    // 가격계산
    this.calculate = function($parent) {
        let itemPrice = ITEM.presentPrice;
        if ($.trim(itemPrice) == '') {
            return;
        }

        let totalItemPrice = 0;
        let totalOptionPrice = 0;
        let totalItemCount = 0;
        let totalQuantity = 0;

        let $quantity = $parent.find('.quantity');
        let $optionList = $parent.find(".option-list");

        if (this.isSet) {
            let quantity = 0;
            if (ITEM.itemOptionFlag == 'Y') {
                for (let i = 0; i < optionState.completedOptions.length; i++) {
                    quantity = Number($quantity.eq(i).val());
                    totalQuantity += quantity;
                    let nOptionPrice = 0;
                    for (let j = 0; j < itemSets.length; j++) {
                        if (itemSets[j].item.itemOptionFlag == 'Y') {
                            if (optionState.completedOptions[i][j]) {
                                nOptionPrice += Number(itemSets[j].quantity) * quantity * Number(optionState.completedOptions[i][j].optionPrice);
                            }
                        }
                    }
                    $optionList.eq(i).find(".option-price-value").text($saleson.core.formatNumber(itemPrice * quantity + nOptionPrice))
                    totalOptionPrice += nOptionPrice;
                }
            } else {
                totalQuantity = Number($quantity.eq(0).val());
            }

            totalItemPrice = itemPrice * totalQuantity + totalOptionPrice;
        } else {
            if (ITEM.itemOptionFlag == 'Y') {
                $parent.find(".option-list").each(function(i, element) {
                    let quantity = $(this).find('.quantity').val();
                    let extraPrice = optionState?.completedOptions[i]?.optionPrice ?? 0;

                    quantity = $.trim(quantity) == '' ? 0 : Number(quantity);

                    let optionPrice = ITEM.itemOptionType == 'T' ? Number(itemPrice) * quantity : (Number(itemPrice) + Number(extraPrice)) * quantity;
                    totalItemPrice += optionPrice;
                    totalItemCount += quantity;

                    $(element).find('.option-price-value').text($saleson.core.formatNumber(optionPrice));
                });
            } else {
                if ($quantity.length > 0) {
                    totalItemPrice = itemPrice * Number($quantity.val());
                }
            }
        }

        const totalAmount = $saleson.core.formatNumber(totalItemPrice);
        $('.total-amount').text(totalAmount);
        $(".total-price").show();
    }
    this.plusAction = function(paramThis) {
        let $parent = this.myParent($(paramThis));
        const index = $parent.find(".btn-plus").index(paramThis);
        let $quantity =  $parent.find(".quantity").eq(index);
        let quantity = Number($quantity.val());
        let addedQuantity = quantity + 1;

        if (this.isSet) {
            const plusIndex = ITEM.itemOptionFlag == "Y" ? index : 0;
            //재고 수량 검사
            if (!this.checkSetStock(plusIndex, $parent)) {
                return false;
            }
        } else {
            if (ITEM.itemOptionFlag != 'Y') {

                if (addedQuantity > ITEM.orderMaxQuantity) {
                    $saleson.core.alert('해당 상품의 최대 구매 수량은 ' + ITEM.orderMaxQuantity + '개 입니다.');
                    return;
                }

                // 재고 체크
                if (ITEM.stockFlag == 'Y' && addedQuantity > ITEM.stockQuantity) {
                    $saleson.core.alert('해당 상품의 최대 구매 수량은 ' + ITEM.stockQuantity + '개 입니다.');
                    return;
                }

            } else {
                const optionQuantities = $parent.find(".quantity");
                let optionQuantitiesSum = 0;
                optionQuantities.each((index, element) => {
                    optionQuantitiesSum += $(element).val();
                });

                if (optionQuantitiesSum == ITEM.orderMaxQuantity) {
                    $saleson.core.alert('해당 상품의 최대 구매 수량은 ' + ITEM.orderMaxQuantity + '개 입니다.');
                    return;
                }
                //const category = $(this).closest(".option-list").index();
                thisOptionInfo = optionState.completedOptions[index];
                if (thisOptionInfo.optionStockQuantity == 'Y') {
                    if (quantity >= thisOptionInfo.optionStockQuantity) {
                        $saleson.core.alert('해당 상품의 최대 구매 수량은 ' + thisOptionInfo.optionStockQuantity + '개 입니다.');
                        return;
                    }
                }
            }
        }

        this.$optionTop.find(".quantity").eq(index).val(addedQuantity);
        this.$optionBottom.find(".quantity").eq(index).val(addedQuantity);
        this.calculate(this.$optionTop);
        this.calculate(this.$optionBottom);
    }
    this.minusAction = function(paramThis) {
        $parent = this.myParent($(paramThis));
        const index = $parent.find(".btn-plus").index(paramThis);
        let $quantity =  $parent.find(".quantity").eq(index);
        let quantity = Number($quantity.val());
        let minusQuantity = quantity - 1;
        if (minusQuantity < 1 || minusQuantity < ITEM.orderMinQuantity) {
            $saleson.core.alert('해당 상품의 최소 구매 수량은 ' + ITEM.orderMinQuantity + "개 입니다.");
            return;
        }

        this.$optionTop.find(".quantity").eq(index).val(minusQuantity);
        this.$optionBottom.find(".quantity").eq(index).val(minusQuantity);
        this.calculate(this.$optionTop);
        this.calculate(this.$optionBottom);
    }
    // 장바구니 담기.
    this.addToCart = function(paramThis){
        $parent = this.myParent($(paramThis));
        // 장바구니에 담을 수 있는 지 확인한다.
        if (!this.checkForItem('cart', $parent)) {
            return;
        }

        let param = {};
        param = this.makeFormData(param, $parent);

        const that = this;
        $saleson.api.post('/api/cart/add', param)
        .then(function (response){
            that.clearSelectInformation();
            try {
                $saleson.analytics.addToCart(param);
            } catch (e) {}

            try {
                $saleson.api.get('/api/common/cart-info')
                .then((response) => {
                    const data = response.data;
                    $('#header-cart-quantity').text($saleson.core.formatNumber(data.cartQuantity));
                });
            } catch (e) {}

            $saleson.core.confirm("장바구니에 상품을 담았습니다.\n바로 확인하시겠습니까?", () => {
                $saleson.core.redirect("/cart");
            });
        }).catch(function(error) {
            $saleson.core.api.handleApiExeption(error);
        });
    }
    // 바로구매
    this.buyNow = function(paramThis) {
        let isLogin = $('#isLogin').val();
        let url ;
        $parent = this.myParent($(paramThis));
        // 바로구매가 가능한 지 확인한다.
        if (!this.checkForItem('buy_now', $parent)) {
            return;
        }
        let param = {};
        param = this.makeFormData(param, $parent);

        $saleson.api.post('/api/order/buy', param)
        .then(function (response){
            url = isLogin == 'true' ? '/order/step1' : '/order/no-member';
            $saleson.core.redirect(url);
        }).catch(function(error) {
            $saleson.core.api.handleApiExeption(error);
        });
    }
    // 장바구니/바로구매 가능한지 확인한다.
    this.checkForItem = function(target, $parent) {

        if (!(target === 'cart' || target === 'buy_now' || target === 'wishlist' || target === 'naver_wishlist')) {
            $saleson.core.alert('처리할 수 없습니다.');
            return false;
        }

        let stockFlag = ITEM.stockFlag;
        let stockQuantity = ITEM.stockQuantity;
        let orderMinQuantity = ITEM.orderMinQuantity;
        let orderMaxQuantity = ITEM.orderMaxQuantity;

        // 품절 확인.
        if (ITEM.isItemSoldOut) {
            $saleson.core.alert('해당 상품은 판매 종료 되었습니다.');
            return false;
        }

        // 비회원 구매 불가인 경우 로그인 페이지로 이동
        if (!this.checkForNonmemberOrder()) {
            return false;
        }

        if (target == 'wishlist' || target == 'naver_wishlist') {
            return true;
        }

        // 장바구니 체크
        const $quantity = $('.quantity');

        if (ITEM.isSet) {
            if (ITEM.itemOptionFlag == 'Y') {

                if (optionState.completedOptions.length == 0) {
                    $saleson.core.alert('옵션 추가 버튼을 눌러 옵션을 추가해주세요.');
                    return false;
                }
            }
            if (!this.checkSetStock(-1, $parent)) {
                return false;
            }
        } else {
            if (ITEM.itemOptionFlag == 'N') {

                // 상품 최소 수량 체크
                if ($quantity.val() < orderMinQuantity) {
                    $saleson.core.alert('해당 상품의 최소 구매 수량은 ' + orderMinQuantity + "개 입니다.");
                    $quantity.val(orderMinQuantity);
                    return false;
                }

                // 상품 최대 수량 체크
                if ($quantity.val() > orderMaxQuantity) {
                    $saleson.core.alert('해당 상품의 최대 구매 수량은 ' + orderMaxQuantity + "개 입니다.");
                    $quantity.val(orderMaxQuantity);
                    return false;
                }

                // 상품 재고 체크
                if (stockFlag == 'Y' && $quantity.val() > stockQuantity) {
                    $saleson.core.alert('해당 상품의 최대 구매 수량은 ' + stockQuantity + '개 입니다.');
                    $quantity.val(stockQuantity);
                    return false;
                }

            } else {
                // 옵션
                if (!optionState.completedOptions || optionState.completedOptions.length == 0) {
                    if (ITEM.itemOptionType == 'T') {
                        $saleson.core.alert('텍스트 옵션값을 입력 후 옵션 추가 버튼을 눌러 옵션을 추가해주세요.');
                    } else if(ITEM.itemOptionType == 'S2' || ITEM.itemOptionType == 'S3' || ITEM.itemOptionType == 'S') {
                        $saleson.core.alert('옵션 추가 버튼을 눌러 옵션을 추가해주세요.');
                    }
                    return false;
                }

            }
        }

        // 추가 구성 상품.
        // var $addedItems = $('.added-items li');
        // $addedItems.each(function(index) {
        //     var additionData = $(this).data('item-id') + '||' + $(this).find('.option-quantity').val() + '||' ;
        //
        //     $('input[name=arrayAdditionItems]').eq(index).val(additionData);
        // });

        return true;
    }

    //세트 재고 검사
    //추가할 수량이 없으면 plusIndex = -1
    this.checkSetStock = function(plusIndex, parent) {
        const $quantities = parent.find(".quantity");
        if (ITEM.itemOptionFlag == 'Y') {
            let accmulatedQuantities = [];
            for (let i = 0; i < optionState.completedOptions.length; i++) {
                let nQuantity = Number($quantities.eq(i).val());
                nQuantity = i == plusIndex ? nQuantity + 1 : nQuantity;

                for (let j = 0; j < itemSets.length; j++) {
                    let q = accmulatedQuantities[j] ?? 0;
                    accmulatedQuantities[j] = q + itemSets[j].quantity * nQuantity;
                }
            }
            for (let j = 0; j < itemSets.length; j++) {
                if (accmulatedQuantities[j] > itemSets[j].item.stockQuantity) {
                    $saleson.core.alert(itemSets[j].item.itemName + " 상품은 재고수량이 " + itemSets[j].item.stockQuantity + "입니다.");
                    return false;
                }
            }
        } else {
            let quantity = Number($quantities.eq(plusIndex).val());
            quantity = plusIndex < 0 ? quantity : quantity + 1;
            if (!this.checkCommonSetStock(quantity)) return false;
        }

        return true;
    }
    // 비회원 구매 가능 상품 체크.
    // 비회원 구매 불가인 경우 로그인 페이지로 이동
    this.checkForNonmemberOrder = function() {

        let nonmemberOrderType = ITEM.nonmemberOrderType;

        if (!($saleson.auth.loggedIn() || nonmemberOrderType == '1')) {
            const message = "회원만 구매가 가능합니다. \n 로그인 페이지로 이동하시겠습니까?";
            $saleson.core.confirm(message, () => {
                const target = $saleson.core.requestContext.requestUri;
                $saleson.core.redirect($saleson.const.pages.LOGIN + '?target=' + target);
            })

            return false;
        } else {
            return true;
        }
    }
    this.checkCommonSetStock = function (quantity) {
        for (let j = 0; j < itemSets.length; j++) {
            // 옵션 수량 * 세트 기본 수량
            if (itemSets[j].quantity * quantity > itemSets[j].item.stockQuantity) {
                $saleson.core.alert(itemSets[j].item.itemName + " 상품은 재고수량이 " + itemSets[j].item.stockQuantity + "입니다.");
                return false;
            }
        }
        return true;
    }
    this.makeFormData = function(param, $parent) {
        if (ITEM.itemType == '3') {
            param = {
                itemSets : []
            };
            $quantity = $parent.find(".quantity");
            if (ITEM.itemOptionFlag == 'Y') {
                for (let i = 0; i < optionState.completedOptions.length; i++) {
                    let setInfo = {
                        itemId : ITEM.itemId,
                        quantity : $quantity.eq(i).val(),
                        arrayItemSets: []
                    };

                    for (let j = 0; j < itemSets.length; j++) {
                        let itemOptionId = itemSets[j].item.itemOptionFlag == "Y" ? optionState.completedOptions[i][j].itemOptionId + "```" : "";
                        let data = itemSets[j].item.itemId + "||" + itemSets[j].quantity + "||" + itemOptionId;
                        setInfo.arrayItemSets.push(data);
                    }
                    param.itemSets.push(setInfo);
                }
            } else {
                let setInfo = {
                    itemId : ITEM.itemId,
                    quantity : $quantity.eq(0).val(),
                    arrayItemSets: []
                };
                for (let i = 0; i < itemSets.length; i++) {
                    let data = itemSets[i].item.itemId + "||" + itemSets[i].quantity + "||";
                    setInfo.arrayItemSets.push(data);
                }
                param.itemSets.push(setInfo);
            }
        } else {
            let $quantity = $parent.find(".quantity");
            let itemId = ITEM.itemId;
            if (ITEM.itemOptionFlag == 'Y') {
                if (ITEM.itemOptionType == 'S' || ITEM.itemOptionType == 'S2' || ITEM.itemOptionType == 'S3') {
                    let optionValues = [];
                    optionState.completedOptions.forEach((option, i)=>{
                        let values = itemId + "||" + $quantity.eq(i).val() + "||" + option.itemOptionId + "```";
                        optionValues.push(values);
                    });
                    param = {'arrayRequiredItems' : optionValues};
                } else if (ITEM.itemOptionType == 'T') {
                    let optionValues = [];
                    let i = 0;
                    for (let completedOption of optionState.completedOptions) {
                        let optionSub = [];
                        for (let optioin of completedOption) {
                            let optionId = optioin.itemOptionId;
                            let textValue = optioin.optionName2;
                            optionSub.push(optionId + '```' + textValue);
                        }
                        optionValues.push(itemId + "||" + $quantity.eq(i).val() + "||" + optionSub.join("^^^"));
                        i++;
                    };
                    param = {'arrayRequiredItems' : optionValues};
                }
            } else {
                param = {
                    'arrayRequiredItems' : [itemId + "||" + $quantity.eq(0).val() + "||"]
                };
            }
        }

        return param;
    }
    // 선택정보 초기화
    this.clearSelectInformation = function() {

        $('#cart-item').empty();

        if (ITEM.itemOptionFlag === 'N') {
            let defaultQuantity = 1;
            $('.quantity').val(defaultQuantity);

            if (ITEM.orderMinQuantity > 0 ) {
                $('.quantity').val(ITEM.orderMinQuantity);
            }
        }

        this.calculate(this.$optionTop);
        this.calculate(this.$optionBottom);
    }

    this.initOption = function(){
        //선택된 옵션 생성
        optionState.selectedOptions = [];
        $(".dropdown-area").removeClass('active');
    }
    this.myParent = function($this) {
        return $this.closest(".option-top").length == 0 ? this.$optionBottom : this.$optionTop;
    }


}