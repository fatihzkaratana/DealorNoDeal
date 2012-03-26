var trigger=false,      //  trigger checks the rotation complete and let the user pick stake prices
dflag = false,      //  dflag checks the default stake value and controller the return value
dId,                //  dId defines the default stake value box
dValue,             //  dValue returns the deposit value to the game and database
offerFlag = 0,           //  addValue defines the stake will be added the total amount
i = 0,
totalDeposit = 0,   //  totalDeposit controls the total stake amount if is 50 or not
betList = "",       //  betList defines which rates are chosen by the user and added to the my bets lits
picked,
boxCount = 0,
nextOffer = 4,
logVar = 0,
sec = 0,
count = 59,
countText = "";
    
$.startGame = function(params){
    try{
        jQuery.fx.off = true;
        $.runLoader(2);
        offerFlag = 0;
        //setInterval("checkconn()", 9000);
        $('#depositBox').fadeIn(100);
        $('#depositBox input.button').each(function(){
            $(this).click(function(){
                $.makeDeposit($(this))
                });
        });
        if ( $.getTrigger()){
            $.setTrigger(false);
        }
        if ( $.getDflag() ){
            $.setDflag(false);
        }
        dflag = true;
        dValue = 0;
        $('#boxWrapper .box a').click(function(){
            $.chooseBox($(this))
            });
    }catch(err){
        console.log("Error occured on startGame: " + err);
    }
}

/*
 *  @function makeDeposit is a method to implement depositing the amount when the deposit button hitted
 *
 */
$.makeDeposit = function(button){
    try{
        $('#depositBox').fadeOut(500);
        try{
            $.post("includes/controller/check.jsp",
            {
                tableid: $(button).attr("id"),
                tablevalue: $(button).val()
            },function(data){
                console.log(data + " responded");
            }, "json")
            .success(function(data){
                /*if (data.check == 1){
                        $.loadExisting(data.gameId);
                    }else{*/
                $.generateNew(data);
                sec = data.gameTime;
            /*}*/
            })
            .error(function(data){
                console.log("Error occured on checkPreviousGame and returned value is: " + data);
            });
        }catch(err){
            console.log("Error occured on checkPreviousGame: " + err);
            setTimeout("$.checkPreviousGame()", 5000);
        }
    }catch(err){
        console.log("Error occured on makeDeposit: " + err);
    }
}

$.loadExisting = function(data){
    
    }

$.generateNew = function(data){
    var gameId = 0;
    console.log("Generating new game..." + data.gameId);
    try{
        delay = $.callObjects('#container .box',"inline-block");
        var i=0;
        $('h3.price').each(function(){
            $(this).html( data.rates[i]);
            i++;
        });
        $("#gameInfo h3#gameId").html("<span class=\"text\">Game ID:</span><br><span id=\"gId\">" + data.gameId + "</span>");
        timer = setInterval(function(){
            $.countDown(sec,"#timer");
        },1000);
        setTimeout(function(){
            $.showNotice("#notificationBar","Oyunumuza hoşgeldiniz. Lütfen kutunuzu seçiniz.", true);
            $('#selectionBar').show('slide');
            $.setNotice('#selectionBar',"");
        },delay);
    }catch(err){
        console.log("Error occured on checkPreviousGame: " + err);
        setTimeout("$.checkPreviousGame()", 5000);
    }
    return gameId;
}

/*
 *  @function choosePrice is a method to define default stake rate from one of 1,2,3,4,5,10
 *  @param box is the parameter to define which object will be used
 *
 */
