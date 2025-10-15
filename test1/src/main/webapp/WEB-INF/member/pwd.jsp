<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
        <!-- pwd -->
        <div v-if="!authFlg">
            <div>
                <label> 아이디 : <input v-model="id"></label>
            </div>
            <div>
                <label> 이름 : <input v-model="name"></label>
            </div>
            <div>
                <label> 번호 : <input v-model="phone" placeholder="-를 제외하고 입력해주세요."></label>
            </div>
            <div>
                <button @click="fnAuth">인증</button>
            </div>
        </div>

        <div v-else>
            <!-- {{id}} -->
            <div>
                <label>비밀번호 : <input v-model="pwd"></label>
            </div>
            <div>
                <label>비밀번호 확인 : <input v-model="pwd2"></label>
            </div>
            <div>
                <button @click="fnPwdChange">비밀번호 수정 </button>
            </div>
            <div>
                <button @click="fnCertification">인증 요청</button>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                authFlg : false,

                id : "",
                name : "",
                phone : "",

                pwd : "",
                pwd2 : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAuth : function () {
                let self = this;
                // self.authFlg=true;
                console.log("공백 제거 전 ==>", self.id);
                console.log("공백 제거 후 ==>", self.id.trim());
                // trim은 문자열 양쪽에 있는 공백 제거, 가운데에 있는건 제거 X
                let param = {
                    id : self.id.trim(),
                    name : self.name.trim(),
                    phone : self.phone.trim()
                };
                // console.log(param);
                $.ajax({
                    url: "/member/pwd.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.result=="success"){
                            alert("확인되었습니다.");
                            self.authFlg=true;
                        } else {
                            self.authFlg=false;
                            alert("회원 정보를 확인해주세요.");
                            location.href="/member/pwd.do";
                        }
                    }
                });
            },

            fnPwdChange : function () {
                let self = this;
                // self.authFlg=true;
                if(self.pwd != self.pwd2){
                    alert("입력한 비밀번호가 다릅니다.");
                    return;
                } 
                let param = {
                    id : self.id.trim(),
                    pwd : self.pwd
                };
                // console.log(param);
                $.ajax({
                    url: "/member/pwdChange.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result=="success"){
                            alert(data.msg);
                            location.href="/member/login.do";
                        } else {
                            alert(data.msg);
                            return;
                        }
                    }
                });
            },

            fnCertification : function () {
                let self = this;
                let param = {
                    channelKey: "{콘솔 내 연동 정보의 채널키}",
                    merchant_uid: "ORD20180131-0000011", // 주문 번호
                    m_redirect_url: "{리디렉션 될 URL}", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
                    popup: false, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
                };
                // IMP.certification 호출
                IMP.certification(param, (rsp) => {
                    if (rsp.success) {
                    // 인증 성공 시
                    this.isCertificationSuccess = true;
                    console.log("인증 성공", rsp);
                    } else {
                    // 인증 실패 시
                    this.isCertificationSuccess = false;
                    console.error("인증 실패", rsp);
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>