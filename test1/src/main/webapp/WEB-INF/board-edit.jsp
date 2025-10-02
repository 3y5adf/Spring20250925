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
        {{boardNo}}
        <table>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" v-model="titleInput" >
                </td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" v-model="userIdInput" disabled>
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="" id="" v-model="contentsInput" cols="50" rows="20"></textarea>
                </td>
            </tr>
        </table>
        <button @click="fnSave">저장</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardNo : "${boardNo}",
                info : {},
                titleInput : "",
                userIdInput : "",
                contentsInput : "",
                title : "",
                userId : "",
                contents : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            // fnList: function () {
            //     let self = this;
            //     let param = {};
            //     $.ajax({
            //         url: "",
            //         dataType: "json",
            //         type: "POST",
            //         data: param,
            //         success: function (data) {

            //         }
            //     });
            // },

            fnInfo: function () {
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                        // alert(self.boardNo);
                $.ajax({
                    url: "board-view.dox",
                    dataType : "json",
                    type: "POST",
                    data: param,
                    success: function(data) {
                        console.log(data);
                        self.info = data.info;
                        self.titleInput = self.info.title;
                        self.userIdInput = self.info.userId;
                        self.contentsInput = self.info.contents;
                    }
                });
            },

            fnSave : function () {
                let self = this;
                let param = {
                    titleInput : self.titleInput,
                    userIdInput : self.userIdInput,
                    contentsInput : self.contentsInput,
                    boardNo : self.boardNo
                }
                // console.log(param);
                // console.log(self.boardNo);

                $.ajax({
                    url: "board-edit.dox",
                    dataType : "json",
                    type: "POST",
                    data: param,
                    success: function(data) {
                        alert("수정되었습니다.");
                        location.href="board-list.do";
                        // location의 대상을 boardNo를 가진 board-view로 가도록 해보기
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>