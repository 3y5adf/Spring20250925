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
        table a{
            text-decoration: none;
            color: black;
        }
        table a:hover{
            text-decoration: underline;
            font-weight: bold;
        }
        .cmtCnt{
            color: red;
            font-weight: bold;
        }
        .index{
            
            margin-right: 5px;
            text-decoration: none;
            color: black;
            
        }

        .index:hover{
            text-decoration: underline;
        }
        .active {
            color : blue;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>

            <select name="" id="" v-model="pageSize" @change="fnBoardList">
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="20">20개씩</option>
            </select>

            <select name="" id="" v-model="srchOption">
                <option value="all">:: 전체 ::</option>
                <option value="title">:: 제목 ::</option>
                <option value="id">:: 작성자 ::</option>
            </select>
            <input type="text" v-model="keyword">
            <button @click="fnBoardList">검색</button>
        </div>
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
                <option value="date">:: 날짜순 ::</option>
            </select>
            <button @click="fnAdd">글쓰기</button>
        </div>
        <div>
            <table>
                <tr>
                    <th><input type="checkbox" v-model="checkNoList" @click="fnCheckAll"></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td><input type="checkbox" :value="item.boardNo" v-model="checkNo"></td>
                    <td>{{item.boardNo}}</td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.boardNo)">
                            {{item.title}} 
                        </a>
                        <span v-if="item.ccount!=0" class="cmtCnt"> [{{item.ccount}}]</span>
                    </td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>
                        {{item.cdate}}
                    </td>
                    <td>
                        <button @click="fnRemove(item.boardNo)" v-if=" item.userId==sessionId || sessionStatus=='A' ">삭제</button>
                    </td>
                </tr>
            </table>

            <button @click="fnRemoveList">삭제</button>

            <div>
                <!-- <a class="index" href="javascript:;" @click="fnPageDown()" v-if="page!=1">◀</a> -->
                <a class="index" href="javascript:;" @click="fnMove(-1)" v-if="page!=1">◀</a>
                <a class="index" href="javascript:;" v-for="num in index" @click="fnPageChange(num)">
                    <span :class="{active : page==num}" >{{num}}</span>
                    <!-- 동적 클래스(바인드 클래스) : 특정 조건을 만족할 때만 클래스 부여 -->
                </a>
                <!-- <a class="index" href="javascript:;" @click="fnPageUp()" v-if="page!=index">▶</a> -->
                <a class="index" href="javascript:;" @click="fnMove(+1)" v-if="page!=index">▶</a>
            </div>
        </div>
        
    </div>
</body>
</html>

<script>
    // let today = new Date();
    // var year = today.getFullYear();
    // var month = ('0' + (today.getMonth() + 1)).slice(-2);
    // var day = ('0' + today.getDate()).slice(-2);

    // var dateString = year + '-' + month  + '-' + day;

    // console.log(dateString);

    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : [],
                kind : "",
                order : "date",
                srchOption : "all", // 검색 옵션 (기본 : 전체)
                keyword : "", //검색어

                checkNoList : "",
                checkNo : [],

                checkFlg : false,

                pageSize : 5, // 한 페이지에 출력할 개수
                page : 1, //현재 페이지
                index : 0, // 최대 페이지 값

                sessionId : "${sessionId}",
                sessionName : "${sessionName}",
                sessionStatus : "${sessionStatus}"
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
                    order : self.order,

                    srchOption : self.srchOption,
                    keyword : self.keyword,

                    pageSize : self.pageSize,
                    page : (self.page-1) * self.pageSize
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
                        self.index = Math.ceil(data.cnt / self.pageSize);
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
            },

            fnPageChange:function (num) {
                let self= this;
                // console.log(num);

                self.page = num;
                self.fnBoardList();
            },

            fnPageUp:function (){
                let self=this;
                // console.log(self.page);
                // console.log(self.index);
                
                if(self.page == self.index){
                    alert("마지막 페이지입니다.");
                    return;
                }
                self.page= self.page+1;

                self.fnBoardList();
            },

            fnPageDown : function () {
                let self = this;

                if(self.page == 1){
                    alert("첫 페이지입니다.");
                    return;
                }
                self.page= self.page-1;

                self.fnBoardList();
            },
            fnMove:function(num){
                let self=this;
                self.page += num;
                self.fnBoardList();
            },

            fnCheckAll:function () {
                let self=this;
                self.checkFlg = !self.checkFlg;
                if(self.checkFlg){
                    self.checkNo = [];
                    for(let i = 0; i<self.list.length; i++){
                        self.checkNo.push(self.list[i].boardNo);
                    }
                } else {
                    self.checkNo = [];
                }
                
            },

            fnRemoveList:function(){
                let self = this;
                console.log(self.checkNo);

                var fList = JSON.stringify(self.checkNo);
                var param = {checkNo : fList};

                $.ajax({
                    url: "/board/deleteList.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다!");
                        self.fnBoardList();
                    }
                });

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