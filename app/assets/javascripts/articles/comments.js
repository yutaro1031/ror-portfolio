$(window).on('load', function() {
    $(document).on('ajax:success', "#ajax-form-comment", function(e) {
        if (e.detail[0].result === "ok") {
            $('#comments-list > ul').prepend(
                '<li class="media">' +
                    '<div class="media-body">' +
                        '<div id="media-head">' +
                            '<h5>' + e.detail[0].user_name + '</h5>' +
                            '<span>' + getNowTime() + '</span>' +
                        '</div>' +
                        e.detail[0].comment +
                    '</div>' +
                '</li>'
            );
            $('#comment-form').val("");
            $('#comment-notice').removeClass('hidden');
        } else {
            $('#comment-form').val("");
            $('#comment-alert').removeClass('hidden');
        }

        function getNowTime() {
            let now = new Date();

            let year = now.getFullYear();
            let month = now.getMonth() + 1;
            let day = now.getDate();
            let hour = now.getHours();
            let minutes = now.getMinutes();
            return year + "年" + month + "月" + day + "日 " + hour + "時" + minutes + "分"
        }
    });

    let reader_menu = $('.reader_menu');
    reader_menu.on('click', function(e) {
        e.preventDefault();
        let index = reader_menu.index(this);
        reader_menu.eq(index).parent().children('ul').toggleClass('hidden');
    });

    $(document).on('ajax:success', ".delete_comment", function(e) {
        if (e.detail[0].result === "ok") {
            let index = e.detail[0].index;
            reader_menu.eq(index).parents('.media').html(
              '<div class="alert alert-danger comment_delete_notice">コメントを削除しました</div>'
            );
        } else {
            console.log('error');
        }
    });
});