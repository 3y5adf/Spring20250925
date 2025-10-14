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
        .txt{
            width: 270px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <!-- {{partList}} -->
        <div>
            <table>
                <tr>
                    <th>
                        카테고리
                    </th>
                    <td style="text-align: left;">
                        <select v-model="menuPart">
                            <option :value="item.menuNo" v-for="item in menuList">{{item.menuName}}</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>제품번호</th>
                    <td>
                        <input type="text" v-model="menuNo">
                    </td>
                </tr>
                <tr>        
                    <th>
                        음식명
                    </th>
                    <td>
                        <input v-model="foodName" class="txt">
                    </td>
                </tr>
                <tr>
                    <th>
                        음식 설명
                    </th>
                    <td>
                        <textarea v-model="foodInfo" cols="40" rows="5"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>
                        가격
                    </th>
                    <td>
                        <input v-model="price" class="txt">
                    </td>
                </tr>
                <tr>
                    <th>
                        이미지
                    </th>
                    <td>
                        <input type="file" id="file1" name="file1" accept=".jpg, .png">
                    </td>
                </tr>
            </table>
        </div>
        <!-- <div>
            종류 : 
            <select name="" id="" v-model="menuPart" @change="fnPartChange(menuPart)">
                <option :value="item.menuName" v-for="item in menuList">{{item.menuName}}</option>
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
        </div> -->
        <button @click="fnMenuAdd">등록</button>

    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                menuList : [],
                menuPart : "10",
                // menuName : "",
                menuNo : "",

                foodName : "",
                foodInfo : "",
                price : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnMenuList: function () {
                let self = this;
                let param = {
                    depth : 1 //db에 depth가 1인것만 보내라고 요청하기 위함
                };
                $.ajax({
                    url: "/product/menu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.menuList = data.menuList;
                    }
                });
            },

            fnMenuAdd : function () {
                let self = this;
                // console.log(self.foodInfo);
                // alert(self.foodInfo);
                let param = {
                    menuPart : self.menuPart,
                    menuNo : self.menuNo,
                    foodName : self.foodName,
                    foodInfo : self.foodInfo,
                    price : self.price
                };
                // console.log(param);
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            console.log(data);
                            var form = new FormData();
                            form.append( "file1",  $("#file1")[0].files[0] ); // id가 file1인 것에 첨부된 파일, 1개만 첨부할 것이기 때문에 [0], $가 붙은건 인풋태그의 이름
                            form.append( "foodNo",  data.foodNo); // 임시 pk=> boardNo 값을 가져왔으니, data.boardNo를 boardNo로
                            self.upload(form);
                            alert ("등록되었습니다.");
                            location.href="/product.do";
                        } else {
                            alert ("오류가 발생했습니다.");
                        }
                    }
                });
                
            },

            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/product/fileUpload.dox", 
                    type : "POST", 
                    processData : false, 
                    contentType : false, 
                    data : form, 
                    success:function(data) { 
                        console.log(data);
                    }	           
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnMenuList();
        }
    });

    app.mount('#app');
</script>