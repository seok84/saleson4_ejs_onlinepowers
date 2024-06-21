const express = require('express');
const sassMiddleware = require('node-sass-middleware');
const path = require('path');
const port = process.env.PORT || 5000;

const app = express();
const siteData = {
    title: "nodeAPP",
    message: "About Content"
}


app.use(sassMiddleware({
    src: path.join(__dirname, '../src/main/resources/static'),
    dest: path.join(__dirname, '../src/main/resources/static'),
    debug: true,
    outputStyle: 'expanded',
}));

app.use(express.static(path.join(__dirname, '../src/main/resources')))

// view template set
app.set('view engine', 'ejs');

app.set('views', path.join(__dirname, 'views'))
    .set('view engine', 'ejs')
    .use(require('express-ejs-layouts'))
    .set('layout', 'layouts/layout') 

app.listen(port, function() {
  console.log('Listening on http://localhost:%s/', port);
});



/*
메인, 상품리스트
브랜드 + 검색 + 장바구니 + Quick Link

검색결과
뒤로가기 + 브랜드 + 검색 + 장바구니

장바구니, 주문/결제, 마이페이지, 고객센터, 상품상세, 회원가입, 로그인
뒤로가기 + 타이틀 + 장바구니

마이페이지 메인
뒤로가기 + 타이틀 + 장바구니 + 개인정보


pageback :: page back button show
brand :: brand(logo) show
page-title :: page title show
searching :: searching-area show
basket :: basket ico show
quicklink :: quick-link show 


<% if(headerTypeNo == 0) { %>
    <!-- 브랜드 + 검색 + 장바구니 + Quick Link, eg) 메인, 상품리스트 -->
    <header id="header" class="brand searching basket quicklink">

<% } else if(headerTypeNo == 1) { %>
    <!-- 뒤로가기 + 브랜드 + 검색 + 장바구니, eg) 검색결과 -->
    <header id="header" class="pageback brand searching basket">

<% } else if(headerTypeNo == 2) { %>
    <!-- 뒤로가기 + 타이틀 + 장바구니, eg) 장바구니, 주문/결제, 마이페이지, 고객센터, 상품상세, 회원가입, 로그인 -->
    <header id="header" class="pageback page-title basket">
*/


// route rendering
app.get('/', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/main/index', {
            title: siteData.title
        } 
    )
});

// guide
app.get('/guide-layout', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/guide/layout')
});
app.get('/guide-form', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/guide/form')
});
app.get('/guide-button', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/guide/button')
});
app.get('/guide-text', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/guide/text')
});
app.get('/guide-item', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/guide/item')
});
app.get('/guide-modal', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/guide/modal')
});
app.get('/guide-color', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('pages/guide/color')
});


// user 
app.get('/login', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/login')
});
app.get('/join', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/join')
});
app.get('/sns-join', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/sns-join')
});
app.get('/certify-join', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/certify-join') 
});

app.get('/change-pw', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/change-pw')
});

app.get('/expired-pw', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/expired-pw')
});
app.get('/find-id', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/find-id')
});
app.get('/find-id-complete', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/find-id-complete')
});
app.get('/find-pw', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/find-pw')
});
app.get('/find-pw-complete', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/find-pw-complete')
});
app.get('/secede', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/secede')
});
app.get('/sms-certify', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/sms-certify')
});
app.get('/sns-auth-step1', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/sns-auth-step1')
});
app.get('/sns-auth-step2', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.headerTypeNo = 2;
    res.render('pages/user/sns-auth-step2')
});
app.get('/access', function(req, res) {
    app.locals.headerTypeNo = 2;
    res.render('pages/user/access', {
        layout:'layouts/layout_empty'
    })
});


// cart 
app.get('/cart', function(req, res) {
    app.locals.styleNo = 2;
    app.locals.headerTypeNo = 2;
    res.render('pages/cart/index')
});
// order 
app.get('/order/step1', function(req, res) {
    app.locals.styleNo = 2;
    app.locals.headerTypeNo = 2;
    res.render('pages/order/step1')
});
app.get('/order/step2', function(req, res) {
    app.locals.styleNo = 2;
    app.locals.headerTypeNo = 2;
    res.render('pages/order/step2')
});
app.get('/order/no-member', function(req, res) {
    app.locals.styleNo = 2;
    app.locals.headerTypeNo = 2;
    res.render('pages/order/no-member')
});

// items
app.get('/items', function(req, res) {
    app.locals.styleNo = 3;
    app.locals.headerTypeNo = 0;
    res.render('pages/items/index')
});
app.get('/display/best', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.headerTypeNo = 0;
    res.render('pages/display/best')
});
app.get('/display/brand/_id', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.headerTypeNo = 0;
    res.render('pages/display/brand/_id')
});
app.get('/display/brand', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.headerTypeNo = 0;
    res.render('pages/display/brand/index')
});
app.get('/display/md', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.headerTypeNo = 0;
    res.render('pages/display/md')
});
app.get('/display/new', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.headerTypeNo = 0;
    res.render('pages/display/new')
});
app.get('/display/timedeal', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.headerTypeNo = 0;
    res.render('pages/display/timedeal')
});
app.get('/items/_id', function(req, res) {
    app.locals.styleNo = 3;
    app.locals.headerTypeNo = 3;
    res.render('pages/items/_id')
});


