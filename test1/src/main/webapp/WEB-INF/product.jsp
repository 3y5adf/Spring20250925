<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="/css/product-style.css">
    <script src="/js/page-change.js"></script>
</head>

<body>
    <div id="app">
        <header>
            <div class="logo">
                <img src="/img/logo.png" alt="쇼핑몰 로고">
            </div>

            <nav>
                <ul>
                    <li v-for="item in menuList"  class="dropdown">
                        <a href="#" v-if="item.depth==1" @click="fnProductList(item.menuNo, '')">{{item.menuName}}</a>
                        <ul class="dropdown-menu" v-if="item.cnt >0">
                            <span v-for="subItem in menuList">
                                <li  v-if="item.menuNo == subItem.menuPart">
                                    <a href="#" @click="fnProductList('', subItem.menuNo)">
                                        {{subItem.menuName}}
                                    </a>
                                </li>
                            </span>
                        </ul>
                    </li>

                    <!-- <li class="dropdown">
                        <a href="#">한식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">비빔밥</a></li>
                            <li><a href="#">김치찌개</a></li>
                            <li><a href="#">불고기</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#">중식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">짜장면</a></li>
                            <li><a href="#">짬뽕</a></li>
                            <li><a href="#">마파두부</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#">양식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">피자</a></li>
                            <li><a href="#">파스타</a></li>
                            <li><a href="#">스테이크</a></li>
                        </ul>
                    </li>
                    <li><a href="#">디저트</a></li>
                    <li><a href="#">음료</a></li> -->
                </ul>
            </nav>
            <div class="search-bar"  >
                <input type="text" placeholder="상품을 검색하세요..." v-model="keyword" @keyup.enter="fnProductList('','')">
                <button @click="fnProductList('','')" >검색</button>
            </div>
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>

        <!-- 제품 항목 -->
        <!-- <main>
            <section class="product-list">
                
                <div class="product-item">
                    <img src="/img/image1.jpg" alt="제품 1">
                    <h3>비빔밥</h3>
                    <p>맛있는 한식, 비빔밥!</p>
                    <p class="price">₩9,900</p>
                </div>
                <div class="product-item">
                    <img src="/img/image2.jpg" alt="제품 2">
                    <h3>짜장면</h3>
                    <p>중국의 대표적인 면 요리, 짜장면!</p>
                    <p class="price">₩7,500</p>
                </div>
                <div class="product-item">
                    <img src="/img/image3.jpg" alt="제품 3">
                    <h3>피자</h3>
                    <p>풍부한 치즈가 일품인 피자!</p>
                    <p class="price">₩12,000</p>
                </div>

            </section>
        </main> -->

        <main>
            <section class="product-list">
                <div class="product-item" v-for="item in productList" @click="fnView(item.menuNo)">
                    <img :src="item.filePath" alt="item.fileName">
                    <h3>{{item.foodName}}</h3>
                    <p>{{item.foodInfo}}</p>
                    <p class="price">₩{{item.price.toLocaleString()}}</p>
                    <!-- .toLocaleString() 이거 붙이면 알아서 3글자마다 ,를 붙여줌. javascript 자체 기능 -->
                </div>
            </section>
        </main>
        <!-- {{productList}} -->
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                productList : [],
                menuList : [],
                keyword : "",
                category : ""
            };
        },
        methods: {
            fnLogin : function() {
                var self = this;
                var nparmap = {};
                $.ajax({
                    url: "login.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                    }
                });
            },

            fnProductList : function(part, menuNo) {
                var self = this;
                var nparmap = {
                    keyword : self.keyword,
                    menuPart : part,
                    menuNo : menuNo
                };
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.productList = data.list;
                        self.menuList = data.menuList;
                    }
                });
            },

            fnView : function (menuNo) {
                var self = this;
                // alert(menuNo);
                pageChange("/product/view.do", {menuNo : menuNo});
            }
        },
        mounted() {
            var self = this;
            self.fnProductList('','');
        }
    });
    app.mount('#app');
</script>