//관람 인원을 선택해주세요. 아무곳이나 클릭시 창 닫힘
$(function () {
    $(document).click(function () {
        $(".seat-count-before").addClass('off');
    });
    /* 티켓 구매 */
    $(window).ready(function () {
        //console.log($("span.movie-graseat-resultde").text().split(" ")[0]);
        if ($("span.movie-graseat-resultde").text().split(" ")[0] == '12') {
            $("span.movie-graseat-resultde").empty().append("12세 이상 관람가");
        } else if ($("span.movie-graseat-resultde").text().split(" ")[0] == '15') {
            $("span.movie-graseat-resultde").empty().append("15세 이상 관람가");
        } else if ($("span.movie-grade").text().split(" ")[0] == '청소') {
            $("span.movie-graseat-resultde").empty().append("청소년 관람 불가");
        }
        var ticket_movieTime = $('#nextParam').text();
        var listInfo1 = { "ticket_movieTime": ticket_movieTime };
        $.ajax({
            url: '/Megabox/SeatCheckDAO',
            type: 'POST',
            dataType: 'text',
            data: listInfo1,
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (seatCK) {
                seatCK = seatCK.split("x")[1];
                var seatlist = seatCK.split(" ");
                //console.log(seatCK);
                //console.log($("button.seat-condition").eq(5).attr("title"));
                for (var i = 0; i < seatlist.length; i++) {
                    for (var a = 0; a < $("button.seat-condition").length; a++) {
                        if (seatlist[i] == $("button.seat-condition").eq(a).attr("title").split(" ")[0]) {
                            $("button.seat-condition").eq(a).addClass("seat-condition finish");
                        }
                    }
                }

            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });

    });

    $(document).on("click", "a#pageNext", function () {
        var ticket_movieTime1 = $('#nextParam').text();
        var userid = $('#userid').text();
        var seat1 = $('.my-seat').children().eq(0).text();
        var seat2 = $('.my-seat').children().eq(1).text();
        var seat3 = $('.my-seat').children().eq(2).text();
        var seat4 = $('.my-seat').children().eq(3).text();
        var seat5 = $('.my-seat').children().eq(4).text();
        var seat6 = $('.my-seat').children().eq(5).text();
        var seat7 = $('.my-seat').children().eq(6).text();
        var seat8 = $('.my-seat').children().eq(7).text();


        var listInfo = { "ticket_movieTime": ticket_movieTime1, "userid": userid, "seat1": seat1, "seat2": seat2, "seat3": seat3, "seat4": seat4, "seat5": seat5, "seat6": seat6, "seat7": seat7, "seat8": seat8 };
        $.ajax({
            url: '/Megabox/SeatDAO',
            type: 'POST',
            data: listInfo,
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function () {
                alert("예매가 완료되었습니다.");
                $(location).attr('href', 'mainpage.jsp');
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        });

    });
});

var adult = Number(0);
var children = Number(0);
var disabled= Number(0); //우대 
var total = Number(0); //총 인원 카운트 
var price = Number(0);
var seatCnt = Number(0); //선택된 좌석 수 카운트

function SeatRowChange(total) {
    //짝수 홀수 좌석 라인 변경
    if (total == 1) {
        for (var i = 0; i < 20; i++) {
            $("button[seatno=" + (2 * i + 1) + "]").addClass("seat-condition impossible");
        }
    } else {
        for (var i = 0; i < 20; i++) {
            $("button[seatno=" + (2 * i + 1) + "]").removeClass("seat-condition impossible");
            $("button[seatno=" + (2 * i + 1) + "]").addClass("seat-condition common");
        }
    }
}
function PlusPeople(kind) {
    switch (kind) {
        case 'adult':
            console.log('kind ' + kind);
            adult++;
            $(".now.adult").text(adult);
            break;
        case 'disabled':
            console.log('kind ' + kind);
            disabled++;
            $(".now.disabled").text(disabled);
            break;
        default:
            console.log('kind ' + kind);
            children++;
            $(".now.children").text(children);
            break;
    }
}
function MinusPepole(kindnum) {
    var kindname = kindnum;
    console.log(kindname);
    switch (kindname) {
        case 'adult':
            kindnum = adult;
            break;
        case 'disabled':
            kindnum = disabled;
            break;
        default:
            kindnum = children;
            break;
    }
    //0명 이하는 지정할 수 없음
    if (kindnum === 0) return false;
    //선택된 좌석이 있을때 인원 수 감소시 초기화 됨
    if (seatCnt > 0) {
        $("#layerId_030983947233653875").show();
        $(".alertStyle").show();
        $(".lyclose").click(function () {
            $("#layerId_030983947233653875").hide();
            $(".alertStyle").hide();
            return false;
        }); $(".btn-layer-close").click(function () {
            $("#layerId_030983947233653875").hide();
            $(".alertStyle").hide();
            return false;
        });
        SeatReset();
    }
    else {
        kindnum = Number(kindnum) - 1;
        console.log('kindnum 값 : ' + kindnum);
        switch (kindname) {
            case 'adult':
                adult--;
                break;
            case 'disabled':
                disabled--;
                break;
            default:
                children--;
                break;
        }
        $('.' + kindname).text(kindnum);
    }

}
function SeatReset() {
    $('#layerId_030983947233653875 > div > div > div > button.button.purple.confirm').click(function () {
        $("#layerId_030983947233653875").hide();
        $(".alertStyle").hide();
        /*변수 초기화 */
        adult = 0;
        children = 0;
        disabled= 0;
        total = 0;
        price = 0;
        seatCnt = 0;

        /*버튼 값 초기화*/
        $(".adult").text(adult);
        $(".children").text(children);
        $(".disabled").text(disabled);

        /*selected 좌석 해제*/
        $("button[selected]").removeClass("seat-condition on choice").addClass("seat-condition common").removeAttr("selected");

        /* 가격과 인원정보 */
        price = Number(adult * 11000 + children * 9000 + disabled* 5000);
        $(".money").children().eq(0).text(price);
        if ($(".pay-area>.count").children.length != 0) {
            $(".pay-area>.count").empty();
        }
        /* 좌석 */
        $('.my-seat').children().css("background-color", "#333333").text("-");
    })
}

/* 좌석,인원 초기화 */
$(function () {
    $("#seatMemberCntInit").click(function () {
        $("#layerId_030983947233653875").show();
        $(".alertStyle").show();
        $(".lyclose").click(function () {
            $("#layerId_030983947233653875").hide();
            $(".alertStyle").hide();
        }); $(".btn-layer-close").click(function () {
            $("#layerId_030983947233653875").hide();
            $(".alertStyle").hide();
        });
        //확인시 reset 
        SeatReset();
    });
})
/* 인원 증감 */
$(function () {
    $("button.up").click(function () {
        if (total === 8) {
            alert("인원은 8명까지 선택 가능합니다.");
            return false;
        }
        PlusPeople($(this).attr("id"));
        total = Number(adult + children + disabled);
        price = Number(adult * 11000 + children * 9000 + disabled* 5000);
        $('.my-seat').children().eq((total - 1)).css("background-color", "#54565B").text("-");
        SeatRowChange(total);
    });
    $("button.down").click(function () {
        var kind = $(this).attr("id");
        MinusPepole(kind);
        total = Number(adult + children + disabled);
        price = Number(adult * 11000 + children * 9000 + disabled* 5000);
        $('.my-seat').children().eq((total)).css("background-color", "#333").text("-");
        SeatRowChange(total);
    });

});

/* 좌석 선택 */
var seatnum = null; //A17의 '17'
var row = null; //A17의 'A'
function IsOverTotal(total, seatCnt) {
    //초과된 인원 선택 
    if (total <= seatCnt) {
        $('.alertStyle').show();
        $("#layerId_08010659137218192").show();

        $(".btn-layer-close").click(function () {
            $(".alert-popup").hide();
            $(".alertStyle").hide();
        });
        $("#layerId_08010659137218192 > .wrap > .layer-con >.btn-group > .confirm").click(function () {
            console.log("초과된 인원 확인");
            $(".alert-popup").hide();
            $(".alertStyle").hide();
        });
        return true;
    }
}
function IsImpossible(seat){
    if(seat.hasClass('impossible'))
        return true;
}
function IsFinishSeat(seat) {
    if (seat.hasClass('finish') === true) 
        return true;
}
function DeleteSelected(seat) {
    seatnum = Number(seat.attr("seatno"));
    row = seat.attr("rownm");
    if (seatnum % 2 == 1) {
        $("button[rownm=" + row + "][seatno=" + seatnum + "]").removeClass("on choice").removeAttr("selected");
        $("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").removeClass("on choice").removeAttr("selected");
    }
    else {
        $("button[rownm=" + row + "][seatno=" + seatnum + "]").removeClass("on choice").removeAttr("selected");
        $("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").removeClass("on choice").removeAttr("selected");
    }
}
function UpdateSeatInfo() {
    console.log("좌석 정보");
    //좌석 우선 초기화 
    for (var j = 0; j < seatCnt; j++) {
        $('.my-seat').children().eq(j).css("background-color", "#54565B").text("-");
    }
    //우측 좌석 정보 표 
    $('button[selected="selected"]').each(function (index, item) {
        item = $(this).attr("rownm") + $(this).attr("seatno");
        $('.my-seat').children().eq(index).css("background-color", "#503396").text(item);
    });
}
function UpdatePriceInfo() {
    $(".money").children().eq(0).text(price);
    if ($(".pay-area>.count").children.length != 0) {
        $(".pay-area>.count").empty();
    }
    if (adult > 0) {
        $(".pay-area>.count").append("<span>" + "성인" + "<em>" + adult + "</em></sapn>");
    } if (children > 0) {
        $(".pay-area>.count").append("<span>" + "청소년" + "<em>" + children + "</em></sapn>");
    } if (disabled> 0) {
        $(".pay-area>.count").append("<span>" + "우대" + "<em>" + disabled+ "</em></sapn>");
    }
}
$(function () {
    $("button.jq-tooltip").on({
        mouseover: function () {
            seatCnt = $("button[selected='selected']").length; //선택된 좌석의 수
       
            if (total === 1) {
                if (!IsImpossible($(this)))
                    $(this).addClass("seat-condition on");
            }
            if (total >= 2) {
                if ((total - seatCnt) === 1) {
                    if (!IsImpossible($(this)))
                        $(this).addClass("seat-condition on");
                } else {
                    seatnum = Number($(this).attr("seatno"));
                    row = $(this).attr("rownm");
                    if (seatnum % 2 == 1) {
                        if (!$("button[rownm=" + row + "][seatno=" + seatnum + "]").hasClass('finish')){
                            $("button[rownm=" + row + "][seatno=" + seatnum + "]").addClass("seat-condition on");
                        }
                        if (!$("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").hasClass('finish')){
                            $("button[rownm=" + row + "][seatno=" + (seatnum + 1) + "]").addClass("seat-condition on");
                        }       
                    }
                    else {
                        if (!$("button[rownm=" + row + "][seatno=" + seatnum + "]").hasClass('finish'))
                            $("button[rownm=" + row + "][seatno=" + seatnum + "]").addClass("seat-condition on");
                        if (!$("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").hasClass('finish'))
                            $("button[rownm=" + row + "][seatno=" + (seatnum - 1) + "]").addClass("seat-condition on");
                    }
                }
            }
        },
        click: function () {
            if (total === 0) {
                alert("인원을 먼저 선택해 주세요!");
                return false;
            }
            if ($(this).is('[selected]')) {
                DeleteSelected($(this));
                UpdateSeatInfo();
            }
            seatCnt = $("button[selected='selected']").length;
            if (total === 1 || total - seatCnt === 1) {
                if(IsOverTotal(total, seatCnt))return false; //초과인원 선택했는지? 
                if(IsFinishSeat($(this)))return false;
                $(this).attr("selected", "selected").addClass("seat-condition choice").removeClass('on');
                seatCnt = $("button[selected='selected']").length;
            } else {
                if(IsOverTotal(total, seatCnt))return false; //초과인원 선택했는지? 
                if(IsFinishSeat($(this)))return false;
                $('.on').attr("selected", "selected").addClass("seat-condition choice").removeClass('on');
            }
            UpdateSeatInfo();
            UpdatePriceInfo();
        },
        mouseleave: function () {
            $('.on').removeClass("on").addClass("common");
        }
    });
})