$.chooseBox = function(box){
    try{
        var selection;
        selection = $(box).html();
        if ( $.getTrigger() && !$.getDflag()){
            $.post("includes/controller/choose.jsp",
            {
                option: "choose",
                value: selection,
                gameId: $("#gameInfo h3#gameId span#gId").html()
            },function(data){
                console.log(data + "responded");
            },"json")
            .success(function(){
                $('div#box-' + selection).fadeOut(2000,function(){
                    $('div#box-'+ selection).removeClass('active');
                    $.callObjects('#container li.item',"block");
                    $.showNotice("#notificationBar","\"" + selection + "\" numaralı kutuyu seçtiniz. Teşekkür ederiz.",false);
                    $('#selectedBox h3').html(""+selection);
                    $('#selectedBox').fadeIn(1000);
                    $('#notificationBar h3').fadeOut(1000,function(){
                        setTimeout(function(){
                            $.setNotice('#notificationBar','Kutuları açmaya başlayabilirsiniz. İyi şanlar!', true);
                            $.setNotice('#selectNotification',"\"" + selection + "\" numaralı kutuyu seçtiniz.");
                            $.setTrigger(false);
                            $.setDflag(true);
                        },5000);
                    });
                });
            })
            .error(function(){
                console.log("Error occured on posting chooseBox and data " + data + "responded with an error");
            })
        }else if( !$.getTrigger() && $.getDflag() ){
            $.setDflag(false);
            $('#boxWrapper').animate(
            {
                opacity: .3
            },1000,"linear", 
            function()
            { 
                $('#box-'+selection).fadeOut(500);
                $('#box-'+selection).removeClass('active');
                $.increaseOfferFlag();
                $.openSelected(selection);
            }
            );
        }
    }catch(err){
        console.log("Error occured on chooseBox: " + err);
    }
}

$.openSelected = function(selection){
    try{
        $('#openBox h3#boxNumber').html(selection);
        boxCount++;
        $.post("includes/controller/choose.jsp",
        {
            option: "open", //box opening
            value: selection, //box no
            gameId: $("#gameInfo h3#gameId span#gId").html(),
            boxused: boxCount
        },function(data){
            console.log(data + " responded");
        },"json")
        .success(function(data){
            $.openBox(data,selection);
        })
        .error(function(data){
            console.log("There is an error to connect with the server!" + " Data responded: " + data );
        /*setTimeout(function(){
                    $.openSelected(selection);
                }, 5000);*/
        });
             
    }catch(err){
        console.log("Error occured on openSelected: " + err);
    }
}

$.releaseList = function(data,selection){
    var id = 0;
    $('.price').each(function(){
        if ( $(this).html() == data ){
            id = $(this).attr("id").split("-");
            id = id[1];
            $('li#number-' + id).hide('slide',function(){
                $('li#number-' + id).addClass('pickedNumber')
                .append('<h4 class="pickedBox">'+selection+'</h4>')
                .show('slide');
            });
        }
    });
}

$.openBox = function(data,selection){
    $('#openBoxWrapper').fadeIn(1000,function(){
        $('#openBox').fadeIn(500,function(){
            setTimeout(function(){
                $('#openBox #cover').animate(
                {
                    backgroundPosition: '-8px -813px',
                    height: '103',
                    top: '175'
                }, 100,
                function(){
                    $('#openBox #cover h3').html((data.rate));
                    $.releaseList((data.rate),selection);
                    $.setNotice('#notificationBar', 'Kutunuz açılıyor lütfen bekleyiniz!');
                    $('#openBox #cover h3').fadeIn(500,function(){
                        setTimeout(function(){
                            $('#openBox #cover h3').fadeOut(500,function(){
                                $('#openBox #cover').animate({
                                    backgroundPosition: '-6px 0px',
                                    height: '25',
                                    top: '255'
                                },100,function(){
                                    $('#openBox').fadeOut(500,function(){
                                        $('#openBoxWrapper').fadeOut(500,function(){
                                            if ( ($.getOfferFlag() % 4 == 0) && ($.getOfferFlag() != 0) ){
                                                $.makeOffer(data);
                                            }else{
                                                $('#boxWrapper').animate({
                                                    opacity: 1
                                                },500, function(){
                                                    $.setNotice('#notificationBar', 'Lütfen yeni bir kutu seçiniz.');
                                                    $.setNotice('#boxLeft', $('#boxWrapper .active').length + " " + "Kutunuz kaldı");
                                                    $.setDflag(true);
                                                    setTimeout(function(){
                                                        $.setNotice('#notificationBar', 'NicoBank\'ın teklifine ' + data.nextOffer  + ' kutu kaldı!');
                                                    }, 2000);
                                                });
                                            }
                                        });
                                    });
                                });
                            });
                        },3000);
                    });
                });
            }, 500
            );
        });
    });
}

