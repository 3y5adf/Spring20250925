<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
        .index {
            margin-right: 10px;
            text-decoration: none;
            color: black;
        }
        .active{
            color: red;
            font-weight: bold;
        }
        select, option {
            text-align: center;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>area</div>
        <div>
            <!-- {{areaList}} -->
            <div>
                <div>
                    도/특별시 : 
                    <select name="" id="" v-model="si" @change="fnSiChange(si)">
                        <option value="">:: 전체 ::</option>
                        <option :value="item.si" v-for="item in siList">:: {{item.si}} ::</option>
                        <!-- 동적인 속성에는 :를 붙임 -->
                    </select>

                    시/군/구 : 
                    <select name="" id="" v-model="gu" v-if="si==''" disabled>
                        <option value="">:: 전체 ::</option>
                    </select>
                    <select name="" id="" v-model="gu" @change="fnGuChange(gu)" v-else>
                        <option value="">:: 전체 ::</option>
                        <option :value = "item.gu" v-for="item in guList">:: {{item.gu}} ::</option>
                    </select>

                    <button @click="fnAreaSearch">검색</button>
                </div>
                <!-- <div>
                    시/군/구 : 
                    <select name="" id="" v-model="gu" v-if="si==''" disabled>
                        <option value="">:: 전체 ::</option>
                    </select>
                    <select name="" id="" v-model="gu" v-else>
                        <option value="">:: 전체 ::</option>
                        <option >::  ::</option>
                    </select>
                </div> -->

                <table>
                    <tr>
                        <th>특별시,광역시,도</th>
                        <th>시,군,구</th>
                        <th>동</th>
                        <th>X</th>
                        <th>Y</th>
                    </tr>
                    <tr v-for="item in areaList">
                        <td>{{item.si}}</td>
                        <td>{{item.gu}}</td>
                        <td>{{item.dong}}</td>
                        <td>{{item.nx}}</td>
                        <td>{{item.ny}}</td>
                    </tr>
                </table> 
                {{index}}
                <div>
                    <a class=index href="javascript:;" v-for="num in index" @click="fnPageChange(num)">
                        <span :class="{active : page == num}">{{num}}</span>
                    </a>
                </div>   
            </div>
            <!-- {{guList}} -->
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                areaList : [], // 지역 리스트
                siList : [], // 광역시/특별시/도 리스트
                guList : [], // 시/군/구 리스트

                pageSize : 20, // 한 페이지에 출력할 개수
                page : 1, //현재 페이지
                index : 0, // 최대 페이지 값

                si : "", //선택한 시(도)의 값
                gu : "" // 선택한 시/군/구의 값
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAreaList: function () {
                let self = this;
                let param = {
                    pageSize : self.pageSize,
                    page : (self.page-1) * self.pageSize,

                    si : self.si,
                    gu : self.gu
                };
                $.ajax({
                    url: "/area/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.areaList = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                    }
                });
            },

            fnPageChange: function (num) { //페이지 숫자 누르면 페이지 변경
                let self = this;
                self.page = num;
                self.fnAreaList();
            },

            fnSiChange: function (si) { // 도/특별시 select 하면 변수 si 변경+시/군/구 select 호출
                let self = this;
                self.si = si;
                // alert(self.si);
                // fnGuList에 si값을 파라미터로 넣어서 구 리스트 불러오기
                self.gu = "";
                self.fnGuList(si);
            },

            fnSiList: function () { // 도/특별시 list 불러오기
                let self = this;
                let param = {
                    
                };
                $.ajax({
                    url: "/area/si.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        // console.log(data);
                        self.siList = data.list;
                        console.log(self.siList);
                    }
                });
            },

            fnGuChange: function (gu) { // 시/군/구 select 시, 변수 gu 변경
                let self = this;
                self.gu = gu;
                // alert(self.gu);
            },

            fnGuList : function (si) { // 시/군/구 list 호출
                let self = this;
                let param = {
                    si
                };
                $.ajax({
                    url: "/area/gu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.guList = data.list;
                    }
                });
            },

            fnAreaSearch : function () { // 변수 si와 gu가 변경된 상태에서 areaList 호출
                let self = this;
                // alert(self.si);
                // alert(self.gu);
                self.fnAreaList();
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnAreaList();
            self.fnSiList();
        }
    });

    app.mount('#app');
</script>