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
        #board table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        .contentsTd{
            width: 400px;
            height: 300px;
            text-align: left;
            vertical-align: top;
        }
        tr:nth-child(even){
            background-color: azure;
        }
        input{
            width: 350px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <!-- {{boardNo}} -->
        <!-- {{info}} -->
        <div>
            <table id="board">
                <tr>
                    <th>제목</th>
                    <td>{{info.title}}</td>
                </tr>
                <!-- <tr>
                    <th>작성일</th>
                    <td>{{info.cdate}}</td>
                </tr> -->
                <tr>
                    <th>작성자</th>
                    <td>{{info.userId}}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td class="contentsTd">{{info.contents}}</td>
                </tr>
            </table>
        </div>
        <a href="javascript:;" @click="fnEdit"><button>수정</button></a>
        <hr>
        <div class="commentSpace">
            <!-- {{commentList}} -->
            <div v-for="item in commentList">
                <div v-if="item.PCMT==0">{{item.nickName}} : {{item.contents}}</div>
                <div v-else>ㄴ{{item.nickName}} : {{item.contents}}</div>
            </div>
        </div>
        <table id="comment">
            <tr v-for="item in commentList">
                <th>{{item.nickName}}</th>
                <td>{{item.contents}}</td>
                <td><button>삭제</button></td>
                <td><button>수정</button></td>
            </tr>
        </table>
        <table id="input">
            <th>댓글 입력</th>
            <td>
                <textarea cols="50" row="5"></textarea>
            </td>
            <td>
                <button>저장</button>
            </td>
        </table>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                // test : "${test}" ,
                // 문자열이기 때문에 $를 붙여주어야 함
                //request.getAttribute를 단순화시킴
                boardNo : "${boardNo}",
                info : {},
                commentList : []
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
                        self.commentList = data.commentList;
                    }
                });
            },
            
            fnEdit: function () {
                let self = this;
                // alert(self.boardNo);
                pageChange("board-edit.do", {boardNo : self.boardNo});
                
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