$.makeOffer = function(e){
    try{
        $.post("includes/controller/choose.jsp",
        {
            option: "offer", //box opening
            value: e.selection, //box no
            gameId: $("#gameInfo h3#gameId span#gId").html(),
            boxused: boxCount
        },function(data){
            console.log(data.success + "responded");
            console.log(data);
        }, "json")
        .success(function(data){
            $('#offerBox').fadeIn(500,function(){
                $('#offerBox h3#bankOfferVal').html(data.offer);
                $.setNotice('#notificationBar', 'NicoBank\'ın teklifini kabul ediyor musunuz?');
                $('input#acceptOffer').click(function(){
                    $.acceptOffer(e.selection, e.rate, data.offer)
                    });
                nextOffer = data.nextOffer;
                $('input#declineOffer').click(function(){
                    $.declineOffer(data.offer,nextOffer)
                    });
            });
        });
    }catch(err){
        console.log("Error occured on declineOffer: " + err);
        setTimeout(function(){
            $.makeOffer(data);
        },5000);
    }
}

$.acceptOffer = function(box, rate, offerValue){
    try{
        $.post("includes/controller/choose.jsp",
        {
            option: "accept",
            value: offerValue,
            gameId: $("#gameInfo h3#gameId span#gId").html()
        },function(data){
            console.log(data.success + "responded");
            console.log(data.values);
        }, "json")
        .success(function(data){
            $('#offerBox').fadeIn(500,function(){
                $('#offerBox h3#bankOfferVal').html(data.offer);
                $.setNotice('#notificationBar', 'NicoBank\'ın teklifini kabul ettiniz. Teklifiniz bakiyenize yansıtılacaktır.');
                $.showReplayDialog();
                $('input#acceptReplay').click(function(){
                    $.startGame()
                    });
                $('input#declineReplay').click(function(){
                    windows.close();
                });
            });
        });
    }catch(err){
        console.log("Error occured on acceptOffer: " + err);
    }
}

$.declineOffer = function(offerValue){
    try{
        $.post("includes/controller/choose.jsp",
        {
            option: "decline",
            value: offerValue,
            gameId: $("#gameInfo h3#gameId span#gId").html()
        },function(data){
            console.log(data.success + "responded");
        }, "json")
        .success(function(data){
            if ( ($.getOfferFlag() == 16) && ($.getOfferFlag() != 0) ){
                $.openUserBox();
            }else{
                $('#offerBox').fadeOut(500,function(){
                    $('#offerBox h3#bankOfferVal').html(" ");
                    $('#boxWrapper').animate({
                        opacity: 1
                    },500,function(){
                        $.setNotice('#notificationBar', 'Lütfen yeni bir kutu seçiniz.');
                        $.setNotice('#boxLeft', $('#boxWrapper .active').length + " " + "Kutunuz kaldı");
                        $.setDflag(true);
                    });
                });
            }
        });
    }catch(err){
        console.log("Error occured on declineOffer: " + err);
    }
}

