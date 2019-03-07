$(document).on('turbolinks:load', function() {
    // 画像のプレビュー
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#eyecatch_img_prev').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $(".post-img").change(function() {
        $('#eyecatch_img_prev').removeClass('hidden');
        $('.eyecatch_present_img').remove();
        readURL(this);
    });

    // 自動保存機能
    function ajaxAutoSave(form_id) {
        if (typeof form_id == 'undefined') {
            Rails.fire($('#ajax-form-tmp')[0], "submit");
            $('.saving').removeClass('hidden');
        } else {
            Rails.fire($(form_id)[0], "submit");
        }
    }

    // 5秒後に自動保存(ページ遷移時に保存されないように即停止)
    var timer_id = setTimeout(ajaxAutoSave, 5000);
    clearTimeout(timer_id);

    // 記事を編集するごとにsetTimeoutをリセット
    $('#ajax-form-tmp > .form-group').on('change',function() {
        clearTimeout(timer_id);
        timer_id = setTimeout(ajaxAutoSave, 5000);
    });

    $('#ajax-form-image > .form-group').on('change',function() {
       ajaxAutoSave('#ajax-form-image');
    });

    //  CKEditorにおける自動保存
    CKEDITOR.on('instanceReady', function(e) {
        var editor = e.editor;

        editor.on('change', function() {
            clearTimeout(timer_id);
            timer_id = setTimeout(ajaxAutoSave, 5000);
        });
    });

    $(document).on('ajax:success', "#ajax-form-tmp", function(e) {
        $('.saving').addClass('hidden');
        if (e.detail[0].result === "ok") {
            $('.saved').removeClass('hidden');
            $('.now-time').html(getNowTime());
        } else {
            $('.failed-save').removeClass('hidden');
            $('.now-time').html(getNowTime());
        }
    });

    $(document).on('ajax:success', "#ajax-form-image", function(e) {
        console.log(e.detail[0].result);
    });

    $(document).on('ajax:success', "#ajax-form-publish", function(e) {
        console.log(e.detail[0].result);
    });

    function getNowTime() {
        var now = new Date();

        var month = now.getMonth() + 1;
        var day = now.getDate();
        var hour = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();
        return "(" + month + "/" + day + " " + hour + ":" + minutes + ":" + seconds + ")"
    }

});