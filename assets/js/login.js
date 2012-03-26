$(document).ready(function(){
    setTimeout(function(){
        $("#notification").slideUp(1e3)
        },3e3);
    $.submitLogin();
})

$.submitLogin = function(){
    try{
        $("#formLogin").submit(function(){
            console.log("form submitted");
            $("#overlay").fadeIn(1e3);
            if($("#username").val()==""||$("#password").val()==""){
                $("#overlay").fadeOut();
                setTimeout(function(){
                    $("#error").fadeIn(1e3)
                    },2e3)
                }else{
                    console.log("form will be posted");
                $.post("includes/controller/login.jsp",{
                    username:$("#username").val(),
                    password:$("#password").val()
                    },function(a){
                    console.log(a.success+" responded")
                    },"json")
                    .success(function(a){
                        console.log("function succeed");
                        if(a.success!="false"){
                            $("#overlay").fadeOut();
                            setTimeout(function(){
                                window.location="index.jsp"
                                },1e3)
                        }else{
                            $("#overlay").fadeOut();
                            setTimeout(function(){
                                $("#error").fadeIn(1e3)
                                },1e3)
                        }
                    })
                    .error(function(a){
                        console.log("There is an error to connect with the server: " + a );
                        $.submitLogin();
                    });
            }
            return false;
        })
    }catch(a){
    console.log(a)
    }
}