$.openUserBox = function(){
    try{
        $.post("includes/controller/choose.jsp",
        {
            option: "userbox",
            value: $("#selextedBox h3#selection").html(),
            gameId: $("#gameInfo h3#gameId span#gId").html()
        },function(data){
            console.log(data.success + "responded");
        }, "json")
        .success(function(data){
            $.setNotice('#notificationBar', 'Oyunu bitirdiniz. Kutunuz açılıyor.');
            $.setDflag(false);
            $('#offerBox').fadeOut(500,function(){
                $('#offerBox h3#bankOfferVal').html(" ");
                $('#boxWrapper').animate({
                    opacity: 1
                },500,function(){
                    $('#openBoxWrapper').fadeIn(1000,function(){
                        $('#openBox').fadeIn(500,function(){
                            setTimeout(function(){
                                $('#openBox #cover').animate(
                                {
                                    backgroundPosition: '-8px -813px',
                                    height: '103',
                                    top: '175'
                                }, 100,
                                function(){
                                    $('#openBox #cover h3').html(data.rate);
                                    $.releaseList(data.rate,data.selection);
                                    $.setNotice('#notificationBar', 'Kutunuz açılıyor lütfen bekleyiniz!');
                                    $('#openBox #cover h3').fadeIn(500,function(){
                                        setTimeout(function(){
                                            $('#openBox #cover h3').fadeOut(500,function(){
                                                $('#openBox #cover').animate({
                                                    backgroundPosition: '-6px 0px',
                                                    height: '25',
                                                    top: '255'
                                                },100,function(){
                                                    $('#openBox').fadeOut(500);
                                                });
                                            });
                                        },3000);
                                    });
                                });
                            }, 500
                            );
                        });
                    });
                });
            });
        });
    }catch(err){
        console.log("Error occured on declineOffer: " + err);
    }
    console.log("open user box");
}

$.showReplayDialog = function(){
    $('#offerBox').fadeOut(500,function(){
        $('#acceptBox').fadeIn(500);
    })
}

/*
 *  @function callObjects is a method to display with animation any class objects
 *  @param label class item will be shown
 *  @param display css attribute to decide with object will has display attr
 */

$.callObjects = function(label,display) {
    try{
        var delay = 500;
        $(label).each(function () {
            delay = delay + 100;
            var li = $(this);
            setTimeout(function () {
                li.fadeIn(delay).css("display",display);
            }, delay);
        });
    }catch(err){
        console.log("Error occured on callObjects: " + err);
    }
}

/*
 *  @function showNotice is a method to load any notification with an animation at any selected object
 *  @param obj is the object where the notice will be shown
 *  @param notice
 *  @param triggerOption
 */
$.showNotice = function(obj, notice, triggerOption){
    try{
        $(obj).show('slide');
        if ( notice != "" ){
            $(obj + " h3").hide();
            $(obj + " h3").html("");
            setTimeout(function(){
                $(obj + " h3").html(notice).fadeIn(500);
            },500);
            $.setTrigger(triggerOption);
        }
    }catch(err){
        console.log("Error occured on showNotice: " + err);
    }    
}
$.setNotice = function(obj, notice){
    try{
        if ( notice != "" ){
            $(obj + " h3").hide();
            $(obj + " h3").html("");
            setTimeout(function(){
                $(obj + " h3").html(notice).fadeIn(500);
            },500);
        }
    }catch(err){
        console.log("Error occured on showNotice: " + err);
    }    
}

$.setTrigger = function(option){
    this.trigger = option;
}
$.getTrigger = function(){
    return this.trigger;
}

$.setDflag = function(option){
    this.dflag = option;
}
$.getDflag = function(){
    return this.dflag;
}
$.setPicked = function(selection){
    this.picked = selection;
}
$.getPicked = function(){
    return this.picked;
}
$.increaseOfferFlag = function(){
    offerFlag++;
}
$.getOfferFlag = function(){
    return offerFlag;
}

/*
 * @function $.countDown is a method to create a countdown timer with its parameter lim
 */
