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
        join
        <div>
            <label>아이디 : <input type="text" v-model="id"></label>
            <button @click="fnIdCheck">중복체크</button>
        </div>
        <div>
            <label>비밀번호 : <input type="password" v-model="pwd"></label>
        </div>
        <div>
            주소 : <input type="text" name="" id="" v-model="addr"> <button @click="fnAddr">주소검색</button>
        </div>
        <div>
            문자인증 : <input type="text" v-model="inputNum" :placeholder="timer"> 
                <!-- 속성에 :를 붙이면 변수가 동적으로 변함 -->
            <template v-if="!smsFlg">
                <button @click="fnSms">인증번호 전송</button>
            </template>
            <template v-else>
                <button>인증</button>
            </template>
        </div>
        <div>
            {{timer}}
            <button @click="fnTimer">시작!</button>
        </div>
        <!-- <button @click="fnJoin">회원가입</button> -->
    </div>
</body>
</html>

<script>

    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
        // console.log(roadFullAddr);
        // console.log(roadAddrPart1);
        // console.log(addrDetail);
        // console.log(engAddr);
        window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
        // mounted에서 window.vueObj를 this로 해서 vue와 연결됨
        // vue에 fnResult가 없으니 생성
    }

    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                id : "",
                pwd : "",
                addr : "",
                inputNum : "",
                smsFlg : false,
                timer : 180
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnIdCheck: function () {
                let self = this;
                let param = {
                    id : self.id
                };
                if(param.id.length==0){
                    alert("id를 입력해주세요.");
                    return;
                }
                $.ajax({
                    url: "/member/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        // alert(data.msg);
                        if(data.result == "true"){
                            alert("이미 사용중인 아이디 입니다.");
                        } else {
                            alert("사용 가능한 아이디 입니다");
                        }
                    }
                });
            },

            fnAddr : function () {
                window.open("/member/addr.do", "addr", "width=500, height=500");
            },

            fnResult : function (roadFullAddr, addrDetail, zipNo) {
                let self = this;
                self.addr = roadFullAddr;
            },

            fnSms : function () {
                let self = this;
                let param = {

                };

                $.ajax({
                    url: "/send-one",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.res.statusCode == "2000"){
                            alert("문자 전송 완료");
                            self.smsFlg = true;
                            self.fnTimer();
                        } else {
                            alert("잠시 후 다시 시도해주세요.");
                        }
                    }
                });
            },

            fnTimer : function () {
                let self = this;
                let interval = setInterval(function(){
                    if(self.timer == 0) {
                        clearInterval(interval);
                        alert("시간이 만료되었습니다.");
                    } else{
                        self.timer--;
                    }
                }, 1000);
            },

            fnJoin : function () {
                let self=this;
                let param={
                    id : self.id,
                    pwd : self.pwd
                }
                const regId = /[a-z0-9]/;
                if(regId.test(param.id)){
                    alert("a");
                }
                
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>