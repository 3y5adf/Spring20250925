<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <!-- <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet"> -->
    <!-- <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script> -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>


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
        #editor{
            width: 500px;
            height: 200px;
            background-color: white;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <table>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" v-model="titleInput">
                </td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" v-model="userIdInput" disabled>
                </td>
            </tr>
            <tr>
                <th>파일 첨부</th>
                <td>
                    <input type="file" id="file1" name="file1" accept=".jpg, .png"> 
                    <!-- 속성에 multiple 넣으면 파일 여러개 첨부 가능 -->
                    <!-- accept=".jpg, .png ..." 속성을 써서 첨부받을 파일의 타입 지정 가능 -->
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <!-- <div id="editor"> -->
                        <!-- <textarea name="" id="" v-model="contentsInput" cols="50" rows="20"></textarea> -->
                    <!-- </div> -->
                    <div id="editor"></div>
                </td>
            </tr>
        </table>
        <button @click="fnAdd">작성</button>
        <a href="board-list.do"><button>뒤로</button></a>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                titleInput : "",
                contentsInput : "",
                userIdInput : "${sessionId}",

                sessionId : "${sessionId}",
                sessionName : "${sessionName}",
                sessionStatus : "${sessionStatus}"
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

            fnAdd: function() {
                let self = this;
                let param = {
                    titleInput : self.titleInput,
                    contentsInput : self.contentsInput,
                    userIdInput : self.sessionId
                };
                $.ajax({
                    url:"board-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data){
                        alert("작성되었습니다.");
                        console.log(data.boardNo);
                        var form = new FormData();
                        form.append( "file1",  $("#file1")[0].files[0] ); // id가 file1인 것에 첨부된 파일, 1개만 첨부할 것이기 때문에 [0]
                        form.append( "boardNo",  data.boardNo); // 임시 pk=> boardNo 값을 가져왔으니, data.boardNo를 boardNo로
                        self.upload(form);
                        location.href="/board-list.do";
                    }
                })
            },

            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/fileUpload.dox", 
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
            if(self.sessionId==""){
                alert("로그인 후, 이용해주세요.");
                location.href="/member/login.do";
            }

            // Quill 에디터 초기화
            var quill = new Quill('#editor', {
                theme: 'snow',
                modules: {
                    toolbar: [
                        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                        ['bold', 'italic', 'underline'],
                        [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                        ['link', 'image'],
                        ['clean']
                    ]
                }
            });

            // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
            quill.on('text-change', function() {
                self.contentsInput = quill.root.innerHTML;
            });
        }
    });

    app.mount('#app');
</script>