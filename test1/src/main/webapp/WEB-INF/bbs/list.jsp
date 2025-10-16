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
        .title{
            text-decoration: none;
            color: black;
        }
        .hitTitle{
            text-decoration: none;
            font-weight: bold;
            color: red;
        }
        .title:hover, .hitTitle:hover{
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <!-- list -->
        <div>
            <table>
                <tr>
                    <th>체크</th>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>hit</th>
                    <th>작성자</th>
                </tr>
                <tr v-for="item in bbsList">
                    <td><input type="radio" name="checkRemove" v-model="checkNo" :value="item.bbsNum"></td>
                    <td>{{item.bbsNum}}</td>
                    <td v-if="item.hit>=25"><a href="javascript:;" @click="fnBbsView(item.bbsNum)" class="hitTitle">{{item.title}}</a></td>
                    <td v-else><a href="javascript:;" @click="fnBbsView(item.bbsNum)" class="title">{{item.title}}</a></td>
                    <td>{{item.hit}}</td>
                    <td>{{item.userId}}</td>
                </tr>
            </table>
        </div>

        <div>
            <a href="javascript:;" @click="fnBbsAdd"><button>글쓰기</button></a>
            <a href="javascript:;" @click="fnBbsRemove"><button>삭제</button></a>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                bbsList : [],
                bbsNum : "",
                checkNo : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnBbsList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/bbs/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.bbsList = data.list;
                    }
                });
            },

            fnBbsAdd : function () {
                location.href="/bbs/add.do"
            },

            fnBbsRemove : function () {
                let self = this;
                // alert(self.checkNo);
                let param = {
                    checkNo : self.checkNo
                };
                $.ajax({
                    url: "/bbs/remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.result=="success"){
                            alert("삭제되었습니다.");
                            location.href="/bbs/list.do"
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
            },

            fnBbsView : function (bbsNum) {
                // alert(bbsNum);
                pageChange("/bbs/view.do", {bbsNum : bbsNum});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnBbsList();
        }
    });

    app.mount('#app');
</script>