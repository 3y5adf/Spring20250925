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
        <div>
            <select name="" id="" v-model="kind" @change="fnBoardList">
                <option value="">:: 전체 ::</option>
                <option value="1">:: 공지사항 ::</option>
                <option value="2">:: 자유게시판 ::</option>
                <option value="3">:: 문의게시판 ::</option>
            </select>    
            <select name="" id="" v-model="order" @change="fnBoardList">
                <option value="num">:: 번호순 ::</option>
                <option value="title">:: 제목순 ::</option>
                <option value="cnt">:: 조회수 ::</option>
            </select>
            <button @click="fnAdd">글쓰기</button>
        </div>
        <div>
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.boardNo}}</td>
                    <td><a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a></td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cdate}}</td>
                    <td><button @click="fnRemove(item.boardNo)">삭제</button></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                kind : "",
                order : "num"
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            // fnList: function () {
            //     let self = this;
            //     let param = {
                    
            //     };
            //     $.ajax({
            //         url: "",
            //         dataType: "json",
            //         type: "POST",
            //         data: param,
            //         success: function (data) {
            //             // console.log(kind);
            //         }
            //     });
            // },

            fnBoardList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    order : self.order
                };
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.info;
                        // console.log(self.kind);
                        // console.log(self.order);
                    }
                });
            },

            fnRemove: function (boardNo) {
                let self = this;
                let param = {
                    boardNo : boardNo
                    // 편의상 이름을 맞춘 것
                };
                $.ajax({
                    url: "board-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다.");
                        self.fnBoardList();
                    }
                });
            },

            fnAdd: function () {
                location.href="/board-add.do"
            },

            fnView: function (boardNo) {
                pageChange("board-view.do", {boardNo : boardNo});
                // pageChange 를 외부 참조?
                // {} 안에 여러 값을 넣어서 한번에 이동 가능
                // ex) {boardNo : boardNo, qqq : "1234", hhh : "asdf"}
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnBoardList();
        }
    });

    app.mount('#app');
</script>