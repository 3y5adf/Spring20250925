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
        .phone{
            width: 40px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <!-- join -->
        <div>
            <label>
                아이디 : 
                <input v-if="!idFlg" type="text" v-model="id">
                <input v-else type="text" v-model="id" disabled>
            </label>
            <button @click="fnIdCheck">중복체크</button>
            <!-- <span v-if="idFlg">○</span> -->
        </div>
        
        <div>
            <label>비밀번호 : <input type="password" v-model="pwd"></label>
        </div>
        <div>
            <label>비밀번호 확인 : <input type="password" v-model="pwd2"></label>
            <button @click="fnPwdCheck">확인</button>
            <!-- <span v-if="pwdFlg">○</span>
            <span v-else></span> -->
        </div>
        
        <div>
            프로필 이미지 :
            <input type="file" id="file1" name="file1">
        </div>

        <div>
            이름 : <input type="text" v-model="name">                                                       
        </div>
        <div>
            주소 : <input type="text" name="" id="" v-model="addr" disabled> <button @click="fnAddr">주소검색</button>
        </div>
        <div>
            핸드폰 번호 : 
            <input type="text" class="phone" v-model="phone1"> - 
            <input type="text" class="phone" v-model="phone2"> - 
            <input type="text" class="phone" v-model="phone3">
        </div>
        <div v-if="!joinFlg">
            문자인증 : <input type="text" v-model="inputNum" :placeholder="timer"> 
                <!-- 속성에 :를 붙이면 변수가 동적으로 변함 -->
            <template v-if="!smsFlg">
                <button @click="fnSms">인증번호 전송</button>
            </template>
            <template v-else>
                <button @click="fnSmsAuth">인증</button>
            </template>
        </div>
        <div v-else style="color: red;">
            문자인증이 완료되었습니다.
        </div>

        <div>
            성별 : 
            <label><input type="radio" v-model="gender" value="M"> 남자</label>
            <label><input type="radio" v-model="gender" value="F"> 여자</label>
        </div>

        <div>
            가입 권한 : 
            <select name="" id="" v-model="status">
                <option value="A">관리자</option>
                <option value="S">판매자</option>
                <option value="C">소비자</option>
            </select>
        </div>

        <div>
            <button @click="fnJoin">회원가입</button>
        </div>

        <div>
            <br>
            {{timer}}
            <button @click="fnTimer">카운트</button>
            <div>
                비밀번호 확인용 : 
                <input type="text" name="" id="" v-model="pwd" disabled>
            </div>
            <!-- <button @click="fnPwdCheck">비번</button> -->
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
                pwd2 : "",
                addr : "",
                name : "",
                phone1 : "",
                phone2 : "",
                phone3 : "",
                gender : "M",
                status : "C",

                idFlg : false,
                pwdFlg : false,

                inputNum : "",
                smsFlg : false,
                timer : "",
                count : 180,
                joinFlg : false, // 문자 인증 유무
                ranStr : "" // 문자 인증 번호
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnIdCheck: function () {
                let self = this;

                const regexId = /^[a-z0-9]*$/;
                if(!regexId.test(self.id)){
                    alert("숫자, 영문자를 사용해주세요.");
                    return;
                }

                if(self.id.length<5){
                    alert("id는 최소 5글자여야 합니다.");
                    return;
                }

                let param = {
                    id : self.id
                };

                $.ajax({
                    url: "/member/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        // alert(data.msg);
                        if(data.result == "true"){
                            alert("이미 사용중인 아이디 입니다.");
                            self.idFlg = false;
                        } else {
                            alert("사용 가능한 아이디 입니다");
                            self.idFlg = true;
                        }
                    }
                });
            },

            fnPwdCheck : function () {
                let self = this;

                const regexPwd = /^[a-zA-Z0-9{}\[\]\/?.,;:|)*~`!^\-_+<>@#$%&\\=('""]+$/;
                if(!regexPwd.test(self.pwd)){
                    alert("영소문자, 영대문자, 숫자, 특수문자만 사용해주세요.");
                    return;
                } else {
                    // alert("a");
                }

                if(self.pwd.length<6){
                    alert("비밀번호는 최소 6자리여야 합니다.");
                    self.pwdFlg = false;
                    return;
                }

                if(self.pwd != self.pwd2){
                    alert("비밀번호가 다릅니다.");
                    self.pwdFlg = false;
                    return;
                } else {
                    alert("확인되었습니다.");
                    self.pwdFlg = true;
                }
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
                            self.ranStr = data.ranStr;
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
                    if(self.count == 0) {
                        clearInterval(interval);
                        alert("시간이 만료되었습니다.");
                    } else {
                        let min = parseInt(self.count / 60);
                        let sec = self.count % 60;

                        min = min < 10 ? "0" + min : min;
                        sec = sec < 10 ? "0" + sec : sec;
                        
                        self.timer = min + " : " + sec;

                        self.count--;
                    }
                }, 1000);
            },

            fnSmsAuth : function () {
                let self = this;
                if(self.ranStr == self.inputNum){
                    alert("문자인증이 완료되었습니다.");
                    self.joinFlg = true;
                } else {
                    alert("문자인증에 실패했습니다.");
                }
            },

            fnJoin : function () {
                let self=this;
                if(!self.idFlg){
                    alert("id 중복 체크를 진행해주세요.");
                    return;
                }

                if(self.pwd.length<6){
                    alert("비밀번호는 최소 6자리여야 합니다.");
                    self.pwdFlg = false;
                    return;
                }

                // if(self.pwd != self.pwd2){
                //     alert("비밀번호가 다릅니다.");
                //     self.pwdFlg = false;
                //     return;
                // } else {
                //     alert("확인되었습니다.");
                //     self.pwdFlg = true;
                // }
                if(!self.pwdFlg){
                    alert("비밀번호 확인을 완료해주세요.");
                    return;
                }

                if(self.name==""){
                    alert("이름을 입력해주세요.");
                    return;
                }
                if(self.addr==""){
                    alert("주소를 입력해주세요.");
                    return;
                }
                if((self.phone1.length!=3 || self.phone1!="010") || self.phone2.length!=4 || self.phone3.length!=4){
                    alert("정상적인 전화번호를 입력해주세요.");
                    return;
                }

                //문자 인증이 완료되지 않으면
                //회원가입 불가능 (안내문구 출력)
                // if(!self.joinFlg){
                //     alert("문자 인증을 진행해주세요.");
                //     return;
                // }
                
                let param={
                    id : self.id,
                    pwd : self.pwd,
                    name : self.name,
                    addr : self.addr,
                    phone : self.phone1 + "-" + self.phone2 + "-" + self.phone3, //`${self.phone1}-${self.phone2}-${self.phone3}` 
                    gender : self.gender,
                    status : self.status
                }
                // console.log(param);

                // const regId = /[a-z0-9]/;
                // if(regId.test(param.id)){
                //     alert("a");
                // }
                $.ajax({
                    url: "/member/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        // console.log(data);
                        if(data.result == "success"){
                            alert("가입되었습니다.");

                            // var form = new FormData();
                            // form.append( "file1",  $("#file1")[0].files[0] );
                            // form.append( "userId",  data.userId); // 임시 pk
                            // self.upload(form);  
                            
                            // location.href="/member/login.do";
                        } else {
                            alert("오류가 발생했습니다.");
                        }
                    }
                });
                
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
            window.vueObj = this;
        }
    });

    app.mount('#app');
</script>