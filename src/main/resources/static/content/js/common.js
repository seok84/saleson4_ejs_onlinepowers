var salesOnUI = salesOnUI || {};
salesOnUI = {
	init: function () {
		//this.loadTimeOut = function() {};
		//this.fileRegist = 0;
		salesOnUI.headerScrollEvent();
		//salesOnUI.topBanner();
		salesOnUI.gnb();
		salesOnUI.mGnb();
		salesOnUI.searching();
		salesOnUI.aside();
		salesOnUI.modal();
		salesOnUI.toast();
	},

	// header scroll fixed
	headerScrollEvent: function (target) {
		let variable = {
			body: $("body"),
			fixedHeader: $(".fixed-header"),
			btnGnb: $("#header .btn-gnb"),
		};

		let initTop = 0;

		$(window).on("scroll", function (e) {
			let scrollInitPos = $('#header .gnb').offset().top;
	
			console.log('variable Height :: ', scrollInitPos)
			
			if (window.scrollY > scrollInitPos) {
				variable.fixedHeader.addClass("scroll");
				variable.fixedHeader.removeClass("on");
			} else {
				variable.fixedHeader.removeClass("scroll");
			}
			
			/*
            let curScrollPos = window.scrollY;

            if (curScrollPos > initTop) {
                //console.log('scroll down!')
                $('.fixed-header').addClass('scroll')
            } else {
                //console.log('scroll up!')
                $('.fixed-header').removeClass('scroll')
            }
            initTop = curScrollPos;
            */
			//console.log('initTop :: ', initTop)
			//console.log('curScrollPos :: ', curScrollPos)
		});

		variable.btnGnb.on("click", function (e) {
			e.preventDefault();
			$(".fixed-header").toggleClass("on");
		});
	},

	// topBanner
	topBanner: function () {
		//console.log('top banner init!')
		let className = {
			topBanner: $("#top-banner"),
			topBannerclose: $("#top-banner .top-banner-close"),
		};
		className.topBannerclose.on("click", function (e) {
			e.preventDefault();
			console.log("top banner init!");
			className.topBanner.parent().toggleClass("hide-banner");
		});
	},

	// gnb
	gnb: function () {
		//console.log('gnb init')

		let className = {
			gnb: $("#header .gnb"),
			gnbItem: $("#header .menu-item"),
			gnbType2: $("#header .gnb.type-2"),
			gnbType2Item: $("#header .gnb.type-2 .menu-item"),
			depth2: $("#header .depth2"),
			depth2Item: $("#header .depth2 > ul > li"),
			depth3: $("#header .depth3"),
			depth3Item: $("#header .depth3-menu"),
			depth4: $("#header .depth4"),
			depth4Item: $("#header .depth4-menu"),
		};

		// depth2
		className.gnbItem.on("mouseenter", function (e) {
			e.preventDefault();
			className.gnbItem.removeClass("on");
			className.depth2.removeClass("on");
			$(this).addClass("on");
			$(this).children(".depth2").addClass("on");
		});

		// depth3
		className.depth2Item.on("mouseenter", function (e) {
			e.preventDefault();
			className.depth2Item.removeClass("on");
			if ($(this).find(".depth3").length > 0) {
				$(this).addClass("on");
			}
		});

		// depth4
		className.depth3Item.on("mouseenter", function (e) {
			e.preventDefault();
			className.depth3Item.removeClass("on");
			if ($(this).find(".depth4").length > 0) {
				$(this).addClass("on");
			}
		});

		// gnb close
		className.gnb.on("mouseleave", function (e) {
			e.preventDefault();
			className.gnbItem.removeClass("on");
			className.depth2.removeClass("on");
			className.depth2Item.removeClass("on");
			className.depth3Item.removeClass("on");
		});

		className.depth2Item.on("mouseleave", function (e) {
			e.preventDefault();
			className.depth2Item.removeClass("on");
		});

		className.depth3Item.on("mouseleave", function (e) {
			e.preventDefault();
			className.depth3Item.removeClass("on");
		});

		if (className.gnb.hasClass('type-2')) {
			className.gnbType2Item.on("mouseenter", function (e) {
				e.preventDefault();
				$(this).parent().next('.depth2').addClass('on');
			});
			className.gnbType2.on("mouseleave", function (e) {
				e.preventDefault();
				$(this).parent().next('.depth2').removeClass('on');
			});
		}


	},

	// mobile gnb
	mGnb: function () {
		//console.log('gnb init')
		let className = {
			mCategoryOpen: $(".m-category-open"),
			mGnbWrap: $(".m-gnb-wrap"),
			mCategoryClose: $(".m-gnb-close"),
			menuItem: $(".m-gnb .depth1 .menu-item"),
			mGnbDepth2: $(".m-gnb .depth2 > ul"),
			mGnbSubmenuItem: $(".m-gnb .depth2 .submenu-item"),
			mGnbDepth3: $(".m-gnb .depth3"),
		};

		// mobile gnb open
		className.mCategoryOpen.on("click", function (e) {
			e.preventDefault();
			className.mGnbWrap.addClass("on");
			className.menuItem.eq(0).addClass("on");
			className.mGnbDepth2.eq(0).addClass("on");
			className.mGnbSubmenuItem.eq(0).addClass("on");
		});

		// mobile gnb close
		className.mCategoryClose.on("click", function (e) {
			e.preventDefault();
			className.mGnbWrap.removeClass("on");
		});

		className.menuItem.on("click", function (e) {
			e.preventDefault();
			let menuItemIdx = $(this).index();
			//console.log('menuItemIdx :: ', menuItemIdx)
			$(this).addClass("on").siblings().removeClass("on");
			className.mGnbDepth2.eq(menuItemIdx).addClass("on").siblings().removeClass("on");
		});

		className.mGnbSubmenuItem.on("click", function (e) {
			e.preventDefault();
			className.mGnbSubmenuItem.removeClass("on");
			className.mGnbDepth3.removeClass("on");
			$(this).addClass("on");
			if ($(this).next(".depth3").length > 0) {
				$(this).next(".depth3").addClass("on");
			}
		});
	},

	mGnbSwiper: function () {
		let windowWidth = window.innerWidth;
		const linkAreaSwiperOption = {
			slidesPerView: "auto",
			spaceBetween: 18,
			loop: false,
			freeMode: true,
			clickable: true,
		};
		let linkAreaSwiper = undefined;

		function initialSwiper() {
			if (windowWidth < 767 && linkAreaSwiper == undefined) {
				linkAreaSwiper = new Swiper("#header .link-area", linkAreaSwiperOption);
			} else if (windowWidth >= 767 && linkAreaSwiper != undefined) {
				linkAreaSwiper.destroy();
				linkAreaSwiper = undefined;
			}
		}

		initialSwiper();

		$(window).on("resize", function () {
			windowWidth = $(window).width();
			initialSwiper();
		});
	},

	searching: function () {
		//console.log('searching init!!')
		let className = {
			body: $("body"),
			header: $("#header"),
			searchingArea: $("#header .searching-area"),
			searchingInput: $("#header .searching-area input[type=search]"),
			searchingList: $("#header .searching-list"),
			searchingMobileBtn: $("#header .mobile-search-open"),
			searchingListCloseBtn: $("#header .searching-list-close"),
			searchingListMobileCloseBtn: $("#header .searching-area .btn-close"),
			mSearchingBtn: $(".m-category-menu .m-searching"),
		};

		// searching-list pc open
		className.searchingInput.on("focus", function (e) {
			e.preventDefault();
			if (className.searchingList.hasClass("hidden")) {
				className.searchingList.removeClass("hidden");
			}
		});

		// searching-list mobile open
		className.searchingMobileBtn.on("click", function (e) {
			e.preventDefault();
			mobileSearchingOpen();
		});

		// searching-list close pc
		className.searchingListCloseBtn.on("click", function (e) {
			console.log("mobile searching close");
			className.searchingList.addClass("hidden");
			className.body.removeClass("scroll-fixed");
			className.header.removeClass("mobile-search-active");
		});

		// searching-list close mobile
		className.searchingListMobileCloseBtn.on("click", function (e) {
			console.log("mobile searching close");
			className.searchingList.addClass("hidden");
			className.body.removeClass("scroll-fixed");
			className.header.removeClass("mobile-search-active");
		});

		className.mSearchingBtn.on("click", function (e) {
			e.preventDefault();
			mobileSearchingOpen();
		});

		function mobileSearchingOpen() {
			className.body.addClass("scroll-fixed");
			className.header.addClass("mobile-search-active");
			className.searchingList.removeClass("hidden");
		}
	},

	// aside menu
	aside: function () {
		let className = {
			asideMenu: $("#aside-menu"),
			asideMenuToggleArea: $("#aside-menu .toggle-area"),
			asideMenuToggleBtn: $("#aside-menu .btn-toggle"),
			btnTop: $("#aside-menu .btn-top"),
		};

		className.asideMenuToggleBtn.on("click", function (e) {
			e.preventDefault();
			if (className.asideMenuToggleArea.hasClass("on")) {
				className.asideMenuToggleArea.removeClass("on");
				className.asideMenuToggleBtn.text("열기");
			} else {
				className.asideMenuToggleArea.addClass("on");
				className.asideMenuToggleBtn.text("접기");
			}
		});

		className.btnTop.on("click", function (e) {
			e.preventDefault();
			$("html, body").stop().animate(
				{
					scrollTop: 0,
				},
				500
			);
		});
	},

	// modal
	modal: function (target) {
		let className = {
			body: $("body"),
			modalBg: $(".modal .dimmed-bg"),
			modal: $(".modal"),
			modalOpen: $("[data-modal]"),
			modalClose: $("[data-dismiss]"),
		};

		//console.log('0. target:: ', target)

		className.modalOpen.on("click", function (e) {
			e.preventDefault();
			modalShow();
		});

		className.modalClose.on("click", function (e) {
			e.preventDefault();
			modalDismiss();
		});

		function modalShow(target) {
			modalDismiss();
			console.log("1. target :: ", target);
			className.body.css("overflow", "hidden");
			if ($(target).length > 0) {
				console.log("2. target :: ", target);
				$(target).addClass("show");
			} else {
				console.log("3. target :: ", target);
				if (target == ".address-modal") {
					console.log("address modal open!");
					modalDismiss(target);
				} else {
					className.modal.addClass("show");
				}
			}
		}

		function modalDismiss(target) {
			if ($(target).length > 0) {
				console.log("target :: ", target);
				if ($(target).hasClass("show")) {
					$(target).removeClass("show");
					className.body.css("overflow", "");
				}
			} else {
				className.body.css("overflow", "");
				className.modal.removeClass("show");
			}
		}

		return {
			show: modalShow,
			dismiss: modalDismiss,
		};
	},

	// toast
	toast: function (target) {
		let className = {
			toastClose: $('[data-dismiss="toast"]'),
		};

		// toast close button event
		className.toastClose.on("click", function (e) {
			e.preventDefault();
			$(this).parent().parent().removeClass("show");
		});

		// toast open function
		function toastOpen(target) {
			$(target).addClass("show");
		}
	},

	// toggle
	toggleActive: function (target, goal) {
		$(target).on("click", function (e) {
			e.preventDefault();
			if ($(goal).length > 0) {
				//console.log('goal ::', goal)
				$(this).parent().toggleClass("active");
			} else {
				if ($(this).next().hasClass("brand-container")) {
					$(".brand-container").toggle();
				} else {
					$(this).toggleClass("active");
				}
			}
		});
	},
	toggleDropdownActive: function (target) {
		let className = {
			optionDropdown: $(".option-dropdown"),
			dropdownTitle: $(".dropdown-title"),
			selectWrap: $(".option-contents > .select-wrap"),
			optionTitle: $(".option-title"),
		};

		className.optionDropdown.children(".dropdown-title").on("click", function (e) {
			e.preventDefault();
			$(this).parent().addClass("active");
		});

		className.selectWrap.on("click", function (e) {
			e.preventDefault();
			className.optionDropdown.removeClass("active");
		});

		className.optionTitle.on("click", function (e) {
			e.preventDefault();
			$(this).parent().toggleClass("active");
		});
	},
	toggleCoupon: function (target) {
		$(target).toggleClass("show");
	},
	toggleFocus: function (target) {
		let displayValue = $(target).is(":checked") ? "block" : "none";
		$(target).parent().closest(".form-line").toggleClass("hidden");
	},
	toggleTerms: function (target) {
		let className = {
			toggleTerms: $(".toggle-terms"),
		};

		className.toggleTerms.on("click", function (e) {
			e.preventDefault();
			$(this).parent().toggleClass('active')
			$(this).next(".toggle-content").slideToggle(50);
		});
	},
	toggleHidden: function (target, goal) {
		$(target).on("click", function (e) {
			e.preventDefault();
			$(goal).toggleClass("hidden");
		});
	},
	toggleOn: function (target) {
		$(target).toggleClass("on");
	},

	// tooltip
	tooltip: function (target) {
		let className = {
			tooltip: $(".tooltip"),
			tooltipWrap: $(".tooltip-wrap"),
			dimmedBg: $(".tooltip-wrap .dimmed-bg"),
			tooltipClose: $("[data-dismiss-tooltip]"),
		};

		//console.log(target)

		if ($(target).length > 0) {
			$(target).on("click", function (e) {
				$(target).parent().find(".tooltip-wrap").addClass("active");
			});
		}

		className.dimmedBg.on("click", function (e) {
			e.preventDefault();
			$(this).closest(".tooltip-wrap").removeClass("active");
		});

		className.tooltipClose.on("click", function (e) {
			e.preventDefault();
			$(this).closest(".tooltip-wrap").removeClass("active");
		});
	},

	// swich button
	swichBtn: function () {
		let className = {
			switchBtn: $(".switch-btn"),
		};

		className.switchBtn.on("click", function (e) {
			e.preventDefault();
			// className.switchBtn.removeClass('active');
			$(this).addClass("active");
		});
	},

	// select
	selectBox: function (target, goal) {
		let className = {
			inputSelect: $(".input-select"),
		};
		className.inputSelect.on("click", function (e) {
			e.preventDefault();
			if ($(this).next(".select-option").hasClass("hidden")) {
				$(this).next(".select-option").removeClass("hidden");
			} else {
				$(this).next(".select-option").addClass("hidden");
			}
		});

		if ($(goal).length > 0) {
			$(target).on("click", function (e) {
				e.preventDefault();
				if ($(goal).hasClass("on")) {
					$(goal).removeClass("on");
					$(this).next(".select-wrap").addClass("hidden");
				} else {
					$(goal).addClass("on");
					$(this).next(".select-wrap").removeClass("hidden");
				}
			});
		} else {
			$(target).on("click", function (e) {
				e.preventDefault();
				if ($(this).hasClass("on")) {
					$(this).removeClass("on");
					$(this).next(".select-wrap").addClass("hidden");
				} else {
					$(this).addClass("on");
					$(this).next(".select-wrap").removeClass("hidden");
				}
			});
		}
	},

	// cart, order scroll fixed
	scrollEvent: function (target) {
		let variable = {
			target: $(target),
			targetTop: $(target).offset().top,
			targetH: $(target).outerHeight(),
			titleTop: $(".title-h1").offset().top,
			floatingAside: $(".floating-aside"),
			asideH: $(target).find(".floating-aside").outerHeight(),
			windowH: window.innerHeight,
			noContent: $(target).find(".no-contents"),
			footerTop: $("footer").offset().top,
		};

		let fixedFalsePos, offsetPos;
		if (variable.noContent.length <= 0) {
			// console.log('scroll event true!');
			$(window).on("scroll", function (e) {

				if (variable.windowH < variable.targetH) {

					if (variable.titleTop < window.scrollY) {
						
						fixedFalsePos = variable.footerTop - variable.asideH - variable.titleTop;
						offsetPos = $("footer").offset().top - variable.asideH - 127;

						console.log('scroll event true!', offsetPos);
						
						variable.target.addClass("active");

						if (offsetPos < window.scrollY) {
							variable.target.addClass("offset");
							variable.floatingAside.css("top", offsetPos);
						} else {
							variable.target.removeClass("offset");
							variable.floatingAside.attr("style", "");
						}
					} else {
						variable.target.removeClass("active");
					}
				}
			});
		}
	},

	// items detail scroll
	itemDetailScroll: function (target) {
		let variable = {
			target: $(target),
			contentLeft: $(".contents-left"),
			contentRight: $(".contents-right"),
			detailContentsArea: $(".detail-contents-area"),
			targetContent: $(".select-option-container"),
			headerH: $("#header .flex").outerHeight(),
			tabs: $(".tabs"),
			tabsTop: $(".tabs").offset().top,
			tabItem: $(".tabs .tab-item"),
			tabContent: $(".detail-contents-area .tabs-content"),
		};

		$(document).on("scroll", scrollFixed);

		//smoothscroll
		variable.tabItem.on("click", function (e) {
			e.preventDefault();
			$(document).off("scroll");

			variable.tabItem.each(function () {
				$(this).removeClass("active");
			});

			$(this).addClass("active");

			let target = $(this).data("target");
			let $target = $("." + target);

			let offsetPos = $("#footer").offset().top - $(window).innerHeight() - $("#header").outerHeight();

			if (variable.tabItem.length - 1 == $(this).index() && variable.tabContent.last().offset().top > offsetPos) {
				//console.log('last top :: ', variable.tabContent.last().offset().top)
				//console.log($('#footer').offset().top - $(window).innerHeight() - $('#header').outerHeight())

				variable.detailContentsArea.addClass("active offset");
				variable.contentRight.css({ height: $(".contents-left").outerHeight() });
			}

			$("html, body")
				.stop()
				.animate(
					{
						scrollTop: $target.offset().top + 1,
					},
					400,
					"swing",
					function () {
						$(document).on("scroll", scrollFixed);
						$("html, body").animate({ scrollTop: $target.offset().top + 1 });
					}
				);
		});

		function scrollFixed(e) {
			let scrollPos = $(document).scrollTop();
			if (variable.detailContentsArea.offset().top - variable.headerH < scrollPos) {
				variable.target.addClass("active");

				let offsetPos = $("#footer").offset().top - $(window).innerHeight() - $("#header").outerHeight();

				if (offsetPos < scrollPos) {
					//console.log('offset true!')
					variable.target.addClass("offset");
					variable.contentRight.css({ height: $(".contents-left").outerHeight() });
				} else {
					variable.contentRight.attr("style", "");
					variable.target.removeClass("offset");

					let contHArr = [];

					variable.tabContent.each(function () {
						contHArr.push($(this).offset().top);
					});

					for (let i = contHArr.length; i >= 0; --i) {
						if (contHArr[i] < scrollPos) {
							variable.tabItem.eq(i).addClass("active").siblings().removeClass("active");
							return;
						}
					}
				}
			} else {
				variable.target.removeClass("active");
				variable.contentRight.attr("style", "");
				variable.target.removeClass("offset");
			}
		}
	},

	// items detail mobile option modal
	itemOptionEvent: function () {
		let className = {
			selectOptionContainer: $(".select-option-container"),
			btnOptionOpen: $(".select-option-container .btn-option-open"),
			dimmedBg: $(".select-option-container .dimmed-bg"),
		};

		className.btnOptionOpen.on("click", function (e) {
			e.preventDefault();
			className.selectOptionContainer.addClass("active");
			className.btnOptionOpen.css("display", "none");
		});

		className.dimmedBg.on("click", function (e) {
			e.preventDefault();
			className.selectOptionContainer.removeClass("active");
			className.btnOptionOpen.css("display", "block");
		});
	},

	// tab click ui
	tabs: function () {
		let className = {
			tabItem: $(".tab-item"),
			tabContent: $(".tabs-content"),
		};

		className.tabItem.on("click", function (e) {
			e.preventDefault();

			if ($(this).data("target").length > 0) {
				let tabData = $(this).data("target");
				$(this).addClass("active").siblings().removeClass("active");
				className.tabContent.addClass("hidden");
				//console.log('.' + tabData)
				$("." + tabData).removeClass("hidden");
			} else {
				//console.log('index')
				let tabIdx = $(this).index();
				//console.log('tab index', tabIdx)
				$(this).addClass("active").siblings().removeClass("active");
				className.tabContent.addClass("hidden");
				className.tabContent.eq(tabIdx).removeClass("hidden");
			}
		});
	},

	// main swiper ui
	mainVisualSwiper: function () {
		let className = {
			mainSwiperPc: $(".main-visual.pc"),
			mainSwiperPauseBtn: $(".main-visual.pc .main-swiper-pagination-wrap > button"),
			mMainSwiperPauseBtn: $(".main-visual.mobile .main-swiper-pagination-wrap > button"),
		};

		// visual swiper
		const visualSwiperOption = {
			slidesPerView: "1",
			loop: true,
			centeredSlides: true,
			autoplay: {
				delay: 2500,
				disableOnInteraction: false,
			},
			pagination: {
				clickable: true,
				el: ".main-swiper-pagination",
				type: "custom",
				renderCustom: function (swiper, current, total) {
					return current + " - " + total;
				},
			},
			navigation: {
				enabled: true,
				prevEl: ".main-visual .swiper-prev",
				nextEl: ".main-visual .swiper-next",
			},
			watchSlidesProgress: true,
		};

		if ($('.main-visual').hasClass('type-carosel')) {
			// type-carosel
			//console.log('type-carosel!')
			
			const initialSiperLength = className.mainSwiperPc.find('.swiper-slide').length;
			
			if (className.mainSwiperPc.find('.swiper-slide').length <= 3 && className.mainSwiperPc.find('.swiper-slide').length > 1) {
				//console.log(className.mainSwiperPc.find('.swiper-slide').length)
				let swiperItem = className.mainSwiperPc.find('.swiper-slide').clone()
				className.mainSwiperPc.find('.swiper-wrapper').append(swiperItem)
				let visualSwiper = new Swiper(".main-visual.pc", {
					slidesPerView: "auto",
					loop: true,
					centeredSlides: true,
					spaceBetween: "30",
					autoplay: {
						delay: 2500,
						disableOnInteraction: false,
					},
					pagination: {
						clickable: true,
						el: ".main-swiper-pagination",
						type: "custom",
						renderCustom: function (swiper, current, total) {
							let swiperIdx = current;
							console.log('current :: ', current)
							if ( swiperIdx > initialSiperLength ) {
								swiperIdx = current - initialSiperLength
							}
							return swiperIdx + " - " + total/2;
						},
					},
					navigation: {
						enabled: true,
						prevEl: ".main-visual .swiper-prev",
						nextEl: ".main-visual .swiper-next",
					},
					watchSlidesProgress: true,
				});

				
				let mVisualSwiper = new Swiper(".main-visual.mobile", visualSwiperOption);

			}

			let mVisualSwiper = new Swiper(".main-visual.mobile", visualSwiperOption);
		} else {
			console.log('type-normal!')
			let visualSwiper = new Swiper(".main-visual.pc", visualSwiperOption);
			let mVisualSwiper = new Swiper(".main-visual.mobile", visualSwiperOption);
			
			
		}


		// swiper auto play control
		className.mainSwiperPauseBtn.on("click", function (e) {
			e.preventDefault();
			if ($(this).hasClass("btn-pause")) {
				//console.log('Pasue!')
				$(this).removeClass("btn-pause").addClass("btn-play");
				visualSwiper.autoplay.stop();
			} else {
				//console.log('Play!')
				$(this).removeClass("btn-play").addClass("btn-pause");
				visualSwiper.autoplay.start();
			}
		});

	},

	mainTimeSwiper: function () {
		// timesale swiper
		const timesaleSwiperOption = {
			slidesPerView: "1",
			loop: false,
			pagination: {
				clickable: true,
				el: ".timesale-swiper-pagination",
			},
			navigation: {
				enabled: true,
				prevEl: ".main-timesale-area .swiper-prev",
				nextEl: ".main-timesale-area .swiper-next",
			},
		};

		let timesaleSwiper = new Swiper(".main-timesale", timesaleSwiperOption);
		7;
	},

	mainbestItemSwiper: function () {
		let className = {
			mainbestItem: $(".main-bestItem .swiper-slide"),
		};
		// main-bestItem-area
		const bestItemSwiperOption = {
			slidesPerView: "11",
			loop: false,
			breakpoints: {
				320: {
					slidesPerView: 5,
					spaceBetween: 10,
				},
				767: {
					slidesPerView: 8,
					spaceBetween: 10,
				},
				1194: {
					slidesPerView: 11,
					spaceBetween: 10,
				},
			},
			navigation: {
				enabled: true,
				prevEl: ".main-bestItem-area .swiper-prev",
				nextEl: ".main-bestItem-area .swiper-next",
			},
		};

		let bestItemSwiper = new Swiper(".main-bestitem", bestItemSwiperOption);

		className.mainbestItem.on("click", function (e) {
			e.preventDefault();

			$(this).addClass("on").siblings().removeClass("on");
		});
	},

	mainBrandSwiper: function () {
		let className = {
			brandList: $(".brand-list"),
			brandListItem: $(".brand-list .swiper-slide"),
		};
		// main brand
		const brandListSwiperOption = {
			slidesPerView: "11",
			spaceBetween: 30,
			loop: false,
			breakpoints: {
				320: {
					slidesPerView: 2,
					spaceBetween: 14,
				},
				767: {
					slidesPerView: 4,
					spaceBetween: 10,
				},
				1194: {
					slidesPerView: 6,
					spaceBetween: 10,
				},
			},
		};

		let brandListSwiper = new Swiper(".brand-list", brandListSwiperOption);

		className.brandListItem.on("click", function (e) {
			e.preventDefault();

			$(this).addClass("on").siblings().removeClass("on");
		});

		let timer, current, totalIdx;
		let nextIdx = 1;
		function setTime() {
			timer = setInterval(function () {
				current = $(".brand-list").find(".on").index();
				totalIdx = parseInt(className.brandListItem.length);

				if (current === 0) {
					current = totalIdx - 1;
				} else {
					current = nextIdx - 1;
				}
				nextIdx = current;

				$(".brand-list .swiper-slide").removeClass("on");
				$(".brand-list .swiper-slide").eq(nextIdx).addClass("on");
			}, 3000);
		}
		setTime();

		className.brandListItem.hover(
			function (e) {
				e.preventDefault();
				clearInterval(timer);
				//console.log("pause");
			},
			function (e) {
				e.preventDefault();
				setTime();
				//console.log("mouseout");
			}
		);
	},

	mainTabSwiper: function () {
		// main-tab-swiper
		const mainTabSwiperOption = {
			slidesPerView: "auto",
			loop: false,
			spaceBetween: 10,
		};

		let mainTabSwiper = new Swiper(".main-tab-swiper", mainTabSwiperOption);
	},

	mainReviewSwiper: function () {
		// main-tab-swiper
		const reviewSwiperOption = {
			slidesPerView: 2,
			loop: false,
			spaceBetween: 30,
			breakpoints: {
				320: {
					slidesPerView: "auto",
					spaceBetween: 10,
				},
				767: {
					slidesPerView: 2,
					spaceBetween: 30,
				},
			},
		};

		let reviewSwiper = new Swiper(".main-review-swiper", reviewSwiperOption);
	},

	// item list swiper ui
	categorySwiper: function () {
		let className = {
			categorySwiperItem: $(".category-tabs-next-swiper .swiper-slide"),
		};

		// category swiper
		const categorySwiperOption = {
			slidesPerView: "8",
			spaceBetween: 0,

			preventClicks: true,
			preventClicksPropagation: false,
			observer: true,
			observeParents: true,

			navigation: {
				prevEl: ".swiper-prev",
				nextEl: ".swiper-next",
			},
		};

		let categorySwiper = new Swiper(".category-tabs-next-swiper", categorySwiperOption);

		className.categorySwiperItem.on("click", function () {
			let target = $(this);
			let targetIdx = target.index();
			//console.log(targetIdx)
			categorySwiperItem.removeClass("on");
			target.addClass("on");
			categorySwiper.slideTo(targetIdx);
		});
	},

	// item list swiper ui
	categoryBubbleSwiper: function () {
		let className = {
			categoryBubbleItem: $(".category-bubble-swiper .swiper-slide"),
		};

		// category swiper
		const categorySwiperOption = {
			slidesPerView: 8,
			spaceBetween: 10,
			breakpoints: {
				320: {
					slidesPerView: 3,
				},
				767: {
					slidesPerView: 5,
				},
				1194: {
					slidesPerView: 8,
				},
			},
			navigation: {
				prevEl: ".category-bubble-swiper .swiper-prev",
				nextEl: ".category-bubble-swiper .swiper-next",
			},
		};

		let categoryBubbleSwiper = new Swiper(".category-bubble-swiper", categorySwiperOption);
		let categoryBubbleSwiperItem = $(".category-bubble-swiper .swiper-slide");

		className.categoryBubbleItem.on("click", function () {
			let target = $(this);
			let targetIdx = target.index();
			//console.log(targetIdx)
			categoryBubbleSwiperItem.removeClass("on");
			target.addClass("on");
			categoryBubbleSwiper.slideTo(targetIdx);
		});
	},

	// item detail thumbnailSwiper ui
	thumbnailSwiper: function () {
		let thumSwiper = new Swiper(".thumbnail-list-swiper", {
			spaceBetween: 10,
			slidesPerView: 5,
			freeMode: true,
			watchSlidesProgress: true,
		});
		let listSwiper = new Swiper(".thumbnail-main-swiper", {
			spaceBetween: 10,
			navigation: {
				nextEl: ".thumbnail-list-swiper .swiper-next",
				prevEl: ".thumbnail-list-swiper .swiper-prev",
			},
			thumbs: {
				swiper: thumSwiper,
			},
		});
	},

	// item detail relationSwiper ui
	relationSwiper: function () {
		const relationSwiperOption = {
			slidesPerView: 2,
			spaceBetween: 14,
			navigation: {
				prevEl: ".swiper-prev",
				nextEl: ".swiper-next",
			},
			breakpoints: {
				767: {
					slidesPerView: 4,
					spaceBetween: 30,
				},
			},
		};
		let relationSwiper = new Swiper(".relation-swiper", relationSwiperOption);
	},

	// faq ui
	faq: function () {
		let className = {
			faqList: $(".customer-faq .list"),
			titleWrap: $(".title-wrap"),
		};

		className.titleWrap.on("click", function (e) {
			e.preventDefault();
			className.faqList.removeClass("open");
			$(this).parent().addClass("open");
		});
	},

	// payment tab ui
	paymentTab: function (target, targetContent) {
		$(target).on("click", function (e) {
			e.preventDefault();

			let targetData = $(this).data("payment");
			$(this).addClass("active").siblings().removeClass("active");
			if (targetData == "undefined") {
				console.log("undefined");
			} else {
				$(targetContent).addClass("hidden");
				$("." + targetData).removeClass("hidden");
			}
		});
	},

	// input password
	inputPasswordUI: function () {
		variable = {
			formLine: $(".form-line"),
		};

		if (variable.formLine.find("input[type=password]").length > 0) {
			// console.log("input password");
			variable.formLine.find("input[type=password]").before('<button type="button" class="show-password-btn"></button>');

			$(".show-password-btn").on("click", function (e) {
				e.preventDefault();

				$(this).toggleClass("active");
				if ($(this).hasClass("active")) {
					$(this).next("input").attr("type", "text");
				} else {
					$(this).next("input").attr("type", "password");
				}
			});
		}
	},
};

$(document).ready(function () {
	salesOnUI.init();
});
