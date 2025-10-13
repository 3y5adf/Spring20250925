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
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <!-- {{partList}} -->
        <div>
            종류 : 
            <select name="" id="" v-model="menuPart" @change="fnPartChange(menuPart)">
                <option :value="item.menuName" v-for="item in partList">{{item.menuName}}</option>
            </select>
            <input type="text" v-model="menuPart" disabled>
            <br>
            이름 : 
            <input type="text" name="" id="" v-model="menuName">
            <br>
            설명 : 
            <textarea name="" id=""></textarea>
            <br>
            가격 : 
            <input type="text" name="" id="">
            <br>
            이미지 : 
            <input type="text" name="" id="">
        </div>
        <button @click="fnMenuAdd">등록</button>

    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                partList : [],
                menuPart : "한식",
                menuName : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnPartList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/product-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.partList = data.list;
                    }
                });
            },

            fnMenuAdd : function () {
                let self = this;
                alert(self.menuName);
                let param = {
                    menuPart : self.menuPart,
                    menuName : self.menuName
                };
                
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnPartList();
        }
    });

    app.mount('#app');
</script>