// mypage 
app.get('/mypage', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.indexNo = 0;
    res.render('pages/mypage/index', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/order', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.indexNo = 1;
    res.render('pages/mypage/order/index', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/order/_id', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.indexNo = 1;
    res.render('pages/mypage/order/_id', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/order-cancel', function(req, res) {
    app.locals.styleNo = 4;
    app.locals.indexNo = 1;
    res.render('pages/mypage/order-cancel', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/wishlist', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.indexNo = 1;
    res.render('pages/mypage/wishlist', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/recent-view', function(req, res) {
    app.locals.styleNo = 5;
    app.locals.indexNo = 1;
    res.render('pages/mypage/recent-view', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/delivery', function(req, res) {
    app.locals.styleNo = 1;
    app.locals.indexNo = 1;
    res.render('pages/mypage/delivery', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/coupon', function(req, res) {
    app.locals.styleNo = 2;
    app.locals.indexNo = 1;
    res.render('pages/mypage/coupon', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/point', function(req, res) {
    app.locals.styleNo = 7;
    app.locals.indexNo = 1;
    res.render('pages/mypage/point', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/grade', function(req, res) {
    app.locals.styleNo = 3;
    app.locals.indexNo = 1;
    res.render('pages/mypage/grade', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/myInfo', function(req, res) {
    app.locals.styleNo = 6;
    app.locals.indexNo = 1;
    res.render('pages/mypage/myInfo', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/password', function(req, res) {
    app.locals.styleNo = 6;
    app.locals.indexNo = 1;
    res.render('pages/mypage/password', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/sns-manage', function(req, res) {
    app.locals.styleNo = 6;
    app.locals.indexNo = 1;
    res.render('pages/mypage/sns-manage', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/inquiry', function(req, res) {
    app.locals.styleNo = 5;
    app.locals.indexNo = 1;
    res.render('pages/mypage/inquiry', {
        layout:'layouts/layout_mypage'
    })
});
app.get('/mypage/review', function(req, res) {
    app.locals.styleNo = 5;
    app.locals.indexNo = 1;
    res.render('pages/mypage/review', {
        layout:'layouts/layout_mypage'
    })
});


// event 
app.get('/featured', function(req, res) {
    app.locals.styleNo = 6;
    app.locals.headerTypeNo = 2;
    res.render('pages/featured/index')
});
app.get('/featured/_id', function(req, res) {
    app.locals.styleNo = 6;
    app.locals.headerTypeNo = 2;
    res.render('pages/featured/pages/_id')
});

// customer
app.get('/customer/notice', function(req, res) {
    app.locals.styleNo = 7;
    app.locals.headerTypeNo = 2;
    res.render('pages/customer/notice')
});
app.get('/customer/faq', function(req, res) {
    app.locals.styleNo = 7;
    app.locals.headerTypeNo = 2;
    res.render('pages/customer/faq')
});
app.get('/customer/qna', function(req, res) {
    app.locals.styleNo = 7;
    app.locals.headerTypeNo = 2;
    res.render('pages/customer/qna')
});
app.get('/customer/partner', function(req, res) {
    app.locals.styleNo = 7;
    app.locals.headerTypeNo = 2;
    res.render('pages/customer/partner')
});


// search
app.get('/search', function(req, res) {
    app.locals.styleNo = 8;
    app.locals.headerTypeNo = 2;
    res.render('pages/search/index')
});


// terms
app.get('/terms/terms', function(req, res) {
    app.locals.styleNo = 9;
    app.locals.headerTypeNo = 2;
    res.render('pages/terms/terms')
});
app.get('/terms/policy', function(req, res) {
    app.locals.styleNo = 9;
    app.locals.headerTypeNo = 2;
    res.render('pages/terms/policy')
});
app.get('/terms/refuse-email', function(req, res) {
    app.locals.styleNo = 9;
    app.locals.headerTypeNo = 2;
    res.render('pages/terms/refuse-email')
});
app.get('/terms/marketing', function(req, res) {
    app.locals.styleNo = 9;
    app.locals.headerTypeNo = 2;
    res.render('pages/terms/marketing')
});

// healthcheck
app.get('/healthcheck', function(req, res) {
    app.locals.headerTypeNo = 0;
    res.render('pages/healthcheck/index', {
        layout:'layouts/layout_empty'
    })
});

// loading
app.get('/loading', function(req, res) {
    app.locals.headerTypeNo = 1;
    res.render('pages/loading', {
        layout:'layouts/layout_empty'
    })
});



// error
app.get('/error', function(req, res) {
    app.locals.styleNo = 10;
    app.locals.headerTypeNo = 0;
    res.render('layouts/error')
});

// window popup
app.get('/window-popup', function(req, res) {
    app.locals.styleNo = 0;
    app.locals.headerTypeNo = 0;
    res.render('components/modal/window-popup')
});
