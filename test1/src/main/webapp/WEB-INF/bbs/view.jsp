<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
        {{bbsNum}}
        <div>
            <table>
                <tr>
                    <th>제목</th>
                    <td>{{bbsInfo.title}}</td>
                </tr>
                <tr>
                    <th>글쓴이</th>
                    <td>{{bbsInfo.userId}}</td>
                </tr>
                <tr>
                    <th>날짜</th>
                    <td>{{bbsInfo.cdate}}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <img v-for="item in bbsImgList" :src="item.filePath">
                        {{bbsInfo.contents}}
                    </td>
                </tr>
                <tr>
                    <th>추천</th>
                    <td>{{bbsInfo.hit}}</td>
                </tr>
            </table>
        </div>

        <div v-if="bbsInfo.userId === sessionId">
            <button @click="fnBbsEdit">수정</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                bbsNum : "${bbsNum}",
                bbsInfo : {},
                bbsImgList : [],

                sessionId : "${sessionId}"
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnBbsView: function () {
                let self = this;
                let param = {
                    bbsNum : self.bbsNum
                };
                $.ajax({
                    url: "/bbs/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.bbsInfo = data.info;
                    }
                });
            },

            fnBbsImgView: function () {
                let self = this;
                let param = {
                    bbsNum : self.bbsNum
                };
                $.ajax({
                    url: "/bbs/imgView.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.bbsImgList = data.list;
                    }
                });
            },

            fnBbsEdit: function () {
                let self =this;
                // alert(self.bbsNum);
                pageChange("/bbs/edit.do", {bbsNum : self.bbsNum});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnBbsView();
            self.fnBbsImgView();
        }
    });

    app.mount('#app');
</script>