$.countDown = function(){
    try{
        if ( count < 0 ) count = 59;
        if  ( count < 10 ) countText = "0" + count;
        else countText = "" + count;
        if ( sec > 0 ){
            if ( parseInt(sec) >= 541 ){
                $('#timer').html("<span class=\"counter\">9</span>:" + countText);
            }else if ( parseInt(sec) >= 481 ){
                $('#timer').html("<span class=\"counter\">8</span>:" + countText);
            }else if ( parseInt(sec) >= 421 ){
                $('#timer').html("<span class=\"counter\">7</span>:" + countText);
            }else if ( parseInt(sec) >= 361 ){
                $('#timer').html("<span class=\"counter\">6</span>:" + countText);
            }else if( parseInt(sec) == 301 ){
                $.setNotice('#notificationBar', 'Oyunu tamamlamak için 5 dakikanız kaldı! ');
            }else if ( parseInt(sec) >= 301 ){
                $('#timer').html("<span class=\"counter\">5</span>:" + countText);
            }else if ( parseInt(sec) >= 241 ){
                $('#timer').html("<span class=\"counter\">4</span>:" + countText);
            }else if ( parseInt(sec) >= 181 ){
                $('#timer').html("<span class=\"counter\">3</span>:" + countText);
            }else if ( parseInt(sec) < 181 &&   parseInt(sec) >= 121){
                $('#timer').html("<span class=\"counter\">2</span>:" + countText);
            }else if ( parseInt(sec) < 121 &&   parseInt(sec) >= 61){
                $('#timer').html("<span class=\"counter\">1</span>:" + countText);
            }else if( sec <= 59 && sec >= 0 ){
                $('#timer').html("<span class=\"counter\">0</span>:" + countText);
                if( sec <= 0 ){
                    $('#timer').html("<span class=\"counter\">Time out</span>");
                    if ( $.getTrigger() ){
                        $.setTrigger(false);
                    }
                    if ( $.getDflag() ){
                        $.setDflag(false);
                    }
                }
            }
            count--;
            sec--;
        }else{
            clearInterval(timer);
            //what if time is going down faster? no it is not if so is it then make it quick
            setTimeout(function(){
                $.logout();
            },3000)
        }
    }catch(err){
        $.showErrorPage();
        console.log("There is an error on countDown: " + err);
        setTimeout("$.startGame()",5000);
    }
}

$.logout = function(){
    try{
        $('#boxWrapper').fadeOut(1000,function(){
            $.setNotice('#notificationBar', '');
            $.post("includes/controller/logout.jsp",
            {
                option: "logout",
                gameId: $("#gameInfo h3#gameId span#gId").html()
            },
            function(data){
                console.log("Response returned: " + data );
            },"json")
            .success(function(data){
                $('#logoutBox').fadeIn(500);
                setTimeout(function(){
                    window.location="index.jsp";
                },3000);
            })
            .error(function(data){
                console.log("There is a connection error on logout: " + err);
                setTimeout(function(){
                    $.logout()
                    }, 5000);
            });
        });
    }catch(err){
        console.log("Error occured on logout: " + err);
        setTimeout(function(){
            $.logout()
            }, 5000);
    }
}

$.runLoader = function(lim){
    try{
        //$.countDown(lim,'#loader label');
        setTimeout(function(){
            $('#overlay').fadeOut(1000);
        },(lim*1000));
        jQuery.fx.off = false;
    }catch(err){
        console.log("Error occured on runLoader" + err);
    }
}

/*
 * @function run_script
 * 
 */
function runScript(xasync, xurl,xdata){
    xwaitajax = xasync;
    try{
        $.ajax({
            url: xurl,
            data: xdata,
            async: true,
            global: false,
            cache: false,
            type: "POST",
            dataType: "script",
            timeout: 3000,
            success: function(data) {
                var veri = jQuery.trim(data);
                xservererror = 0;
                if (veri.length > 3 ) {
                    console.log(veri);
                }
                runafter();
            },
            error:function (xhr, ajaxOptions, thrownError){
               
                if (parseInt(xhr.status) > 0) {
                    xservererror = xservererror + 1;
                    if (xservererror > 4) {
                        openmesaj(xurl+'<br>'+xhr.status+' - '+ xhr.statusText+'<br>Oyun Ana Bilgisayarı ile bağlantınız kopmuştur.<br/> Lütfen sayfayı yenileyiniz.',2500);
                        xservererror = 0;
                    }
                }
            }
        });
    } catch(err){ 
        console.log("Error occured on runScript: " + err);
    }
    xwaitajax = true;
}